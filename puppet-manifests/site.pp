
node default {
  # Install node.js via https://forge.puppetlabs.com/willdurand/nodejs
  # See that url for installing multiple versions, and more options.
  class { 'nodejs':
      version => 'stable',
  }

  # Install ruby and ruby gems via https://github.com/puppetlabs/puppetlabs-ruby
  # This is needed to grab compass, etc.
  class { 'ruby':
      # Ubunutu doesn't use the default package names. See issue: https://github.com/puppetlabs/puppetlabs-ruby/pull/24
      ruby_package => 'ruby1.9.1',
      rubygems_package => 'ruby1.9.1-full',
  }
  # Install and setup avahi for broadcasting our domain over bonjour
  # eliminating the need to edit a hosts file.
  class { 'avahi':
        firewall => false
  }
  # This should make this domain available at domain other than angular-vm.local
  # There is no need to set this if alrady set in change the vagrant hostname settings
  # The change is not permanent so this can be changed whenever.
  # exec { 'sudo avahi-set-host-name angular-vm':
  #       require => [Class['avahi']],
  # }

  # Install our custom yoeman, grunt, etc configuration.
  include yeoman

  # Install git via: https://forge.puppetlabs.com/puppetlabs/git
  # More options are available for global configs etc.
  include git

  vcsrepo { '/vagrant/angular/base-angular-project':
      ensure   => present,
      provider => git,
      source => "https://github.com/frankcarey/base-angular-project.git"
  }

  # Install augeas via: https://forge.puppetlabs.com/camptocamp/augeas
  # This module apprently makes it easier to modify config files by creating a giant tree.
  # Required by composer for puppet < 3.0
  include augeas

  # Install composer via: https://forge.puppetlabs.com/tPl0ch/composer
  # We don't have the suhosin security patch, so we need this setting.
  class { 'composer':
    suhosin_enabled => false,
  }

  # Doh, it's not composer we need but npm to install package.json
  #composer::exec { 'base-angular-project-install':
  #  cmd => 'install',
  #  cwd => '/vagrant/angular/base-angular-project',
  #}

  exec { 'npm install':
        path    => '/usr/local/node/node-default/bin/',
        cwd     => '/vagrant/angular/base-angular-project',
        require => [Vcsrepo['/vagrant/angular/base-angular-project'],Class['nodejs']],
    }
}

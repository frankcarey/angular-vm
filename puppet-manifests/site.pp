
node default {
  # Set our paths globally so we don't have to add them each time.
  Exec { path =>   [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/node/node-default/bin/" ] }

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

  # Install augeas via: https://forge.puppetlabs.com/camptocamp/augeas
  # This module apprently makes it easier to modify config files by creating a giant tree.
  # Required by composer for puppet < 3.0
  include augeas

  # Install our custom yoeman, grunt, etc configuration.
  #include yeoman

  # Install git via: https://forge.puppetlabs.com/puppetlabs/git
  # More options are available for global configs etc.
  include git

  # Setup known_hosts so that keys work with private repos.
  ssh::resource::known_hosts { 'common-hosts':
      # CUSTOMIZE: Add hosts for additional private repo locations.
      hosts => 'github.com,bitbucket.org',
      user => 'vagrant',
  }

  # CUSTOMIZE: location of projects. Defaults to /vagrant/projects so that it's shared locally, don't use a trailing slash.
  $projects = '/vagrant/projects'

  # Create the projects directory.
  file { $projects :
        ensure => "directory",
  } ~> #Do first then..

  file { "/home/vagrant/projects":
      ensure => 'link',
      target => $projects,
  } ~> #Do first then..

  yeoman::project { "$projects/angular-project" :
    path => "$projects/angular-project",
    generators => ["generator-angular"],
    repo => "https://github.com/frankcarey/base-angular-project.git"
  }
}

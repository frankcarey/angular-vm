
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
  # Install our custom yoeman, grunt, etc configuration.
  include yeoman

}

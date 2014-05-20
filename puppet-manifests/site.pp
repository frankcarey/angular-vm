
# Install node.js via https://forge.puppetlabs.com/willdurand/nodejs
# See that url for installing multiple versions, and more options.
class { 'nodejs':
    version => 'stable',
}


WHAT IS ANGULAR-VM AND WHO IS IT FOR?
=====================================
This is a basic dev vagrant vm for setting up and messing with angular-js and it's friends yeoman, grunt, bowser and karma. The idea is that you can install this package and immediately have ALL THE BASICS SETUP FOR YOU, try some stuff out, and then feel comfortable either:

* Throwing it away - without any leftover remnants on your computer!

OR

* Building upon what's here to create your own project.

I was annoyed by how long it took to get started without having the dependencies installed, and figuring out annoying bugs so I created this. You don't need to know ANYTHING about Vagrant, puppet, node, etc to get started. You should be able to follow the instructions below to get yourself fully setup. As you progress, you might want to explore around a bit if you want to configure things to your liking.

WHAT DO YOU GET?
================

Once installed (see steps below), you should be able to immediately navigate to angular-vm.local:9000 and see the base angular project up and running.

To do that, this is a  Vagrant + puppet setup that provides the following features:

* A fleshed out angular-js project with all the bells and whistles provided by yeoman angular:generate plus some extras.
* Ubuntu 14.04 base box with almost no customization.
* ALL the dependencies including angular-js, yeoman, node/npm, grunt, karma and phantomjs.
* Avahi - so you don't have to edit a hosts file, and are up immediately.
* Shared folder for your projects at ./angular so you can use your existing editor to edit the files on the VM.

HOW DO YOU GET IT?
=================

NOTE: This process isn't something you want to do if you are in a rush or over a bad internet connection. You're going to be downloading like 1GB of files. The good news is once you get to step 4, you can walk away until it completes.

DEPENDENCIES
-------------
Many folks will have some or all of these installed / setup already. If you do, you can skip them:

* GIT - You'll need to have git installed. Choose your platform here: https://help.github.com/articles/set-up-git
* GITHUB ACCOUNT W/ SSH KEYS SETUP - The way this is setup, you'll need both. See https://help.github.com/articles/generating-ssh-keys
* INSTALL VAGRANT - Choose your platform at https://www.vagrantup.com/downloads
* INSTALL VIRTUALBOX - Choose your platform at https://virtualbox.org/wiki/Downloads

INSTALLATION
------------

1. Checkout this repo into folder on your computer. I create a directory called ~/Vagrant where I put all my VMs, but feel free to create one anywhere you like or use an existing folder. Move into that directory and run the following (note the --recursive part is important to pull in other packages) That will take a few seconds to a couple minutes to download depending on your connection.
    git clone --recursive git://github.com/frankcarey/angular-vm.git

2. Now, move into the angular-vm directory and run the following command:
    vagrant up

3. Go get some coffee. If you don't have the base box already setup, it needs to download the file which is like 700MB, then it installs additional packages and settings until it should finally say something like "Notice: Finished catalog run in 1029.50 seconds". For me this takes like 20 minutes. If you scroll up, you should see a lot of lines that start with "Notice" or [default], but no errors or warnings. If you do see errors, checkout the Troubleshooting section below.

4. Visit http://angular-vm.local:9000 and you should see the site up and running jump down to Getting Started. Again if that doesn't work or you got errors, check the Troubleshooting section.

TROUBLESHOOTING
===============

Errors during vagrant up
-------------------------
Make sure that you cloned the repo with the --recursive flag. If you didn't you can fix it by running:
    git submodule update --init --recursive ; vagrant reload --provision

No site at http://angular-vm.local:9000
-------
If you can't see the site, then avahi might not have worked. As a workaround, you can edit your hosts file. See this doc on how to do that: http://www.rackspace.com/knowledge_center/article/how-do-i-modify-my-hosts-file

You'll want to basically add this line:
    33.33.33.10 angular-vm.local
where 33.33.33.10 is the ip setup in Vagrantfile

GETTING STARTED
===============

So, you've got your angular site up and running locally, now what can you do?

Open the project files
----------------------
You should be able to use your favorite editor to open the files in `./angular/base-angular-project` . Inside, you'll find a bunch of files and folders that make up the entire angular project:
    ./angular
        ./base-angular-project
              .bowerrc
              .editorconfig
              .git
              .gitattributes
              .gitignore
              .jshintrc
              .sass-cache
              .tmp
              .travis.yml
              Gruntfile.js
              README.md
              app
              bower.json
              dist
              karma-e2e.conf.js
              karma.conf.js
              node_modules
              package.json
              test

That's a lot more files than you'd get with a simple index.html file that you edit locally, and while it adds some compelexity when starting out, it will help you structure your app cleanly from the beginning and expose you some best practices and helpful tools. Checkout this article which makes the case for using grunt if you think you need more convincing: http://24ways.org/2013/grunt-is-not-weird-and-hard/

Editing the code in ./app
-------------------------
While the number of files in the root directory might be daunting, you'll really be mostly concerned with the files in the ./app directory:





CHANGELOG
======

* Added settings for puppet via: http://docs.vagrantup.com/v2/provisioning/puppet_apply.html
* Install npm via: https://forge.puppetlabs.com/willdurand/nodejs

TODOS
======

* More configuration options are available to implement in the Vagrantfile: See http://docs.vagrantup.com/v2/provisioning/puppet_apply.html

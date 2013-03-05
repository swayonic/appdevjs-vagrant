# appdevjs-vagrant

My Vagrant box for http://github.com/appdevdesigns/appdevjs

* Install Vagrant
* Clone this repository
* Run `vagrant up`
* Puppet will install (from puppet/manifests/default.pp):
    * apache
    * git
    * mysql
    * nodejs
    * npm

After that, you can clone the above repository (or any other NodeJS project) into your home directory.

NOTE: don't do it into a shared drive or the install will break when it tries to create symlinks. mishoo/UglifyJS#453

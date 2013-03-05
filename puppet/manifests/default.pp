# Originally from github.com/rails/rails-dev-box

$ar_databases = ['appdev']
$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {

	# Quantal (12.10) users may need to install the software-properties-common package for the add-apt-repository command to work
	# sudo apt-get install software-properties-common

	# For NodeJS
	exec { 'add-apt-repository ppa:chris-lea/node.js':
		before => Exec['do_apt_get_update'],
	}

  exec { 'do_apt_get_update':
		command => 'apt-get -y update',
    creates => "/etc/init.d/apache2", # We'll assume this means it completed
    timeout => 1200, # 20 minutes
  }
}
class { 'apt_get_update':
  stage => preinstall
}

# --- Basic Packages -----------------------------------------------------------------

package { 'build-essential':
  ensure => installed
}

class { 'git': }

#sudo apt-get install python-software-properties python g++ make

# --- Apache --------------------------------------------------------------------

class { 'apache': }

class { 'apache::mod::php': }

# --- MySQL --------------------------------------------------------------------

class install_mysql {
  class { 'mysql': }

  class { 'mysql::server':
    config_hash => { 'root_password' => '' }
  }
	
	mysql::db { 'appdev':
		user     => 'vagrant',
		password => 'password',
		host     => 'localhost',
		grant    => ['all'],
	}

  package { 'libmysqlclient-dev':
    ensure => installed
  }
}
class { 'install_mysql': }

# --- NodeJS ---------------------------------------------------------------------

package { 'nodejs':
	ensure => installed
}

package { 'npm':
	ensure => installed
}

# --- Users/Groups ---------------------------------------------------------------------

user { 'vagrant':
	ensure => present,
	# To enable simply putty login
	password => '$1$9U6CsQm4$iEu0XBtdm8M2lk6x4ECsl1', # 'password'
	# To access shared folders
	groups => 'vboxsf',
}


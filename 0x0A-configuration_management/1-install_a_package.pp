# installs python 3.8.10 using puppet
package { 'python3.8':
  ensure => '3.8.10',
}

# installs flask using puppet from pip3
python::pip3 { 'flask':
  ensure  => '2.1.0',
  pkgname => 'flask',
}

# installs werkzeug using puppet from pip3
python::pip3 { 'werkzeug':
  ensure => '2.1.1',
  pkgname => 'werkzeug',
}

# installs flask using puppet from pip3
python::pip3 { 'flask':
  ensure  => '2.1.0',
  pkgname => 'flask',
}

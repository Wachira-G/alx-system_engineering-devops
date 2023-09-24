# installs flask using puppet from pip3
python::pip3 { 'flask':
  ensure  => present,
  pkgname => 'flask',
}

# kills a process named killmenow
service { 'killmenow':
  ensure => 'stopped',
  enable => false,
}

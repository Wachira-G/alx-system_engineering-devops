# configures nginx for high loads

file { '/etc/default/nginx':
  ensure  => file,
  content => 'ULIMIT="-n 4096"',
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  subscribe  => File['/etc/default/nginx'],
  hasrestart => true,
  restart    => '/usr/sbin/service nginx restart',
}

# puppet_haproxy_config.pp

# Update package repositories
exec { 'apt_update':
  command     => 'apt update -y',
  path        => ['/bin', '/usr/bin'],
  refreshonly => true,
}

# Install prerequisites
package { 'software-properties-common':
  ensure => 'installed',
}

# Add HAProxy repository source
exec { 'add_haproxy_repo':
  command     => 'add-apt-repository ppa:vbernat/haproxy-2.0 -y && apt update -y',
  path        => ['/bin', '/usr/bin'],
  refreshonly => true,
  require     => Exec['apt_update'],
}

# Install HAProxy
package { 'haproxy':
  ensure  => '2.0.*',
  require => Exec['add_haproxy_repo'],
}

# Create backup of /etc/default/haproxy file
file { '/etc/default/haproxy.orig':
  source  => '/etc/default/haproxy',
  ensure  => present,
  require => Package['haproxy'],
}

# Enable HAProxy init script
file { '/etc/default/haproxy':
  ensure  => present,
  source  => '/etc/default/haproxy.orig',
  before  => Exec['haproxy_init_enabled_snippet'],
  require => Package['haproxy'],
}

file_line { 'haproxy_init_enabled_snippet':
  path   => '/etc/default/haproxy',
  line   => 'ENABLED=1',
  match  => '^ENABLED=',
  create => true,
  ensure => present,
}

# Create backup of HAProxy configuration file
file { '/etc/haproxy/haproxy.cfg.orig':
  source  => '/etc/haproxy/haproxy.cfg',
  ensure  => present,
  require => FILE['/etc/default/haproxy.orig'],
}

# Ensure the original configuration file exists and requires the backup
file { '/etc/haproxy/haproxy.cfg':
  ensure  => present,
  source  => '/etc/haproxy/haproxy.cfg.orig',
  require => File['/etc/default/haproxy'],
}

# Manage the snippet in the configuration file
file_line { 'haproxy_config_snippet':
  path   => '/etc/haproxy/haproxy.cfg',
  line   => '
    frontend lb-01
        bind *:80
        mode http
        default_backend backend_servers

    backend backend_servers
        balance roundrobin
        server 230758-web-01 54.160.78.191:80 check
        server 230758-web-02 54.146.88.214:80 check
  ',
  match  => '^frontend lb-01',
  create => true,
  ensure => present,
}

service { 'haproxy':
  ensure  => 'running',
  enable  => true,
  require => File['/etc/haproxy/haproxy.cfg'],
}

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
}

# Install HAProxy
package { 'haproxy':
  ensure => '2.0.*',
}

# Enable HAProxy init script
file { '/etc/default/haproxy':
  ensure  => present,
  source  => '/etc/default/haproxy.orig',
  before  => Exec['modify_haproxy_enabled'],
  require => Package['haproxy'],
}

exec { 'modify_haproxy_enabled':
  command     => 'sed -i -e "s/ENABLED=0/ENABLED=1/" /etc/default/haproxy',
  path        => ['/bin', '/usr/bin'],
  refreshonly => true,
}

# Make a backup of the original config file
file { '/etc/haproxy/haproxy.cfg':
  ensure  => present,
  source  => '/etc/haproxy/haproxy.cfg.orig',
  require => Package['haproxy'],
}

# Configure HAProxy
file { '/etc/haproxy/haproxy.cfg':
  ensure  => present,
  content => template('haproxy/haproxy.cfg.erb'), # You need to create an ERB template
  require => Package['haproxy'],
  notify  => Service['haproxy'],
}

# Define the HAProxy service
service { 'haproxy':
  ensure  => 'running',
  enable  => true,
  require => [Package['haproxy'], File['/etc/haproxy/haproxy.cfg']],
}

# Define the HAProxy configuration template (haproxy/haproxy.cfg.erb)
# You need to create a separate template file for the HAProxy configuration.
# Example content for haproxy/haproxy.cfg.erb is provided below.

# This is an example of the ERB template file (haproxy/haproxy.cfg.erb)
# Replace <web-01-server-ip>, <port>, <web-02-server-ip>, and <port> with your actual values.

# global
#     log /dev/log local0
#     log /dev/log local1 notice
#     chroot /var/lib/haproxy
#     stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
#     stats timeout 30s
#     user haproxy
#     group haproxy
#     daemon
#
# defaults
#     log global
#     mode http
#     option httplog
#     option dontlognull
#     timeout connect 5000
#     timeout client 50000
#     timeout server 50000
#
# frontend lb-01
#         bind *:80
#         default_backend backend_servers
#
# backend backend_servers
#         balance roundrobin
#         server 230758-web-01 <web-01-server-ip>:<port> check
#         server 230758-web-02 <web-02-server-ip>:<port> check


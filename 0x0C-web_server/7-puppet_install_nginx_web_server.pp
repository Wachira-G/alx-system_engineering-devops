# Puppet manifest to configure Nginx server

include stdlib

# Update package repositories
exec { 'apt_update':
  command     => 'apt update',
  path        => ['/bin', '/usr/bin'],
  refreshonly => true,
}

# Install Nginx
package { 'nginx':
  ensure => 'installed',
}

# Create an index.html file with "Hello World!"
file { '/var/www/html/index.html':
  ensure   => present,
  content  => 'Hello World!',
}

# Create a custom 404 HTML page
file { '/var/www/html/custom_404.html':
  ensure  => present,
  content => "Ceci n'est pas une page",
}

# Configure Nginx server block
file { '/etc/nginx/sites-available/default':
  ensure => present,
  # content => template('module_name/nginx_config.erb'), # You can use a template here
  content => "

server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location /redirect_me {
        rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
    }

    error_page 404 /custom_404.html;
    location /custom_404.html {
        internal;
    }

     location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files \$uri \$uri/ =404;
    }

    # Additional Nginx configuration here...
}

"
}

file {'/etc/nginx/conf.d/0-custom-header.conf':
  ensure => present,
  owner => 'ubuntu',
  group => 'ubuntu',
}

# Configure custom HTTP response header
file_line { 'headers_served_by':
  path    => '/etc/nginx/conf.d/0-custom-header.conf',
  line    => 'add_header X-Served-By $hostname;',
  match   => '^ENABLED=',
  ensure  => present,
  # create  => true,
  require => File['/etc/nginx/sites-available/default'],
}

# Restart Nginx after configuration changes
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => File_line['headers_served_by'],
}

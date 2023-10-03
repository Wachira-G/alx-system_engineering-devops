# Puppet manifest to configure Nginx server

# Ensure the Nginx package is installed
package { 'nginx':
  ensure => 'installed',
}

# Ensure Nginx service is enabled and running
service { 'nginx':
  ensure => 'running',
  enable => true,
  require => Package['nginx'],
}

# Create an index.html file with "Hello World!"
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
  require => Package['nginx'],
}

# Configure Nginx for redirection /redirect_me
file { '/etc/nginx/sites-available/redirect_me':
  ensure  => 'file',
  content => "location /redirect_me {\n rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;\n }\n"
  require => Package['nginx'],
}

# Enable the redirect_me site
file { '/etc/nginx/sites-enabled/redirect_me':
  ensure => 'link',
  target => '/etc/nginx/sites-available/redirect_me',
  require => File['/etc/nginx/sites-available/redirect_me'],
}

# Create a custom 404 HTML page
file { '/var/www/html/custom_404.html':
  ensure  => 'file',
  content => "Ceci n'est pas une page",
  require => Package['nginx'],
}

# Modify Nginx configuration to use the custom 404 page
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => "error_page 404 /custom_404.html;\nlocation = /custom_404.html {\n  internal;\n}\n",
  require => [Package['nginx'], File['/var/www/html/custom_404.html']],
}

# Restart Nginx to apply changes
exec { 'nginx-restart':
  command => '/usr/sbin/service nginx restart',
  refreshonly => true,
  subscribe => [File['/etc/nginx/sites-available/default'], File['/etc/nginx/sites-available/redirect_me']],
}

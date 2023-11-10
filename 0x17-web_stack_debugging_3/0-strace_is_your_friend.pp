# restores a apache stack to working condition -

exec {'fix wordpress':
  command => "/bin/sed -i 's/phpp/php/g' /var/www/html/wp-settings.php",
}

# file { '/var/www/html/index.html':
#   ensure => file,
# }

# file{ '/var/www/html/index.cgi':
#   ensure => file,
# }

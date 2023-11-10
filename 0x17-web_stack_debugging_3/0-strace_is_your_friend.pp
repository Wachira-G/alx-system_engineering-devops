# restores a apache stack to working condition

file { '/var/www/html/index.html':
  ensure => file,
}

file{ '/var/www/html/index.cgi':
  ensure => file,
}

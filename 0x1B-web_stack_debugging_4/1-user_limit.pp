# sets limits to security limits

#exec { 'set nofile limits for holberton':
#  command => "/bin/sed -i 's/holberton soft nofile [0-9]*/holberton soft nofile 65535/g;
#  s/holberton hard nofile [0-9]*/holberton hard nofile 65535/g' /etc/security/limits.conf",
#}

file { '/etc/security/limits.conf':
    ensure  => file;
    content => "holberton soft nofile 65535\nholberton hard nofile 65535";
}

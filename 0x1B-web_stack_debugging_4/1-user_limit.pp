exec { 'set nofile limits for holberton':
  command => "/bin/sed -i 's/holberton soft nofile [0-9]*/holberton soft nofile 65535/g; s/holberton hard nofile [0-9]*/holberton hard nofile 65535/g' /etc/security/limits.conf",
}

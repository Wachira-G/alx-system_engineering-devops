# sets limits to security limits

# Set the maximum number of open files for the Holberton user
user { 'holberton':
  hard => '65535',
  soft => '65535',
}

# Set the maximum number of open files for all users
limits::limits { '*' :
  ulimit => ['nofile', '10000'],
}

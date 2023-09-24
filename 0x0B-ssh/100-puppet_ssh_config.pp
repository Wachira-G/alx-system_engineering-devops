# creates an ssh config file on server
file { '/etc/ssh/ssh_config':
  ensure  => present,
  content => "#!/usr/bin/env bash\n# configure local SSH configuration file for the local SSH client\nto connect to a server without typing a password\n# SSH client configuration configured to use the private key ~/.ssh/school\n# SSH client configuration configured to refuse to authenticate using password\nHost 54.160.78.191\n    IdentityFile ~/.ssh/school\n    PasswordAuthentication no",
}

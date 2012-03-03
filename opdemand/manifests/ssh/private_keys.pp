
class opdemand::ssh::private_keys { 

  require opdemand::common
  
  $server_private_key = hiera("server/ssh_private_key", "")
  $app_private_key = hiera("appication/repository_key", "")
    
  if $server_private_key {
    # add server private key to root user
    opdemand::ssh::private::add { "server":
      contents => $server_private_key,
      user => $user,
      group => $user,
      home => "/root",
    }
  }
  
  if $app_private_key {
    # add app private key to root user
    opdemand::ssh::private::add { "root":
      contents => $server_private_key,
      user => $user,
      group => $user,
      home => "/root",
      prefix => "opdemand",
    }
    # add app private key to ubuntu user
    opdemand::ssh::private::add { "ubuntu":
      contents => $server_private_key,
      user => $user,
      group => $user,
      home => "/home/ubuntu",
      prefix => "opdemand",
    }
  }
  
}

define opdemand::ssh::private::add($contents, 
                                   $user,
                                   $home,
                                   $prefix="id") {
  
  if $contents =~ /^-----BEGIN (...) PRIVATE KEY/ {
    
    case $1 {
      'RSA': { $user_file_path = "$home/.ssh/$prefix_rsa"
               $root_file_path = "/root/.ssh/$prefix_rsa" }
      'DSA': { $user_file_path = "$home/.ssh/$prefix_dsa"
               $root_file_path = "/root/.ssh/$prefix_dsa" }
    }
    
    file { $user_file_path:
      owner   => $user,
      group   => $group,
      mode    => 600,
      content => $contents,
    }
    
  } else {
    notice('skipped server/ssh_private_key installation')
  }
    
}

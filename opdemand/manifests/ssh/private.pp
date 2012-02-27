
class opdemand::ssh::private ($user="ubuntu") { 

  require opdemand::common
  
  # add one private key for the opdemand user
  opdemand::ssh::private::add { $user:
    contents => hiera("server/ssh_private_key"), 
  }
  
}

define opdemand::ssh::private::add($contents, 
                                   $user="ubuntu",
                                   $group="ubuntu",
                                   $home="/home/ubuntu") {
  
  if $contents =~ /^-----BEGIN (...) PRIVATE KEY/ {
    
    case $1 {
      'RSA': { $file_path = "$home/.ssh/id_rsa" }
      'DSA': { $file_path = "$home/.ssh/id_dsa" }
    } 
    
    file { $file_path:
      owner   => $user,
      group   => $group,
      mode    => 600,
      content => $contents,
    }
  } else {
    notice('skipped server/ssh_private_key installation')
  }
    
}

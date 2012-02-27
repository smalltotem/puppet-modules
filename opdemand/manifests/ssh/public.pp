
class opdemand::ssh::public ($user="ubuntu") { 

  require opdemand::common    
  
  $keys = hiera("server/ssh_authorized_keys")
  
  # add a key for each in the list
  opdemand::ssh::public::add { $keys: }
  
}

define opdemand::ssh::public::add() {
  
  if $name =~ /^(ssh-...) ([^ ]+) ?(.+)?/ {
    
    $keytype = $1
    $modulus = $2
    $keyid = $3
    
    notice ("keytype: $keytype, keyid: $keyid, modulus: $modulus")
   
    if $keyid == "" {
      $keyname = "default"            
    } else {
      $keyname = $keyid
    }
    
    notice ("keyname: $keyname")
        
    ssh_authorized_key { "${keyname}":
      ensure  => "present",
      user    => "ubuntu",
      type    => $keytype,
      key     => $modulus,
      options => $options ? { "" => undef, default => $options },
    }
    
  } else {
    notice('failed to parse $name')
  }
  
}

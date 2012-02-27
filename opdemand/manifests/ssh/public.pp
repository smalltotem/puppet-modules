
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
    
    case $keyid {
      "":      { $keyname = "default" }
      default: { $keyname = $keyid }
    }
    
    notice('trying to install keyname: $keyname from $keyid')
    
    ssh_authorized_key { "$keyname":
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

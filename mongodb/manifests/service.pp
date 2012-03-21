class mongodb::service {

  # service definition
  service { "mongodb":
    enable => true,
    ensure => running,
  }
  
}

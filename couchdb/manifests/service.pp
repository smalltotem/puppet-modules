class couchdb::service {
  
  service {"couchdb":
    ensure    => running,
    hasstatus => true,
    enable    => true,
    require   => [Package["couchdb"], File["/etc/couchdb/local.ini"]],
    subscribe => File["/etc/couchdb/local.ini"],
  }

}
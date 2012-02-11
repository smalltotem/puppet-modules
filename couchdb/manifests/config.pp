class couchdb::config {
  
  require couchdb::params
  
  file {"/etc/couchdb/local.ini":
    content => template("couchdb/local.ini.erb"),
    require => Package["couchdb"],
  }

}
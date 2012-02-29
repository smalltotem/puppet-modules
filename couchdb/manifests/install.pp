class couchdb::install (
) {

  package {"couchdb":
    ensure => latest,
  }
  
  # workaround couchdb package daemon issues in ubuntu 11.10
  exec {"prevent-daemon-start":
    command => "echo '
COUCHDB_USER=couchdb
COUCHDB_STDOUT_FILE=/dev/null
COUCHDB_STDERR_FILE=/dev/null
COUCHDB_RESPAWN_TIMEOUT=5
COUCHDB_OPTIONS=
ENABLE_SERVER=0
' > /etc/default/couchdb",
    provider => shell,
    unless => "service couchdb status"    
  }

  exec {"allow-daemon-start":
    command => "sed -i -e s/ENABLE_SERVER=0/ENABLE_SERVER=1/ /etc/default/couchdb",
    provider => shell,
    unless => "service couchdb status"
  }

  # order deps to work around packaging issue
  Exec["prevent-daemon-start"] ->
  Package["couchdb"] ->
  Class["Couchdb::Config"] ->
  Exec["allow-daemon-start"]
  
}
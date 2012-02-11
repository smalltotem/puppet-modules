# output to outputs.json 
define opdemand::output($key, $value) {
  exec {"/var/cache/opdemand/output $key $value":
    path        => "/var/cache/opdemand",
    user        => "root",
    require =>  Class[Opdemand::Common],
  }
}
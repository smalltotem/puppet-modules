class opdemand::inputs {
  file {"/var/cache/opdemand/inputs.json":
    ensure => present
  }
}
class nodejs::config {

  require nodejs::params

  file {"/etc/init/nodejs.conf":
    ensure => file,
    require => Package["nodejs"],
    content => template("nodejs/nodejs.conf.erb"),
  }

}
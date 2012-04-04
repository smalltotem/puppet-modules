class rails::config {

  require rails::params

  file {"/etc/init/rails.conf":
    ensure => file,
    content => template("rails/rails.conf.erb"),
    require => Class[Rails::Install],
  }

}
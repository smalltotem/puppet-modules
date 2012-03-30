class clojure::config {

  require clojure::params
  file {"/etc/init/clojure.conf":
    ensure => file,
    content => template("clojure/clojure.conf.erb"),
    require => Class[Clojure::Install],
  }
}

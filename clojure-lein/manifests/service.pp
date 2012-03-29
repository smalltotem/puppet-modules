class clojure::service {

  require clojure::params

  service {"clojure":
    ensure => running,
    name => "clojure",
    provider => upstart,
    require => [ Class[Clojure::Install], Class[Clojure::Config] ],
    subscribe => Vcsrepo["$clojure::params::repository_path"],
  } ->

}

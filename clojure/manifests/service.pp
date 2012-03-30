class clojure::service {

  require clojure::params

  exec { "clojure::npm::install::${name}":
        command => "lein deps",
        cwd => "/home/ubuntu/repo/",
        path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
        user => "$clojure::params::username",
        group => "$clojure::params::group",
    }



  service {"clojure":
    ensure => running,
    name => "clojure",
    provider => upstart,
    require => [ Class[Clojure::Install], Class[Clojure::Config] ],
    subscribe => Vcsrepo["$clojure::params::repository_path"],
  } 

}

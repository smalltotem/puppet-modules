class clojure::install {

  require clojure::params
  $packages = ["leiningen"]
  
 package { $packages:
        ensure => latest,
  }
  exec { "clojure::install::${name}":
        command => "lein deps",
        cwd => "/home/ubuntu/repo/",
        path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
        user => "$clojure::params::username",
        group => "$clojure::params::group",
        subscribe => Vcsrepo["$clojure::params::repository_path"],
  } 
  

}

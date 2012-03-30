class clojure::install {

  require clojure::params
  
  $package_requires = ["leiningen"]
  
  package { $packages:
      ensure => latest,
      require => $package_requires,
  }

}

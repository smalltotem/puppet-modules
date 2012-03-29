class clojure::install {

  require clojure::params
  
  $package_requires = ["leinegen"]
  
  package { $packages:
      ensure => latest,
      require => $package_requires,
  }

}

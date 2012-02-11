class php::install {
 
  require php::params

  $packages = $php::params::packages

  package { $packages:
    ensure => latest,
  }

}


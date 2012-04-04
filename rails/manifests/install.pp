class rails::install {

  require rails::params

  $packages = [ "curl", "openssl", "ruby1.9.1", "ruby1.9.1-dev", "build-essential", "libsqlite3-ruby1.9.1", "libsqlite3-dev", "rubygems", "libv8-dev"]
  $gems = [ "bundler", "rails", "sinatra", "therubyracer", "rake", "coffee-rails", "sass-rails", "uglifier", "jquery-rails", "pg"]
  $db_packages = $rails::params::database_type ? {
    postgresql => [ "libpq-dev" ],
  }

  # install framework database packages
  package { $db_packages:
      ensure => latest,
  }

  # install framework packages
  package { $packages:
      ensure => latest,
      require => Package[$db_packages],
  }

  # install gems
  package { $gems:
      provider => "gem",
      ensure => latest,
      require => Package[$packages],
  }
  
  rails::dbcreate {"rails":
      require => Package[$gems],
  }

}

class rails::config {

  require rails::params

  file {"/etc/init/rails.conf":
    ensure => file,
    content => template("rails/rails.conf.erb"),
    require => Class[Rails::Install],
  }

  file {"$rails::params::repository_path/config/database.yml":
    ensure => file,    
    owner => "$rails::params::username",
    group => "$rails::params::group",
    content => template("rails/database.yml.erb"),
    require => Class[Rails::Install],
  }

}
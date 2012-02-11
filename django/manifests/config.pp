class django::config {

  require django::params

  file {"/etc/init/django.conf":
    ensure => file,
    content => template("django/django.conf.erb"),
    require => Class[Django::Install],
  }

  file { "$django::params::repository/app/settings.py":
    ensure => file,
    content => template("django/settings.py.erb"),
    owner => "$django::params::username",
    group => "$django::params::group",
    notify => Service["django"],
    require => [ Class[Django::Install], Vcsrepo["$django::params::repository"] ],
  }

}
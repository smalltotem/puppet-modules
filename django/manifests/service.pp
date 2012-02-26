class django::service {

  require django::params

  service {"django":
    ensure => running,
    name => "django",
    provider => upstart,
    require => [ Class[Django::Install], Class[Django::Config] ],
    subscribe => Vcsrepo["$django::params::repository_path"],
  } ->

  django::syncdb {"django":} ->
  django::createadmin {"django":}

}

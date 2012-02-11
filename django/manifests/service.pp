class django::service {

  require django::params

  service {"django":
    ensure => running,
    name => "django",
    provider => upstart,
    require => [ Class[Django::Install], Class[Django::Config] ],
    subscribe => Vcsrepo["$django::params::repository"],
  } ->

  django::syncdb {"django":} ->
  django::createadmin {"django":}

}

define django::syncdb {
    exec { "sudo -u $django::params::username python manage.py syncdb --noinput":
      path => $path,
      user => "root",
      cwd => "$django::params::repository/app",
      require =>  Class[Django::Install],
      subscribe => Vcsrepo["$django::params::repository"],
    }
}

define django::createadmin {
    exec { "admin":
      command => "echo \"from django.contrib.auth.models import User; User.objects.create_superuser('$django::params::admin_username', '$django::params::admin_email', '$django::params::admin_password')\" | python manage.py shell",
      unless => "DJANGO_SETTINGS_MODULE=settings python -c \"import settings;from django.contrib.auth.models import User; User.objects.get(username='$django::params::admin_username')\"",
      path => $path,
      provider => shell,
      user => "ubuntu",
      cwd => "$django::params::repository/app",
      require =>  Class[Django::Install],
    }
}
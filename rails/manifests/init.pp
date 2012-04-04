define rails::syncdb {
    exec { "sudo -u $rails::params::username rake db:migrate":
      path => $path,
      user => "$rails::params::username",
      cwd => "$rails::params::repository_path/app",
      require =>  Class[Rails::Install],
      subscribe => Vcsrepo["$rails::params::repository_path"],
    }
}

define rails::bundleinstall {
    exec { "sudo -u $rails::params::username bundle install":
      path => $path,
      user => "$rails::params::username",
      cwd => "$rails::params::repository_path/app",
      require =>  Class[Rails::Install],
      subscribe => Vcsrepo["$rails::params::repository_path"],
    }
}

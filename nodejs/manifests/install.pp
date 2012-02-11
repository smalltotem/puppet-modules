class nodejs::install {

  require nodejs::params
  
  package {"nodejs":
    ensure => latest,
  }

  package {"npm":
    ensure => latest,
  }

}

define nodejs::npm::install(
    $package_name = "", 
    $where) {
      
    exec { "nodejs::npm::install::${name}":
      command => "sudo -u $nodejs::params::username -i npm install ${package_name}",
      cwd => $where,
      path => ["/sbin", "/bin", "/usr/bin", "/usr/local/bin"],
      user => "$nodejs::params::username",
      group => "$nodejs::params::group",
    }
  
}
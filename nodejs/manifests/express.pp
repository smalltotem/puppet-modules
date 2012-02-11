class nodejs::express {

  require nodejs::params
  
  nodejs::npm::install {"express":
    package_name => "express",
    where => $nodejs::params::path,
  }
  
}
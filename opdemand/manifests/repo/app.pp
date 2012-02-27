class opdemand::repo::app (
  
  # inputs default to hiera lookup followed by second arg
  # can override using parameterized class inputs
  $repository_provider = hiera("application/repository_provider", "git"),
  $repository_url = hiera("application/repository_url"),
  $repository_path = hiera("application/repository_path", "/home/ubuntu/repo"),
  $repository_branch = hiera("application/repository_branch", "master"),
  $repository_owner = hiera("application/username", "ubuntu"),
  $repository_group = hiera("application/group", "ubuntu")) {
  
  vcsrepo { $repository_path:
    ensure => latest,
    provider => $repository_provider,
    source => $repository_url,
    revision => $repository_branch,
    owner => $repository_owner,
    group => $repository_group,
    require => Class["Opdemand::Inputs"],
  }
  
}

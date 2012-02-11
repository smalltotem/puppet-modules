class opdemand::repo::app (
  
  # inputs default to hiera lookup followed by second arg
  # can override using parameterized class inputs
  $repository_provider = hiera("server/repository_provider", "git"),
  $repository_url = hiera("server/repository_url"),
  $repository_path = hiera("server/repository_path", "/home/ubuntu/repo"),
  $repository_branch = hiera("server/repository_branch", "master"),
  $repository_owner = hiera("server/repository_owner", "ubuntu"),
  $repository_group = hiera("server/repository_owner", "ubuntu")) {
  
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

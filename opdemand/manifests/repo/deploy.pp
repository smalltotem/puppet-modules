class opdemand::repo::deploy (
  
  # inputs default to hiera lookup followed by second arg
  # can override using parameterized class inputs
  $repository_provider = hiera("deployment/repository_provider", "git"),
  $repository_url = hiera("deployment/repository_url"),
  $repository_path = hiera("deployment/repository_path", "/var/lib/opdemand/deploy"),
  $repository_branch = hiera("deployment/repository_branch", "master"),
  $repository_owner = hiera("deployment/repository_owner", "ubuntu"),
  $repository_group = hiera("deployment/repository_owner", "ubuntu")) {
  
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

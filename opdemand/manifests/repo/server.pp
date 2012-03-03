class opdemand::repo::server (
  
  # inputs default to hiera lookup followed by second arg
  # can override using parameterized class inputs
  $repository_provider = hiera("server/repository_provider", "git"),
  $repository_url = hiera("server/repository_url"),
  $repository_path = hiera("server/repository_path", "/var/lib/opdemand"),
  $repository_revision = hiera("server/repository_revision", "HEAD"),
  $repository_owner = hiera("server/username", "root"),
  $repository_group = hiera("server/group", "root")) {
  
  # require common including ssh classes
  require opdemand::common
  
  vcsrepo { $repository_path:
    ensure => latest,
    provider => $repository_provider,
    source => $repository_url,
    revision => $repository_revision,
    owner => $repository_owner,
    group => $repository_group,
  }
  
}

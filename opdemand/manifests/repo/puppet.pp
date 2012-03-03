class opdemand::repo::puppet (
  
  # inputs default to hiera lookup followed by second arg
  # can override using parameterized class inputs
  $repository_provider = hiera("puppet/repository_provider", "git"),
  $repository_url = hiera("puppet/repository_url", "git://github.com/opdemand/puppet-modules.git"),
  $repository_path = hiera("puppet/repository_path", "/usr/share/puppet/modules"),
  $repository_revision = hiera("puppet/repository_revision", "HEAD"),
  $repository_owner = hiera("puppet/username", "root"),
  $repository_group = hiera("puppet/group", "root")) {
  
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

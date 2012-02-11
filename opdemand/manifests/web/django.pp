class opdemand::web::django {

  # require opdemand common and repo
  require opdemand::common
  require opdemand::repo::app

  # resolve database type
  $database_type = hiera("database/type", "postgresql")
  $database_engine = $database_type ? {
    postgresql => "postgresql_psycopg2",
    mysql => "mysql",
    oracle => "oracle",
  }

  # initialize dynamic parameters
  class {"django::params":
    # database settings
    database_type => $database_type,
    database_engine => $database_engine,
    database_host => hiera("database/host", "localhost"),
    database_name => hiera("database/name", "django"),
    database_username => hiera("database/username", "django"),
    database_password => hiera("database/password", "changeme123"),
    # service settings
    bind => hiera("application/bind", "0.0.0.0"),
    port => hiera("application/port", "8080"),
    # app settings
    apps => hiera("django/applications", "helloworld"),
    admin_name => hiera("django/admin_name", "Admin User"),
    admin_email => hiera("django/admin_email", "admin@example.com"),
    admin_username => hiera("django/admin_username", "admin"),
    admin_password => hiera("django/admin_password", "changeme123"),
    # daemon settings
    username => "ubuntu",
    group => "ubuntu",
    home => "/home/ubuntu",
    repository => "$opdemand::repo::app::repository_path",
  }

  # include relevant classes
  include django::install
  include django::config
  include django::service

}
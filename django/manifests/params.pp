class django::params (
  # database settings
  $database_type = "postgresql",
  $database_engine = "postgresql_psycopg2",
  $database_host = "localhost",
  $database_name = "django",
  $database_username = "django",
  $database_password = "changeme123",
  $database_port = "5432",
  # admin settings
  $admin_email = "admin@example.com",
  $admin_name = "Admin User",
  $admin_username = "admin",
  $admin_password = "changeme123",
  # service settings
  $bind = "0.0.0.0",
  $port = "8080",
  # app settings
  $apps = [ "helloworld" ],
  # daemon settings
  $username = "ubuntu",
  $group = "ubuntu",  
  $home = "/home/ubuntu",
  $repository = "/home/ubuntu/repo") {
}
class php::nginx ($packages = [ "php5-fpm", "php5-cgi" ],
                  $www_root = "/var/www",
                  $fastcgi = "127.0.0.1:9000"){
  
  package { $packages:
    ensure => latest,
  }

  nginx::resource::vhost { $name:
    ensure   => present,
    www_root => $www_root,
    fastcgi => $fastcgi,
    fastcgi_index => "index.php",
    fastcgi_script => "$www_root\$fastcgi_script_name",
  }

}

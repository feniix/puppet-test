node /.*web.*/ {

  stage { 'bootstrap': before => Stage['first'] }
  stage { 'first':     before => Stage['main'] }
  stage { 'last': }

  Stage['main'] -> Stage['last']

  $www_root = '/srv/www_root'
  file { $www_root:
    ensure => 'directory',
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '0550',
  }

  class { 'apt':
    stage => 'bootstrap',
  }

  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }

  Exec['apt-update'] -> Package <| |>

  class { 'firewall': }

  firewall { '100 enable sshd access':
    port   => ['22'],
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '200 enable webserver on port 8080':
    port   => ['8080'],
    proto  => 'tcp',
    action => 'accept',
  }

  class { 'nginx':
    confd_purge => true
  }

  $nginx_config = {
    autoindex => 'off',
  }

  nginx::resource::vhost { 'localhost':
    ensure      => present,
    www_root    => $www_root,
    listen_port => '8080',
    server_name => [
      'localhost',
      '127.0.0.1',
      $ipaddress,
    ],
  }

  /*
  class { 'webcontent':
    stage => last,
  }
  */
}


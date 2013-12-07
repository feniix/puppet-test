# set this as default node to avoid complexities of setting up hostnames
node default { 

  stage { 'bootstrap': before => Stage['first'] }
  stage { 'first':     before => Stage['main'] }
  stage { 'last': }

  Stage['main'] -> Stage['last']

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

  package { 'unzip':
    ensure => installed,
    name   => 'unzip',
  }

  $github_url = 'https://github.com'
  $github_user = 'puppetlabs'
  $project = 'exercise-webpage'
  $branch = 'master'
  $www_root = "/srv/${project}-${branch}"

  archive { "${project}-${branch}":
    ensure    => present,
    url       => "${github_url}/${github_user}/${project}/archive/${branch}.zip",
    target    => '/srv',
    extension => 'zip',
    checksum  => false,
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
  nginx::resource::mailhost { 'localhost-mail':
    ensure      => absent,
    listen_port => '-1',
  }
}


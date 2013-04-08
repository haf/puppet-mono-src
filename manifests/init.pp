class mono(
  $version  = $mono::params::version,
  $packages = $mono::params::packages,
  $script   = $mono::params::script
) inherits mono::params {
  ensure_packages($packages)
  #if $::operatingsystem == 'ubuntu' {
  #  apt::source { "badgerports":
  #    location   => "http://badgerports.org",
  #    repos      => "main",
  #    key        => "0E1FAD0C",
  #    key_server => "keyserver.ubuntu.com",
  #    before     => Exec[$script],
  #  }
  #}
  exec { $script:
    cwd => "/tmp",
    creates => "/usr/local/bin/mono",
    timeout => 0,
  }
}
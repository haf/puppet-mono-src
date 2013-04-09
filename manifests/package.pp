class mono::package {
  $packages = $mono::packages
  $version  = $mono::version

  #if $::operatingsystem == 'ubuntu' {
  #  apt::source { "badgerports":
  #    location   => "http://badgerports.org",
  #    repos      => "main",
  #    key        => "0E1FAD0C",
  #    key_server => "keyserver.ubuntu.com",
  #    require    => Anchor['mono::start'],
  #    before     => [
  #      Exec[$script],
  #      Anchor['mono::end']
  #    ],
  #  }
  #}

  mono::installpattern { 'libgdiplus':
    source      => "http://download.mono-project.com/sources/libgdiplus/libgdiplus-2.10.9.tar.bz2",
    version     => '2.10.9',
    creates     => '/usr/local/lib/libgdiplus.so',
    # TODO: custom make
  }

  mono::installpattern { 'mono':
    source      => "http://download.mono-project.com/sources/mono/mono-$version.tar.bz2",
    version     => $version,
  }

  if $::operatingsystem == 'CentOS' {
    mono::yum_install { $packages:
      ensure     => installed,
      enablerepo => ['C6.2-base'],
    }

    Mono::Installpattern['mono']       { require +> Mono::Yum_install[$packages] }
    Mono::Installpattern['libgdiplus'] { require +> Mono::Yum_install[$packages] }
  } else {
    ensure_packages($packages)
  }
}
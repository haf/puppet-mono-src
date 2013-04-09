define mono::installpattern(
  $outer_ext = 'bz2',
  $source,
  $version,
  $creates = "/usr/local/bin/$title"
) {

  $src_dir = '/usr/local/src'
  $target_dir = "$src_dir/${title}-${version}"
  $target_zip = "$src_dir/$title.tar.$outer_ext"
  $shell_wrapper = "$target_dir/wrapper.sh"

  if ! defined(File[$src_dir]) {
    file { $src_dir:
      ensure => directory,
    }
  }

  wget::fetch { $target_zip:
    source      => $source,
    destination => $target_zip,
    require     => Class['wget'],
  }

  $flags = $outer_ext ? {
    'bz2'   => 'jvxf',
    default => 'zvxf'
  }

  exec { "tar_$title":
    command   => "/bin/tar $flags $target_zip",
    cwd       => $src_dir,
    creates   => $target_dir,
    subscribe => Wget::Fetch[$target_zip],
  }

  exec { "configure_$title":
    command   => "$target_dir/configure",
    cwd       => $target_dir,
    creates   => "$target_dir/config.h",
    subscribe => Exec["tar_$title"],
  }

  file { $shell_wrapper:
    ensure  => present,
    source  => 'puppet:///modules/mono/wrapper.sh',
    mode    => '550',
    require => Exec["configure_$title"],
  }

  exec { "make_$title":
    cwd         => $target_dir,
    command     => "$shell_wrapper /usr/bin/make && $shell_wrapper /usr/bin/make install",
    creates     => $creates,
    timeout     => 0,
    path        => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin',
  }
}
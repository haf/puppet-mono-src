class mono::params {
  $version = '3.0.6'
  $script  = $::osfamily ? {
    /(?i:linux|redhat)/ => 'puppet:///modules/mono/build-mono-rhel.sh',
    default             => 'puppet:///modules/mono/build-mono-debian.sh',
  }
  $packages = $::osfamily ? {
    /(?i:linux|redhat)/ => [
      'glib2-devel',
      'libpng-devel',
      'libjpeg-turbo-devel',
      'giflib-devel',
      'libtiff-devel',
      'libexif-devel',
      'libX11-devel',
      'fontconfig-devel',
      'gcc-c++',
      # shared:
      'make',
      'gettext',
      'autoconf',
      'automake',
      'libtool'
    ],
    default => [
      'git-core',
      'g++',
      # shared:
      'make',
      'gettext',
      'autoconf',
      'automake',
      'libtool'
    ],
  }

  $package_name   = "mono-${version}-1.x86_64.rpm" 
  $package_source = "puppet:///modules/mono/$package_name"
}
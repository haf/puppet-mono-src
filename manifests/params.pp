class mono::params {
  $version = '3.0.6'
  $script  = $::osfamily ? {
    /(?i:linux|redhat)/ => 'mono/build-mono-debian.sh',
    default             => 'mono/build-mono-rhel.sh',
  }
  $packages = $::osfamily ? {
    /(?i:linux|redhat)/ => [
      'glib2-devel',
      'libpng-devel',
      'libjpeg-devel',
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
}
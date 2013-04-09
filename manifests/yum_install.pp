define mono::yum_install(
  $ensure = 'installed',
  $enablerepo = []
) {
  $manage_enablerepo = join($enablerepo, ",")

  notify { "mono::yum_install($title, $manage_enablerepo)": }

  exec { "yum_install_$title":
    command => "/usr/bin/yum install -y $title --enablerepo=$manage_enablerepo",
    unless  => "/bin/rpm -qa | grep $title",
  }
}
class mono(
  $version  = $mono::params::version,
  $packages = $mono::params::packages,
  $script   = $mono::params::script
) inherits mono::params {
  anchor { 'mono::start': } ->

  class { 'mono::package': } ->

  anchor { 'mono::end': }
}
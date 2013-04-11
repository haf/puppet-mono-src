class mono(
  $version        = $mono::params::version,
  $packages       = $mono::params::packages,
  $script         = $mono::params::script,
  $package_source = $mono::params::package_source,
  $use_pkg        = false
) inherits mono::params {
  anchor { 'mono::start': } ->

  class { 'mono::package': } ->

  anchor { 'mono::end': }
}
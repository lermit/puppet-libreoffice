# = Class: libreoffice
#
# This is the main libreoffice class
#
#
# == Parameters
#
# Standard class parameters
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, libreoffice class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $libreoffice_myclass
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, libreoffice main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $libreoffice_template
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $libreoffice_absent
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $libreoffice_audit_only
#   and $audit_only
#
# == Examples
#
#
class libreoffice (
  $my_class            = params_lookup( 'my_class' ),
  $version             = params_lookup( 'version' ),
  $url                 = params_lookup( 'url' ),
  $base_url            = params_lookup( 'base_url' ),
  $absent              = params_lookup( 'absent' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  ) inherits libreoffice::params {

  $bool_absent=any2bool($absent)
  $bool_audit_only=any2bool($audit_only)

  $manage_package = $libreoffice::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_file = $libreoffice::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  $manage_audit = $libreoffice::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $libreoffice::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $real_url = $url ? {
    undef   => template($libreoffice::template),
    default => $url,
  }

  $package_destination = "/var/tmp/libreoffice_${libreoffice::version}.tgz"

  if $bool_absent {
    file{ 'libreoffice_package':
      path   => $package_destination,
      ensure => $manage_package,
    }
  } else {
    include wget
    wget::fetch { "libreoffice_${libreoffice::version}":
      source      => $real_url,
      destination => $package_destination,
    }
  }

  ### Resources managed by the module
  package { 'libreoffice':
    ensure   => $libreoffice::manage_package,
    provider => 'dpkg',
    source   => $package_destination,
    require  => Wget::Fetch[ "libreoffice_${libreoffice::version}" ]
  }

  ### Include custom class if $my_class is set
  if $libreoffice::my_class {
    include $libreoffice::my_class
  }

}

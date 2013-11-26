# Class: libreoffice::params
#
# This class defines default parameters used by the main module class libreoffice
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to libreoffice class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class libreoffice::params {

  $url = undef
  $template = 'libreoffice/url.erb'

  ### Application related parameters
  $my_class = ''
  $version = '4.1.3'
  $absent = false

  $audit_only = false

}

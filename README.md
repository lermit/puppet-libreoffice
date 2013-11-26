# Puppet module: libreoffice

This is a Puppet module for libreoffice
It provides only package installation and file configuration.

Made by Romain THERRAT / ADD-ONLINE

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/lermit/puppet-libreoffice

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Basic management

* Install libreoffice with default settings

        class { 'libreoffice': }

* Install a specific version of libreoffice package

        class { 'libreoffice':
          version => '1.0.1',
        }

* Remove libreoffice resources

        class { 'libreoffice':
          absent => true
        }

* Enable auditing without without making changes on existing libreoffice configuration files

        class { 'libreoffice':
          audit_only => true
        }


## USAGE - Overrides and Customizations

* Use custom template for url generation

        class { 'libreoffice':
          template => 'example42/libreoffice/libreoffice-url.conf.erb',
        }

* Automatically include a custom subclass

        class { 'libreoffice':
          my_class => 'example42::my_libreoffice',
        }


[![Build Status](https://travis-ci.org/lermit/puppet-libreoffice.png?branch=master)](https://travis-ci.org/lermit/puppet-libreoffice)

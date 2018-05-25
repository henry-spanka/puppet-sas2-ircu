# Class: sas2_ircu
# ===========================
#
# Full description of class sas2_ircu here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'sas2_ircu':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Henry Spanka <henry.spanka@vnetso.com>
#
# Copyright
# ---------
#
# Copyright 2018 Henry Spanka, unless otherwise noted.
#
class sas2_ircu {
    case $::operatingsystem {
        'CentOS': {
            file { '/root/rpms':
                ensure => 'directory',
                owner  => 'root',
                group  => 'root',
                mode   => '0644'
            }

            file { '/root/rpms/sas2ircu-20.0-1.el7.x86_64.rpm':
                ensure  => 'file',
                source  => 'puppet:///modules/sas2_ircu/sas2ircu-20.0-1.el7.x86_64.rpm',
                owner   => 'root',
                group   => 'root',
                mode    => '0644',
                require => File['/root/rpms'],
            }

            package { 'sas2ircu':
                ensure   => 'installed',
                source   => '/root/rpms/sas2ircu-20.0-1.el7.x86_64.rpm',
                provider => 'rpm',
                require  => File['/root/rpms/sas2ircu-20.0-1.el7.x86_64.rpm'],
            }
        }
        default: {
            fail('Can only be installed on CentOS.')
        }
    }
}

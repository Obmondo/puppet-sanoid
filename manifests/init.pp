# Sanoid
class sanoid (
  Boolean $ensure_package,
  Boolean $ensure_service,
  String  $config_file,
  String  $package_name,

  Sanoid::Pools     $pools,
  Sanoid::Templates $templates,

  Sanoid::Syncoid::Replications $replications,
) {

  include sanoid::install
  include sanoid::config
  include sanoid::service
  include sanoid::syncoid

  $replications.each |String $pool_name, Sanoid::Syncoid::Replication $options| {
    sanoid::syncoid::job { $pool_name:
      * => $options,
    }
  }
}

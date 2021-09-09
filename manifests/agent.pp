# Installs and configures Blackfire agent
class blackfire::agent inherits blackfire {

  $default_params = {
    manage => true,
    version => 'latest',
    manage_service => true,
    service_ensure => 'running',
    server_id => $::blackfire::server_id,
    server_token => $::blackfire::server_token,
    socket => 'unix:///var/run/blackfire/agent.sock',
    log_file => 'stderr',
    log_level => 1,
    collector => 'https://blackfire.io',
    http_proxy => '',
    https_proxy => '',
    ca_cert => '',
    spec => '',
    package_name => 'blackfire',
  }
  $params = merge($default_params, $::blackfire::agent)

  $log_level = 0 + $params['log_level']

  assert_type(Boolean, $params['manage'])
  assert_type(String, $params['version'])
  assert_type(Boolean, $params['manage_service'])
  assert_type(String, $params['service_ensure'])
  assert_type(String, $params['server_id'])
  assert_type(String, $params['server_token'])
  assert_type(String, $params['socket'])
  assert_type(String, $params['log_file'])
  if $log_level < 1 or $log_level > 4 {
    fail 'Invalid log_level. Valid levels are: 4 - debug, 3 - info, 2 - warning, 1 - error'
  }
  assert_type(String, $params['collector'])
  assert_type(String, $params['http_proxy'])
  assert_type(String, $params['https_proxy'])
  assert_type(String, $params['ca_cert'])
  assert_type(String, $params['spec'])
  assert_type(String, $params['package_name'])

  if $params['manage'] == true {
    anchor { '::blackfire::agent::begin': }
    -> class { '::blackfire::agent::install': }
    -> class { '::blackfire::agent::config': }
    ~> class { '::blackfire::agent::service': }
    ~> anchor { '::blackfire::agent::end': }
  }

}

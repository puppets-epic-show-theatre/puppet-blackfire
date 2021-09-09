# Installs and configures Blackfire PHP extension
class blackfire::php inherits blackfire {

  $default_params = {
    manage => true,
    version => 'latest',
    server_id => $::blackfire::server_id,
    server_token => $::blackfire::server_token,
    agent_socket => 'unix:///var/run/blackfire/agent.sock',
    log_file => '',
    log_level => 1,
    agent_timeout => 0.25,
    ini_path => '',
  }
  $params = merge($default_params, $::blackfire::php)
  $log_level = 0 + $params['log_level']

  assert_type(Boolean, $params['manage'])
  assert_type(String, $params['version'])
  assert_type(String, $params['server_id'])
  assert_type(String, $params['server_token'])
  assert_type(String, $params['agent_socket'])
  assert_type(String, $params['log_file'])
  assert_type(String, $params['ini_path'])
  if $log_level < 1 or $log_level > 4 {
    fail 'Ivalid log_level. Valid levels are: 4 - debug, 3 - info, 2 - warning, 1 - error'
  }
  if $params['manage'] == true {
    anchor { '::blackfire::php::begin': }
    -> class { '::blackfire::php::install': }
    -> class { '::blackfire::php::config': }
    ~> anchor { '::blackfire::php::end': }
  }
}

# Installs and configures Blackfire agent and PHP extension
class blackfire (
  String $server_id = $blackfire::params::server_id,
  String $server_token = $blackfire::params::server_token,
  Hash $agent = $blackfire::params::agent,
  Hash $php = $blackfire::params::php,
  Hash $manage_repo = $blackfire::params::manage_repo
) inherits blackfire::params {

  anchor { '::blackfire::begin': }
  -> class { '::blackfire::repo': }
  -> class { '::blackfire::agent': }
  ~> class { '::blackfire::php': }
  ~> anchor { '::blackfire::end': }

}

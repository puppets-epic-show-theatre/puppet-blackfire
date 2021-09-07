# Installs and configures Blackfire agent and PHP extension
class blackfire (
  String[1] $server_id,
  String[1] $server_token,
  Hash $agent = $blackfire::params::agent,
  Hash $php = $blackfire::params::php,
  Boolean $manage_repo = $blackfire::params::manage_repo
) inherits blackfire::params {

  anchor { '::blackfire::begin': }
  -> class { '::blackfire::repo': }
  -> class { '::blackfire::agent': }
  ~> class { '::blackfire::php': }
  ~> anchor { '::blackfire::end': }

}

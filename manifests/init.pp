# Installs and configures Blackfire agent and PHP extension
class blackfire (
  String[1] $server_id,
  String[1] $server_token,
  Hash $agent = {},
  Hash $php = {},
  Boolean $manage_repo = true,
) {

  anchor { '::blackfire::begin': }
  -> class { '::blackfire::repo': }
  -> class { '::blackfire::agent': }
  ~> class { '::blackfire::php': }
  ~> anchor { '::blackfire::end': }

}

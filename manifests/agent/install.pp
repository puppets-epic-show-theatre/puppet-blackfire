# Installs the agent
class blackfire::agent::install inherits blackfire::agent {
  package { $::blackfire::agent::params['package_name']:
    ensure => $::blackfire::agent::params['version'],
  }
}

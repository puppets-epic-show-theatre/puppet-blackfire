This module was forked from [s12v-blackfire](https://forge.puppet.com/s12v-blackfire).

# blackfire

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with blackfire](#setup)
    * [What blackfire affects](#what-blackfire-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with blackfire](#beginning-with-blackfire)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

Puppet module for installing, configuring and managing [Blackfire PHP profiler](https://blackfire.io/).

## Setup

### What blackfire affects

* The module adds blackfire repository and overwrites blackfire configuration file.
* It _does not_ restart any service, you have to do it manually.

### Setup requirements

Make sure blackfire is installed after PHP.

### Beginning with blackfire

The module includes a single public class `blackfire`.

#### Minimal configuration

You need to provide at least `server_id` and `server_token` parameters.
Also you might want to subscribe your service to be restarted when configuration has changed:
```puppet
class { 'blackfire': 
        server_id    => 'b54114a9-df8a-563b-8ba3-e5457155010e', 
        server_token => '7315b1cf617bf51575ba463e813156ed97c85d8ca5c5691db37bbfe36a622a4f', 
        notify => Service['php5-fpm']
}
```
You can get these parameters on https://blackfire.io/account/credentials.

## Usage

If you want to provide additional parameters to Agent or PHP extension:
```puppet
class { 'blackfire': 
        server_id    => 'b54114a9-df8a-563b-8ba3-e5457155010e', 
        server_token => '7315b1cf617bf51575ba463e813156ed97c85d8ca5c5691db37bbfe36a622a4f', 
        agent => { 
           log_level => 2 
        }, 
        php => { 
           log_level => 3 
        }
}
```

## Reference

### Classes

#### Public classes

 - `blackfire`: Main class

#### Private classes
 - `blackfire::agent`: Manages the Agent
 - `blackfire::agent::install`: Handles the packages.
 - `blackfire::agent::config`: Handles the configuration file.
 - `blackfire::agent::service`: Handles the service.
 - `blackfire::php`: Manages the PHP extension (Probe)
 - `blackfire::php::install`: Handles the packages.
 - `blackfire::php::config`: Handles the configuration file.
 - `blackfire::repo`: Handles the repository.

### Parameters

#### Available parameters for blackfire class

 - `agent` - Configuration for Blackfire Agent
   - `ca_cert` - PEM encoded certicates
   - `collector` - URL of Blackfire's data collector. Default is *https://blackfire.io*
   - `http_proxy` - Http proxy to use
   - `https_proxy` - Https proxy to use
   - `log_file` - The path of the log file. Use "stderr" to log to stderr. Default is *stderr*
   - `log_level` - Log verbosity level (4: debug, 3: info, 2: warning, 1: error). Default is *1*
   - `manage` - Manage Agent. Default is *true*
   - `manage_service` - Manage Agent service. Default is *true*
   - `service_ensure` - Default is *running*
   - `socket` - The socket the agent will listen to. Default is *unix:///var/run/blackfire/agent.sock*
   - `spec` - The path to the json specifications file
   - `version` - Which version of the agent to install. Default is *latest*
 - `manage_repo` - Manage Blackfire repository. Default is *true*
 - `php` - Configuration for Blackfire PHP extension
   - `agent_socket` - The agent socket. Default is *unix:///var/run/blackfire/agent.sock*
   - `agent_timeout` - The agent timeout. Default *0.25*
   - `log_file` - The path of the log file.
   - `log_level` - Log verbosity level (4: debug, 3: info, 2: warning, 1: error). Default is *1*
   - `manage` - Manage PHP extension. Default is *true*
   - `version` - Which version of the probe to install. Default is *latest*
   - `ini_path` - Path of the blackfire.ini file to be generated. If not set, will try find out the path by installed PHP Version. Default is *empty*
 - `server_id` - Server ID to use for the agent (See https://blackfire.io/account/credentials)
 - `server_token` - Server Token to use for the agent (See https://blackfire.io/account/credentials)

## Limitations

This module is currently tested on:

 - Debian (9, 10)

It may work on other distros.

## Development

### Module testing

 - `pdk validate` - Check syntax of Ruby files and call :syntax and :metadata / Validate manifests, templates, and ruby files
 - `pdk test unit` - Run unit tests
 
# Description [![Build Status](https://secure.travis-ci.org/Adaptly/rack-allow-from.png)](http://travis-ci.org/#!/Adaptly/rack-allow-from)

Rack-allow-from is a simple piece of [Rack](https://github.com/rack/rack) middleware, which accepts connections from authorized hosts. Unauthorized hosts receive "403 Unauthorized access". Hosts are defined as IP addresses, host names, or simplistic regexes of either (ie 1.2.3.* or *.example.com). 

White listed IPs are checked against `env['REMOTE_ADDR']`. White listed host names are validated against the client provided header, X-Remote-Hostname (env['HTTP_X_REMOTE_HOSTNAME']). When a host name is specified, its A record must match `env['REMOTE_ADDR']`, or the connection is rejected.

This version only supports Rails 3 applications.

# Configuration

* Add configuration options to config/application.rb or config/environments/*.rb
    * `config.allow_from` is defined as an array of strings
        * the default values are `["127.0.0.1", "localhost", "*.dev"]`
        * add hosts using this idiom `config.allow_from += ["host.name"]`, unless you know what you're doing
        * Configuring rack-allow-from with regex characters, other than *, is not supported. You can likely use most matchers with ease, but all periods are escaped, ie `*.example.com` becomes `.*\.example\.com`
* Acceptable array elements are IP addresses, hostnames or blobs of either
    * `["127.0.0.1", "192.168.*", "example.com", "*.example.com"]`
* `Rails.configuration.allow_from.empty?` will reject all requests
* A nil `Rails.configuration.allow_from` accepts all requests

The middlware is inserted during boot, using [Rails::Railtie](http://api.rubyonrails.org/classes/Rails/Railtie.html) and should appear near the top of `rake middleware`.

# Examples

1. Allowing an entire class C to connect to your app
    * Assume your private network is 192.168.1.0/24 and your dev machine's IP is 192.168.1.2
    * config/application.rb would define allow_hosts as `config.allow_hosts += ["192.168.1.*"]
    * Boot your app, `rails s`
    * `curl http://192.168.1.2:3000/`
1. Allowing an entire domain to connect to your app
    * Assume your domain is example.com, foo.example.com's A record is 192.168.1.2
    * config/application.rb would define allow_hosts as `config.allow_hosts += ["*.example.com"]`
    * Add `192.168.1.2 foo.example.com` to /etc/hosts
    * Boot your app, `rails s`
    * `curl -H "X-Remote-Hostname: foo.example.com" http://192.168.1.2:3000/`

# Contributing to rack-allow-from
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright (c) 2012 Adaptly. See LICENSE.txt for further details.


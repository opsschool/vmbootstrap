#!/usr/bin/env ruby
require 'rubygems' if RUBY_VERSION < "1.9"
require 'chef/config'
require 'chef/log'
require 'chef/rest'
require 'chef/role'
require 'haml'
require 'sinatra/base'
require 'sinatra/config_file'
require 'pry'

class VMBootstrap < Sinatra::Base

  configure do
    register Sinatra::ConfigFile
    config_file './config/config.yml'

    @@chef_rest = Chef::REST.new(settings.chef_server_url, settings.chef_client_name, settings.chef_key_path)
  end

  get '/' do
    @exercises = {}
    @@chef_rest.get_rest("/roles").each_with_index do |val,index|
      @exercises[index] = @@chef_rest.get_rest("/roles/#{val[0]}").description
    end
    haml :index
  end

end

require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
disable :run
require './vmbootstrap.rb'
run VMBootstrap

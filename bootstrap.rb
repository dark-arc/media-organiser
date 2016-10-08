#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

Dir["./app/**/*.rb"].each {|file| require file}


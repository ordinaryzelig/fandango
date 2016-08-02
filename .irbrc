require 'bundler/setup'
Bundler.require :default, :development

WebMock.allow_net_connect!

require 'fandango'

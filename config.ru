require "sinatra"
require "sinatra/reloader"
require './lib/jruby_activiti/web'

Activiti = JrubyActiviti.setup do |config|
  config.config_path = "config/activiti.cfg.xml"
end

JrubyActiviti::Web.class_eval do
  configure :development do
    register Sinatra::Reloader
  end
end

map "/activiti" do
  run JrubyActiviti::Web
end
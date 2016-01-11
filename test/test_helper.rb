require 'jruby_activiti'

Activiti = JrubyActiviti.build_engine do |engine|
  engine.config_path = "test/resources/activiti.cfg.xml"
end

require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'

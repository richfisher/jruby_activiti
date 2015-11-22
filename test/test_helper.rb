module JrubyActiviti
  ConfigPath = "test/resources/activiti.cfg.xml"
end

require 'jruby_activiti'

Activiti = JrubyActiviti.build_engine

require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'

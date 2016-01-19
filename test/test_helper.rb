require 'jruby_activiti'

require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'

Activiti = JrubyActiviti.build_engine do |engine|
  engine.config_path = "config/activiti.cfg.xml"
end

def assert_difference(cmd, target_count)
  count1 = eval(cmd)
  yield if block_given?
  count2 = eval(cmd)

  assert_equal target_count, count2-count1 
end
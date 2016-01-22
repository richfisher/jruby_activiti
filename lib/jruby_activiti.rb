require 'java'
$CLASSPATH << "config"

require "jruby_activiti/version"
require "jruby_activiti/web"
# require File.dirname(__FILE__) + '/../java/target/jrubyactiviti-2.0.jar'
require File.dirname(__FILE__) + '/jar/jrubyactiviti-2.0.jar'

require "jbundler"
Bundler.require "activiti-engine"
Bundler.require "util"

module JrubyActiviti
  class << self
    attr_accessor :config_path
  end

  SERVICES = [
    'RepositoryService',
    'RuntimeService',
    'TaskService',
    'ManagementService',
    'IdentityService',
    'HistoryService',
    'FormService'
  ]

  def self.build_engine
    yield self if block_given?
    self.config_path ||= "config/activiti.cfg.xml"

    return self
  end

  def self.get_engine_instance
    return if @engine

    configuration = org.activiti.engine.ProcessEngineConfiguration.
      createProcessEngineConfigurationFromResource(self.config_path)
    @engine = configuration.buildProcessEngine
  end

  def self.const_missing(const)
    const_name = const.to_s
    if const_name == 'Engine' || SERVICES.include?(const_name)
      self.get_engine_instance
      self.set_activiti_const
      return const_get(const_name)
    else
      super
    end
  end

  def self.set_activiti_const
    const_set 'Engine', @engine
    for name in SERVICES
      const_set name, @engine.send("get#{name}")
    end
  end

  module Utils
    def self.hash_to_map(hash)
      map = java.util.HashMap.new
      hash.each do |k,v|
        map.put(k.to_s,v.to_s)
      end
      map
    end
  end
end
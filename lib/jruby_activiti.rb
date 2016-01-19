include Java
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

  def self.build_engine
    return self if @engine

    yield self if block_given?
    self.config_path ||= "config/activiti.cfg.xml"

    configuration = Java::OrgActivitiEngine::ProcessEngineConfiguration.
      createProcessEngineConfigurationFromResource(self.config_path)
    @engine = configuration.buildProcessEngine
    self.set_activiti_const

    return self
  end

  def self.set_activiti_const
    const_set 'Engine', @engine
    const_set 'RepositoryService', @engine.getRepositoryService()
    const_set 'RuntimeService', @engine.getRuntimeService()
    const_set 'TaskService', @engine.getTaskService()
    const_set 'ManagementService', @engine.getManagementService()
    const_set 'IdentityService', @engine.getIdentityService()
    const_set 'HistoryService', @engine.getHistoryService()
    const_set 'FormService', @engine.getFormService()
  end

  module Utils
    def self.hash_to_map(hash)
      map = Java::JavaUtil::HashMap.new
      hash.each do |k,v|
        map.put(k.to_s,v.to_s)
      end
      map
    end
  end
end
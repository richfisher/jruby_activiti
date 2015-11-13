require "jruby_activiti/version"

require "jbundler"
Bundler.require "activiti-engine"

module JrubyActiviti
  ConfigPath ||= "config/activiti.cfg.xml"

  def self.build_engine
    Activiti.build_engine
  end

  module Activiti
    def self.build_engine
      return self if @engine

      configuration = Java::OrgActivitiEngine::ProcessEngineConfiguration.
        createProcessEngineConfigurationFromResource(ConfigPath)
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
  end
end
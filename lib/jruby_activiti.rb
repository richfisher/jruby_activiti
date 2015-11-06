require "jruby_activiti/version"

require "jbundler"
Bundler.require "activiti-engine"

module JrubyActiviti
  ConfigPath ||= "config/activiti.cfg.xml"

  def self.get_engine
    configuration = Java::OrgActivitiEngine::ProcessEngineConfiguration.
      createProcessEngineConfigurationFromResource(ConfigPath)
    configuration.buildProcessEngine
  end

  module Activiti
    Engine              = JrubyActiviti.get_engine
    RepositoryService   = Engine.getRepositoryService()
    RuntimeService      = Engine.getRuntimeService()
    TaskService         = Engine.getTaskService()
    ManagementService   = Engine.getManagementService()
    IdentityService     = Engine.getIdentityService()
    HistoryService      = Engine.getHistoryService()
    FormService         = Engine.getFormService()

  end
end
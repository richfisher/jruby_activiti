require "jruby_activiti/version"

require "jbundler"
Bundler.require "activiti-engine"

ActivitiConfigPath ||= "config/activiti.cfg.xml"

module JrubyActiviti
  def self.get_engine
    configuration = Java::OrgActivitiEngine::ProcessEngineConfiguration.
      createProcessEngineConfigurationFromResource(ActivitiConfigPath)
    configuration.buildProcessEngine
  end
end

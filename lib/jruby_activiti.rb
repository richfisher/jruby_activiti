require "jruby_activiti/version"

require "jbundler"
Bundler.require "activiti-engine"

ActivitiConfigPath ||= "config/activiti.cfg.xml"
configuration = Java::OrgActivitiEngine::ProcessEngineConfiguration.
  createProcessEngineConfigurationFromResource(ActivitiConfigPath)
ActivitiEngine = configuration.buildProcessEngine

module JrubyActiviti
  # Your code goes here...
end

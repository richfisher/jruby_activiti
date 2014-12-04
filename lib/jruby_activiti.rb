require "jruby_activiti/version"

require "jbundler"
Bundler.require "activiti-engine"

configuration = Java::OrgActivitiEngine::ProcessEngineConfiguration.
  createProcessEngineConfigurationFromResource("config/activiti.cfg.xml")
ActivitiEngine = configuration.buildProcessEngine

module JrubyActiviti
  # Your code goes here...
end

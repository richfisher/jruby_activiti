require 'test_helper'

require "jbundler"

Bundler.require "activiti-engine"
Bundler.require "h2"

class BaseTest < Minitest::Test
  def test_process
    @process_engine_configuration = Java::OrgActivitiEngine::ProcessEngineConfiguration.createProcessEngineConfigurationFromResource("test/activiti.cfg.xml")
    @process_engine = @process_engine_configuration.buildProcessEngine
    @repositoryService = @process_engine.getRepositoryService()
    @repositoryService.createDeployment().
      addClasspathResource("test/VacationRequest.bpmn20.xml").
      deploy()

    count = @repositoryService.createProcessDefinitionQuery().count()
    assert_equal 1, count

    runtime_service = @process_engine.getRuntimeService();
    variables = {
      'employeeName' => "Kermit",
      'numberOfDays' =>  4,
      'vacationMotivation' => "I'm really tired!"
    }
    assert_output(/hello, this is a script task/) do
      runtime_service.startProcessInstanceByKey("vacationRequest", variables);
    end

    instance_count = runtime_service.createProcessInstanceQuery().count()
    assert_equal 1, instance_count

    task_service = @process_engine.getTaskService();
    tasks = task_service.createTaskQuery().taskCandidateGroup("management").list();
    task = tasks.first
    assert_equal 'Handle vacation request', task.getName

    task_service = @process_engine.getTaskService();
    tasks = task_service.createTaskQuery().taskCandidateGroup("management").list();
    task = tasks.first
    task_variables = {
      "vacationApproved" => "false",
      "managerMotivation" => "We have a tight deadline!"
    }
    task_service.complete(task.getId, task_variables);

    tasks = task_service.createTaskQuery().taskAssignee("Kermit").list();
    task = tasks.first
    assert_equal 'Adjust vacation request', task.getName
  end
end

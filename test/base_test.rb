require 'test_helper'

Bundler.require "h2"

class BaseTest < Minitest::Test
  def deploy_vacation_request
    repositoryService = ActivitiEngine.getRepositoryService()
    repositoryService.createDeployment().
      addClasspathResource("test/VacationRequest.bpmn20.xml").
      deploy()
  end

  def test_create_deploy
    repositoryService = ActivitiEngine.getRepositoryService()
    before_count = repositoryService.createProcessDefinitionQuery().count()
    deploy_vacation_request
    after_count = repositoryService.createProcessDefinitionQuery().count()
    assert_equal 1, after_count - before_count
  end

  def test_create_process_instance
    deploy_vacation_request

    runtime_service = ActivitiEngine.getRuntimeService();
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
  end

  def test_task_process
    deploy_vacation_request
    
    runtime_service = ActivitiEngine.getRuntimeService();
    runtime_service.startProcessInstanceByKey("vacationRequest", {});

    task_service = ActivitiEngine.getTaskService();
    tasks = task_service.createTaskQuery().taskCandidateGroup("management").list();
    task = tasks.first
    assert_equal 'Handle vacation request', task.getName

    task_service = ActivitiEngine.getTaskService();
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

require 'test_helper'

Bundler.require "h2"

Activiti = JrubyActiviti::Activiti

class BaseTest < Minitest::Test
  def deploy_vacation_request
    Activiti::RepositoryService.createDeployment().
      addClasspathResource("test/resources/VacationRequest.bpmn20.xml").
      deploy()
  end

  def test_create_deploy
    before_count = Activiti::RepositoryService.createProcessDefinitionQuery().count()
    deploy_vacation_request
    after_count = Activiti::RepositoryService.createProcessDefinitionQuery().count()
    assert_equal 1, after_count - before_count
  end

  def test_create_process_instance
    deploy_vacation_request

    variables = {
      'employeeName' => "Kermit",
      'numberOfDays' =>  4,
      'vacationMotivation' => "I'm really tired!"
    }
    assert_output(/hello, this is a script task/) do
      Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", variables);
    end

    instance_count = Activiti::RuntimeService.createProcessInstanceQuery().count()
    assert_equal 1, instance_count
  end

  def test_task_process
    deploy_vacation_request
    
    Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", {});

    tasks = Activiti::TaskService.createTaskQuery().taskCandidateGroup("management").list();
    task = tasks.first
    assert_equal 'Handle vacation request', task.getName

    tasks = Activiti::TaskService.createTaskQuery().taskCandidateGroup("management").list();
    task = tasks.first
    task_variables = {
      "vacationApproved" => "false",
      "managerMotivation" => "We have a tight deadline!"
    }
    Activiti::TaskService.complete(task.getId, task_variables);

    tasks = Activiti::TaskService.createTaskQuery().taskAssignee("Kermit").list();
    task = tasks.first
    assert_equal 'Adjust vacation request', task.getName
  end
end

require 'test_helper'

Bundler.require "h2"

class IntegrationTest < Minitest::Test
  def before_setup
    @@deployed ||= deploy_vacation_request
  end

  def deploy_vacation_request
    Activiti::RepositoryService.createDeployment().
      addClasspathResource("test/resources/VacationRequest.bpmn20.xml").
      deploy()
  end

  def task_variables
    return {
      'employeeName' => "Kermit",
      'numberOfDays' =>  4,
      'vacationMotivation' => "I'm really tired!"
    }
  end

  def test_create_deploy
    assert_difference 'Activiti::RepositoryService.createProcessDefinitionQuery().count()', 1 do
      deploy_vacation_request
    end
  end

  def test_create_process_instance
    assert_difference 'Activiti::RuntimeService.createProcessInstanceQuery().count()', 1 do
      Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", task_variables);
    end
  end

  def test_create_process_instance_with_output
    assert_output(/hello, this is a script task/) do
      Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", task_variables);
    end
  end

  def test_task_query
    Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", task_variables);

    tasks = Activiti::TaskService.createTaskQuery().taskCandidateGroup("management").list();
    task = tasks.first()
    assert_equal 'Handle vacation request', task.getName()
  end

  def test_complete_task
    Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", task_variables);

    tasks = Activiti::TaskService.createTaskQuery().taskCandidateGroup("management").orderByTaskCreateTime().desc().list();
    task = tasks.first()
    task_variables = {
      "vacationApproved" => "false",
      "managerMotivation" => "We have a tight deadline!"
    }
    Activiti::TaskService.complete(task.getId(), task_variables);

    tasks = Activiti::TaskService.createTaskQuery().taskAssignee("Kermit").list();
    task = tasks.first
    assert_equal 'Adjust vacation request', task.getName()
  end
end

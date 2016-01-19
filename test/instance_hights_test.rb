require 'test_helper'

class InstanceHightsTest < Minitest::Test
  def test_instance_diagram
    highlighter = Java::OrgJrubyactiviti::ProcessInstanceHighlights.new(
      Activiti::RuntimeService,
      Activiti::RepositoryService,
      Activiti::HistoryService)

    Activiti::RepositoryService.createDeployment().
      addClasspathResource("test/resources/VacationRequest.bpmn20.xml").
      deploy()
    Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", {});

    instance = Activiti::RuntimeService.createProcessInstanceQuery().list().first()
    assert highlighter.getHighlighted(instance.getId())
  end
end
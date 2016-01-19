require 'test_helper'

class ProcessDiagramTest < Minitest::Test
  def test_definition_diagram
    diagramer = Java::OrgJrubyactiviti::ProcessDiagram.new(
      Activiti::RuntimeService,
      Activiti::RepositoryService,
      Activiti::HistoryService)

    Activiti::RepositoryService.createDeployment().
      addClasspathResource("test/resources/VacationRequest.bpmn20.xml").
      deploy()
    Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", {});

    pdid = Activiti::RuntimeService.createProcessInstanceQuery().list().first().getProcessDefinitionId()
    assert diagramer.getDiagramNode(nil, pdid)
  end

  def test_instance_diagram
    diagramer = Java::OrgJrubyactiviti::ProcessDiagram.new(
      Activiti::RuntimeService,
      Activiti::RepositoryService,
      Activiti::HistoryService)

    Activiti::RepositoryService.createDeployment().
      addClasspathResource("test/resources/VacationRequest.bpmn20.xml").
      deploy()
    Activiti::RuntimeService.startProcessInstanceByKey("vacationRequest", {});

    instance = Activiti::RuntimeService.createProcessInstanceQuery().list().first()
    assert diagramer.getDiagramNode(instance.getId(), nil)
  end
end
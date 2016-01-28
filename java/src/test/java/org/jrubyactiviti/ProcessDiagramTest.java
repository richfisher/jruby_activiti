package org.jrubyactiviti;

import static org.junit.Assert.*;

import java.util.*;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.test.ActivitiRule;
import org.activiti.engine.test.Deployment;
import org.junit.*;

import org.jrubyactiviti.ProcessDiagram;;

public class ProcessDiagramTest {
	@Rule 
	public ActivitiRule activitiRule = new ActivitiRule("activiti.cfg-mem.xml");
	
	private ProcessInstance startProcessInstance() {
		RuntimeService runtimeService = activitiRule.getRuntimeService();
		Map<String, Object> variableMap = new HashMap<String, Object>();
		variableMap.put("v1", "k1");
		return runtimeService.startProcessInstanceByKey("FiveUserTasks", variableMap);
	}

	@Test
	@Deployment(resources={"FiveUserTasks.bpmn20.xml"})
	public void test_definition_diagram() {
		RepositoryService repositoryService = activitiRule.getRepositoryService();
		HistoryService historyService = activitiRule.getHistoryService();
		RuntimeService runtimeService = activitiRule.getRuntimeService();
		
		startProcessInstance();
		ProcessInstance pi = runtimeService.createProcessInstanceQuery().list().get(0);
		
		ProcessDiagram diagramer = new ProcessDiagram(runtimeService, repositoryService, historyService);
		
		assertNotNull(diagramer.getDiagramNode(null, pi.getProcessDefinitionId()));
	}
	
	@Test
	@Deployment(resources={"FiveUserTasks.bpmn20.xml"})
	public void test_instance_diagram() {
		RepositoryService repositoryService = activitiRule.getRepositoryService();
		HistoryService historyService = activitiRule.getHistoryService();
		RuntimeService runtimeService = activitiRule.getRuntimeService();
		
		startProcessInstance();
		ProcessInstance pi = runtimeService.createProcessInstanceQuery().list().get(0);
		
		ProcessDiagram diagramer = new ProcessDiagram(runtimeService, repositoryService, historyService);
		
		assertNotNull(diagramer.getDiagramNode(pi.getId(), null));
	}
}
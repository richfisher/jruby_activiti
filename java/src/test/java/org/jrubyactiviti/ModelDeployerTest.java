package org.jrubyactiviti;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.InputStream;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.activiti.engine.test.ActivitiRule;
import org.activiti.engine.test.Deployment;
import org.apache.commons.io.IOUtils;
import org.junit.Rule;
import org.junit.Test;

import org.jrubyactiviti.ModelDeployer;

public class ModelDeployerTest {
	@Rule 
	public ActivitiRule activitiRule = new ActivitiRule("activiti.cfg-mem.xml");

	private Model createModel() throws IOException{
		RepositoryService repositoryService = activitiRule.getRepositoryService();
		Model model = repositoryService.newModel();
		model.setName("test");
		model.setMetaInfo("{}");
		repositoryService.saveModel(model);
		
		InputStream is = ModelerTest.class.getResourceAsStream("/model_example_editor_source.json");
		repositoryService.addModelEditorSource(model.getId(), IOUtils.toByteArray(is));
		
		return model;
	}

	@Test
	@Deployment(resources={"FiveUserTasks.bpmn20.xml"})
	public void test_deploy() throws IOException {
		Model model = createModel();
		RepositoryService repositoryService = activitiRule.getRepositoryService();
		
		long count1 = repositoryService.createProcessDefinitionQuery().count();
		
		ModelDeployer deployer = new ModelDeployer(repositoryService, model.getId());
		deployer.deployModel();
		
		long count2 = repositoryService.createProcessDefinitionQuery().count();
		
		assertEquals(1, count2-count1);
	}
}
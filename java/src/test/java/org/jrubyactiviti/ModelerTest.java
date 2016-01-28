package org.jrubyactiviti;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.Model;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.test.ActivitiRule;
import org.activiti.engine.test.Deployment;
import org.apache.commons.io.IOUtils;
import org.junit.Rule;
import org.junit.Test;

import com.fasterxml.jackson.databind.node.ObjectNode;

import org.jrubyactiviti.Modeler;

public class ModelerTest {
	@Rule 
	public ActivitiRule activitiRule = new ActivitiRule("activiti.cfg-mem.xml");

	private Model createModel() throws IOException{
		RepositoryService repositoryService = activitiRule.getRepositoryService();
		Model model = repositoryService.newModel();
		model.setName("test");
		model.setMetaInfo("{}");
		repositoryService.saveModel(model);
		
		InputStream is = ModelerTest.class.getResourceAsStream("/model_init_editor_source.json");
		repositoryService.addModelEditorSource(model.getId(), IOUtils.toByteArray(is));
		
		return model;
	}

	@Test
	@Deployment(resources={"FiveUserTasks.bpmn20.xml"})
	public void test_save() throws IOException {
		Model model = createModel();
		RepositoryService repositoryService = activitiRule.getRepositoryService();
		Modeler modeler = new Modeler(repositoryService);
		
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("name", "name");
		hm.put("description", "description");
		hm.put("json_xml", IOUtils.toString(ModelerTest.class.getResourceAsStream("/model_init_editor_source.json")));
		hm.put("svg_xml", IOUtils.toString(ModelerTest.class.getResourceAsStream("/model_svg_xml.xml")));
		
		modeler.save(model.getId(), hm);
	}
	
	@Test
	@Deployment(resources={"FiveUserTasks.bpmn20.xml"})
	public void test_show() throws IOException {
		Model model = createModel();
		
		RepositoryService repositoryService = activitiRule.getRepositoryService();
		Modeler modeler = new Modeler(repositoryService);
		ObjectNode output = modeler.show(model.getId());
		assertNotNull(output);
	}
}
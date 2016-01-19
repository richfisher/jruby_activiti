package org.jrubyactiviti;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.UnsupportedEncodingException;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

public class ModelDeployer {
  protected static final Logger LOGGER = LoggerFactory.getLogger(ModelDeployer.class);

  protected RepositoryService repositoryService;
  protected Model modelData;

  public ModelDeployer(RepositoryService repositoryService, String modelId){
    this.repositoryService = repositoryService;
    this.modelData = repositoryService.getModel(modelId);
  }

  protected void deployModel() {
    try {
      final ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelData.getId()));
      deployModelerModel(modelNode);

    } catch (Exception e) {
      LOGGER.error("Failed to deploy model", e);
    }
  }

  protected void deployModelerModel(final ObjectNode modelNode) {
    BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
    byte[] bpmnBytes = new BpmnXMLConverter().convertToXML(model);
    
    String processName = modelData.getName() + ".bpmn20.xml";
    Deployment deployment = repositoryService.createDeployment()
            .name(modelData.getName())
            .addString(processName, new String(bpmnBytes))
            .deploy();
  }
}
### Java
Modeler.java
  save => org.activiti.rest.editor.model.ModelSaveRestResource.saveModel
  	add initialize funciton
  	relace MultiValueMap with HashMap
  	replace getFirst with get
  show => org.activiti.rest.editor.model.ModelEditorJsonRestResource.getEditorJson
  	add initialize funciton


StencilsetResource.java
  getStencilset => org.activiti.rest.editor.main.StencilsetRestResource.getStencilset
  relace this.getClass() with StencilsetResource.class


ProcessDiagram.java => org.activiti.rest.diagram.services.BaseProcessDefinitionDiagramLayoutResource
  add initialize funciton


### ModelDeployer.java
  from org.activiti.editor.ui.EditorProcessDefinitionDetailPanel 
  copy deployModel and deployModelerModel functions
  add initialize funciton
 


### Frontend
cp editor-app,modeler.html,diagram-viewer from Activiti-version/modules/activiti-webapp-explorer2/src/main/webapp/ to public

public/editor-app/app-cfg.js
  from `'contextRoot' : '/activiti-explorer/service'` to `'contextRoot' : 'service'`
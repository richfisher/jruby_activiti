Modeler.java
  save => org.activiti.rest.editor.model.ModelSaveRestResource.saveModel
  	add initialize funciton
  	relace MultiValueMap with HashMap
  	replace getFirst with get
  show => org.activiti.rest.editor.model.ModelEditorJsonRestResource.getEditorJson
  	add initialize funciton


StencilsetResource.java
  getStencilset => org.activiti.rest.editor.main.StencilsetRestResource.getStencilset


ProcessDiagram.java => org.activiti.rest.diagram.services.BaseProcessDefinitionDiagramLayoutResource
  add initialize funciton



public/editor-app/app-cfg.js
  from `'contextRoot' : '/activiti-explorer/service'` to `'contextRoot' : 'service'`
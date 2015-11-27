require 'sinatra'

module JrubyActiviti
  class Web < Sinatra::Base
    get "/" do
      redirect uri('/models')
    end

    get "/activiti-explorer/service/model/:model_id/json" do
      model = Activiti::RepositoryService.createModelQuery().modelId(params['model_id']).singleResult()
      Java::Jrubyactiviti::Modeler.show(Activiti::RepositoryService, model.getId()).to_s
    end

    get "/activiti-explorer/service/editor/stencilset" do
      Java::Jrubyactiviti::StencilsetResource.getStencilset().to_s
    end

    put "/activiti-explorer/service/model/:model_id/save" do
      model = Activiti::RepositoryService.createModelQuery().modelId(params['model_id']).singleResult()
      map = Activiti::Utils.hash_to_map(params)
      Java::Jrubyactiviti::Modeler.save(Activiti::RepositoryService, model.getId(), map)
      200
    end

    get "/models" do
      @models = Activiti::RepositoryService.createModelQuery().orderByCreateTime().desc().list()
      erb 'models/index'.to_sym
    end

    get "/models/new" do
      erb 'models/new'.to_sym
    end

    post "/models" do
      model = Activiti::RepositoryService.newModel
      model.setName(params[:name])
      model.setCategory(params[:category])
      model.setMetaInfo('{}')
      Activiti::RepositoryService.saveModel(model)

      init_json = '{"id":"canvas","resourceId":"canvas","stencilset":{"namespace":"http://b3mn.org/stencilset/bpmn2.0#"}}'
      Activiti::RepositoryService.addModelEditorSource(model.getId(), init_json.bytes)

      redirect uri('/models')
    end
  end
end
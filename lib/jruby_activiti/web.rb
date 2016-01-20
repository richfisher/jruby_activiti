require 'sinatra'

require 'jruby_activiti'

module JrubyActiviti
  class Web < Sinatra::Application
    set :root, File.expand_path(File.dirname(__FILE__) + "/../../web")
    set :public_folder, proc { "#{root}/public" }
    set :views, proc { "#{root}/views" }

    DEFAULT_TABS = {
      # "Dashboard"               => '',
      "Models"                  => 'models',
      "Process Definations"     => 'process_definitions',
      # "Process Instances"       => 'process_instances',
    }

    class << self
      def default_tabs
        DEFAULT_TABS
      end
    end

    def root_path
      '/activiti/'
    end

    def current_path
      @current_path ||= request.path_info.gsub(/^\//,'')
    end

    get "/" do
      # erb 'index'.to_sym
      redirect uri('/models')
    end

    get "/service/model/:model_id/json" do
      model = Activiti::RepositoryService.createModelQuery().modelId(params['model_id']).singleResult()
      modeler = org.jrubyactiviti.Modeler.new(Activiti::RepositoryService)
      modeler.show(model.getId()).to_s
    end

    get "/service/editor/stencilset" do
      org.jrubyactiviti.StencilsetResource.getStencilset().to_s
    end

    put "/service/model/:model_id/save" do
      model = Activiti::RepositoryService.createModelQuery().modelId(params['model_id']).singleResult()
      map = Activiti::Utils.hash_to_map(params)
      modeler = org.jrubyactiviti.Modeler.new(Activiti::RepositoryService)
      modeler.save(model.getId(), map)
      200
    end

    get "/service/process-definition/:process_definition_id/diagram-layout" do
      diagramer = org.jrubyactiviti.ProcessDiagram.new(
        Activiti::RuntimeService,
        Activiti::RepositoryService,
        Activiti::HistoryService)
      json = diagramer.getDiagramNode(nil, params[:process_definition_id]).to_s
      "#{params[:callback]}(#{json})"
    end

    # seems not be used
    get "/service/process-instance/:process_instance_id/diagram-layout" do
      diagramer = org.jrubyactiviti.ProcessDiagram.new(
        Activiti::RuntimeService,
        Activiti::RepositoryService,
        Activiti::HistoryService)
      json = diagramer.getDiagramNode(params[:process_instance_id], nil).to_s
      "#{params[:callback]}(#{json})"
    end

    get "/service/process-instance/:process_instance_id/highlights" do
      highlighter = org.jrubyactiviti.ProcessInstanceHighlights.new(
        Activiti::RuntimeService,
        Activiti::RepositoryService,
        Activiti::HistoryService)
      json = highlighter.getHighlighted(params[:process_instance_id]).to_s
      "#{params[:callback]}(#{json})"
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

      redirect uri("/modeler.html?modelId=#{model.getId()}")
    end

    get "/models/:model_id/deploy" do
      deployer = org.jrubyactiviti.ModelDeployer.new(
        Activiti::RepositoryService,
        params[:model_id])
      deployer.deployModel()

      redirect uri('/process_definitions')
    end

    get "/process_definitions" do
      @process_definitions = Activiti::RepositoryService.createProcessDefinitionQuery().list()
      erb 'process_definitions/index'.to_sym
    end

    get "/process_definitions/:id" do
      @process_definition = Activiti::RepositoryService.createProcessDefinitionQuery().processDefinitionId(params[:id]).singleResult()
      erb 'process_definitions/show'.to_sym
    end

    get "/process_instances" do
      erb 'process_instances/index'.to_sym
    end
  end
end
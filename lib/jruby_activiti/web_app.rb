require 'sinatra'

module JrubyActiviti
  class WebApp < Sinatra::Base
    get "/" do
      "Hello"
    end

    get "/models" do
      @title = 'test'
      erb 'models/index'.to_sym
    end

    get "/model.json" do
      node = Java::Jrubyactiviti::Modeler.show(Activiti::RepositoryService, model_id)
      node.to_json
    end
  end
end
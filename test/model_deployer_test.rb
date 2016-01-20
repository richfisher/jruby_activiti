require 'test_helper'

class ModelDeployerTest < Minitest::Test
  def create_model
    model = Activiti::RepositoryService.newModel
    model.setName('model_test')
    model.setMetaInfo('{}')
    Activiti::RepositoryService.saveModel(model)
    init_json = File.open(File.dirname(__FILE__)+'/resources/model_example_editor_source.json').read
    Activiti::RepositoryService.addModelEditorSource(model.getId(),init_json.bytes)
    model
  end

  def test_deploy
    model = create_model
    deployer = org.jrubyactiviti.ModelDeployer.new(Activiti::RepositoryService, model.getId())

    assert_difference 'Activiti::RepositoryService.createProcessDefinitionQuery().count()', 1 do
      deployer.deployModel()
    end
  end
end

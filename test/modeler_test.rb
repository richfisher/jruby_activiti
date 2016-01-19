require 'test_helper'

class ModelerTest < Minitest::Test
  def setup
    @modeler = Java::OrgJrubyactiviti::Modeler.new(Activiti::RepositoryService)
  end

  def create_model
    model = Activiti::RepositoryService.newModel
    model.setName('modeler_test')
    model.setMetaInfo('{}')
    Activiti::RepositoryService.saveModel(model)
    init_json = File.open(File.dirname(__FILE__)+'/resources/model_init_editor_source.json').read
    Activiti::RepositoryService.addModelEditorSource(model.getId(),init_json.bytes)
    model
  end

  def test_save
    hash = {
      'name': 'aname',
      'description': 'adescription',
      'json_xml': File.open(File.dirname(__FILE__)+'/resources/model_json_xml.json').read,
      'svg_xml': File.open(File.dirname(__FILE__)+'/resources/model_svg_xml.xml').read
    }
    map = Activiti::Utils.hash_to_map(hash)

    model = create_model
    @modeler.save(model.getId(), map)
  end

  def test_show
    model = create_model
    assert @modeler.show(model.getId())
  end
end

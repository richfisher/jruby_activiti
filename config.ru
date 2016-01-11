require './lib/jruby_activiti/web'

Activiti = JrubyActiviti.build_engine do |engine|
  engine.config_path = "test/resources/activiti.cfg.xml"
end

map "/activiti" do
  run JrubyActiviti::Web
end
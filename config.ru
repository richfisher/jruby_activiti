require './lib/jruby_activiti/web'

Activiti = JrubyActiviti.build_engine do |engine|
  engine.path = "test/resources/activiti.cfg.xml"
end

map "/activiti" do
  run JrubyActiviti::Web
end
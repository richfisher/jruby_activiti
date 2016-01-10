require './lib/jruby_activiti/web'

map "/activiti" do
  run JrubyActiviti::Web
end
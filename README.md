# JrubyActiviti

Integrate Activiti BPM in JRuby/Rails, including Activiti Engine, Modeler and Diagram Viewer.

## Test Environment
JRuby-9.0.4.0, Activiti-5.19.0

## Installation

Edit your application's Gemfile, add `gem 'jruby_activiti'`, and must remove `gem 'therubyrhino'` line.

Run the `bundle install` command to install it.

You need to run the generator:

```
rails g jruby_activiti:install
```

It will create 4 files, edit the log4j.properties, config/activiti.cfg.xml as your need.

```
create  Jarfile
create  config/log4j.properties
create  config/activiti.cfg.xml
create  config/initializers/jruby_activiti.rb
route   mount JrubyActiviti::Web => '/activiti' if defined?(JrubyActiviti)
```

Add db jar in Jarfile. Example: `jar 'com.h2database:h2', '>= 1.4'`

And then execute `jbundle install`


## Usage
You can access Activiti directly by using `Activiti`. For example, in a Rails controller

``` ruby
# Activiti::Engine
# Activiti::RepositoryService
# Activiti::RuntimeService
# Activiti::TaskService
# Activiti::ManagementService
# Activiti::IdentityService
# Activiti::HistoryService
# Activiti::FormService

Activiti::RepositoryService.createDeployment().
  addClasspathResource("config/your_bpm_xml_file.bpmn20.xml").
  deploy()
```

## Enable Activiti Modeler and Diagram Viewer in Rails
visit `localhost:3000/activiti`

Modeler
`/activiti/modeler.html?modelId=your_model_id`

View Process Definition in Diagram Viewer
`/activiti/diagram-viewer/index.html?processDefinitionId=v1`

View Process Instance in Diagram Viewer
`/activiti/diagram-viewer/index.html?processDefinitionId=v1&processInstanceId=v2`

## Known Issues
1. NoMethodError: undefined method `useMozillaStackStyle' for Java::OrgMozillaJavascript::RhinoException:Class

`org.activiti:activiti-modeler` includes `org.apache.xmlgraphics:batik-transcoder`, that depends on outdated `org.mozilla:rhino`, which conflicts with rubygem `therubyrhino`. So you must to install `nodejs` in your machine and comment `gem 'therubyrhino'` in `Gemfile`.

## Contributing

1. Fork it ( https://github.com/richfisher/jruby_activiti/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

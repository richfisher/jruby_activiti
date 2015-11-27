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
create  log4j.properties
create  config/activiti.cfg.xml
create  config/initializers/jruby_activiti.rb
```

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

## Enable Modeler in Rails
add following line to config/routes.rb

```
mount JrubyActiviti::WebApp => "/activiti"
```

visit `localhost:3000/activiti`

## Known Issue
`org.activiti:activiti-modeler` includes `org.apache.xmlgraphics:batik-transcoder`, that depends on outdated `org.mozilla:rhino`, which conflicts with rubygem `therubyrhino`. So you must to install `nodejs` in your machine and comment `gem 'therubyrhino'` in `Gemfile`.

## Thanks
Inspired by https://github.com/boberetezeke/jruby-activiti

## Contributing

1. Fork it ( https://github.com/richfisher/jruby_activiti/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

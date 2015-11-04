# JrubyActiviti

You can directly access Activiti BPM in Ruby Web Application.

## Test Environments
JRuby-9.0.3.0, Activiti-5.18.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jruby_activiti'
```

Run the `bundle install` command to install it.

After you install and add it to your Gemfile, you need to run the generator:

```
rails g jruby_activiti:install
```

It will create 3 files, edit the config/activiti.cfg.xml as your need.

```
create  Jarfile
create  config/activiti.cfg.xml
create  config/initializers/jruby_activiti.rb
```

And then execute `jbundle install`

## Usage
You can access Activiti directly by using `ActivitiEngine`. For example, in a Rails controller

```
repositoryService = ActivitiEngine.getRepositoryService()
repositoryService.createDeployment().
  addClasspathResource("config/your_bpm_xml_file.bpmn20.xml").
  deploy()
```

## Warning
Do not create Activiti Engine in a Rails application repeatedly. Otherwise you will get exception `log writing failed. Bad file descriptor - Bad file descriptor`

## Thanks
Inspired by https://github.com/boberetezeke/jruby-activiti

## Contributing

1. Fork it ( https://github.com/richfisher/jruby_activiti/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

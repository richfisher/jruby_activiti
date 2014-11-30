# JrubyActiviti

Wrap activiti in a gem. So you can directly access activiti in Ruby Web Application.

## Installation

Git clone this project.

Add this line to your application's Gemfile:

```ruby
gem 'jruby_activiti', path: 'xxx'
```

And then execute:
```
$ bundle
$ touch Jarfile
$ jbundle
```

## Usage
Add db jar in Jarfile. Example:
```
jar 'com.h2database:h2', '>= 1.4'
```
```
$ jbundle
```

Now, You can direct access activiti in ROR.

```
configuration = Java::OrgActivitiEngine::ProcessEngineConfiguration.createProcessEngineConfigurationFromResource("config/activiti.cfg.xml")
```

## Contributing

1. Fork it ( https://github.com/richfisher/jruby_activiti/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

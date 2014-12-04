# JrubyActiviti

Wrapping Activiti BPM in a gem. So you can directly access Activiti BPM in Ruby Web Application.
Inspired by https://github.com/boberetezeke/jruby-activiti.

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

Create activiti config file. `config/activiti.cfg.xml`
```
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans   http://www.springframework.org/schema/beans/spring-beans.xsd">

  <bean id="processEngineConfiguration" class="org.activiti.engine.impl.cfg.StandaloneProcessEngineConfiguration">
    <property name="jdbcUrl" value="jdbc:h2:mem:activiti;DB_CLOSE_DELAY=1000" />
    <property name="jdbcDriver" value="org.h2.Driver" />
    <property name="jdbcUsername" value="sa" />
    <property name="jdbcPassword" value="" />
  </bean>

</beans>
```

Now, You can access Activiti directly by using `ActivitiEngine`. For example, in a Rails controller

```
repositoryService = ActivitiEngine.getRepositoryService()
repositoryService.createDeployment().
  addClasspathResource("config/your_bpm_xml_file.bpmn20.xml").
  deploy()
```

## Warning
Do not create Activiti Engine in a Rails application. Otherwise you will get exception `log writing failed. Bad file descriptor - Bad file descriptor`

## Contributing

1. Fork it ( https://github.com/richfisher/jruby_activiti/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

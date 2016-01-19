require 'rails/generators/base'

module JrubyActiviti
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a initializer and copy config files to your application."

      def create_jarfile
        copy_file "../../../../Jarfile", "Jarfile"
      end

      def create_log4j_config
        copy_file "../../../../config/log4j.properties", "config/log4j.properties"
      end

      def create_config
        copy_file "activiti.cfg.xml", "config/activiti.cfg.xml"
      end

      def create_initializer_file
        copy_file "initializer.rb", "config/initializers/jruby_activiti.rb"
      end

      def add_routes
        route "mount JrubyActiviti::Web => '/activiti' if defined?(JrubyActiviti)"
      end
    end
  end
end
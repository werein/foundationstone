module Foundationstone
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_configuration
        template "foundationstone.yml", "config/foundationstone.yml"
      end
    end
  end
end
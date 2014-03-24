module Foundationstone
  module Config
    include ActiveSupport::Configurable
    
    # Application name, it's used as namespace
    config_accessor :app_name
    config_accessor :unique_name

    # Domain, where is application running
    config_accessor :domain

    # Disqus account name
    config_accessor :disqus

    # Api key to Errbit, self hosted error catcher
    config_accessor :errbit_api_key
    config_accessor :errbit_host

    # Google Analytics
    config_accessor :google_analytics

    # Mailer settings
    config_accessor :mailer

    # Sidekiq web app
    config_accessor :sidekiq_login
    config_accessor :sidekiq_pass

    # Kaminari config
    config_accessor :kaminari_default
    
    # Reset all configurations to defaults.
    def self.reset
      file = File.exist?('config/foundationstone.yml') ? 'config/foundationstone.yml' : "#{Engine.root}/lib/generators/templates/foundationstone.yml"
      config = YAML.load_file(file)[Rails.env].deep_symbolize_keys!

      config.each do |key, value|
        send("#{key}=", value)
      end

      raise 'Error: Application name is missing' unless app_name
      raise 'Error: Unique name is missing' unless unique_name
      raise 'Error: Domain is missing' unless domain
      raise 'Error: Mailer is missing' unless mailer
    end

    # Set default values for configuration options on load
    self.reset
  end
end
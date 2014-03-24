if defined? Sidekiq
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [Foundationstone::Config.sidekiq_login, Foundationstone::Config.sidekiq_pass]
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379/0', namespace: "project:#{Foundationstone::Config.unique_name.parameterize}" }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0', namespace: "project:#{Foundationstone::Config.unique_name.parameterize}" }
  end
end
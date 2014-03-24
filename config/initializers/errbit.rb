Airbrake.configure do |config|
  config.api_key = Foundationstone::Config.errbit_api_key
  config.host    = Foundationstone::Config.errbit_host
  config.port    = 80
  config.secure  = config.port == 443
end if defined? Airbrake
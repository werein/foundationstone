# More informations:
# https://github.com/airbrake/airbrake/issues/269

Sidekiq.configure_server do |config|
  config.error_handlers << Proc.new { |ex,context| Airbrake.notify_or_ignore(ex, parameters: context) }
end if defined?(Sidekiq) && defined?(Airbrake) && Sidekiq::VERSION >= '3'
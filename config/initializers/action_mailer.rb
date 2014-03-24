ActionMailer::Base.default_url_options[:host] = Foundationstone::Config.domain

case Foundationstone::Config.mailer[:service]
when 'mandrill' 
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.mandrillapp.com',
    port: 587,
    user_name: Foundationstone::Config.mailer[:mandril][:user_name],
    password:  Foundationstone::Config.mailer[:mandril][:key]
  }
end
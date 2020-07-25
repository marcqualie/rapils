smtp_credentials = Rails.application.credentials.smtp || {}

Rails.application.config.action_mailer.raise_delivery_errors = true
Rails.application.config.action_mailer.perform_deliveries = true
Rails.application.config.action_mailer.delivery_method = :smtp
Rails.application.config.action_mailer.smtp_settings = {
  address: smtp_credentials[:host] || 'localhost',
  port: smtp_credentials[:port] || 1025,
  domain: smtp_credentials[:domain] || 'localhost',
  user_name: smtp_credentials[:username],
  password: smtp_credentials[:password],
  authentication: smtp_credentials[:authentication] || 'plain',
  enable_starttls_auto: true,
}
Rails.application.config.action_mailer.default_url_options = {
  scheme: 'https',
  host: ENV['WWW_HOST'] || smtp_credentials[:domain] || 'localhost',
}

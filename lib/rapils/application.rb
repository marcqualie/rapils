require 'diffcrypt/rails/encrypted_configuration'

module Rapils
  class Application < ::Rails::Application
    config.load_defaults 6.0

    # Configure generator defaults
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid

      # Disable things we never use
      g.assets false
      g.helper false
      g.resource_route false
      g.system_tests = nil
    end

    # Email
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV['SMTP_HOST'] || 'localhost',
      port: ENV['SMTP_PORT'] || 1025,
      domain: ENV['SMTP_DOMAIN'] || 'localhozt',
      user_name: ENV['SMTP_USERNAME'],
      password: ENV['SMTP_PASSWORD'],
      authentication: ENV['SMTP_AUTHENTICATION'] || 'plain',
      enable_starttls_auto: true,
    }
    config.action_mailer.default_url_options = {
      scheme: 'https',
      host: ENV['WWW_HOST'] || 'localhost',
    }

    # Override encryption with diffcrypt
    def encrypted(path, key_path: 'config/master.key', env_key: 'RAILS_MASTER_KEY')
      Diffcrypt::Rails::EncryptedConfiguration.new(
        config_path: Rails.root.join(path),
        key_path: Rails.root.join(key_path),
        env_key: env_key,
        raise_if_missing_key: config.require_master_key,
      )
    end
  end
end

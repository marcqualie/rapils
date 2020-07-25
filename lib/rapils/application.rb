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

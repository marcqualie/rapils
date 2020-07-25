require_relative 'boot'

require 'rapils/setup'
Rapils.setup([
  'active_model/railtie',
  # 'active_job/railtie',
  'active_record/railtie',
  # 'active_storage/engine',
  'action_controller/railtie',
  'action_mailer/railtie',
  # 'action_mailbox/engine',
  # 'action_text/engine',
  'action_view/railtie',
  # 'action_cable/engine',
  'sprockets/railtie'
  # 'rails/test_unit/railtie'
])

module Dummy
  class Application < Rapils::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end


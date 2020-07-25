module Rapils
  DEFAULT_DEPENDENCIES = [
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
    # 'sprockets/railtie',
    # 'rails/test_unit/railtie',
  ].freeze

  def self.setup(dependencies = DEFAULT_DEPENDENCIES)
    # Require core libraries that would usually be in app Gemfile
    require 'diffcrypt'
    require 'pg'

    # Load core rails dependencies
    require 'rails'
    dependencies.each { |dependency| require dependency }

    # Require the gems listed in Gemfile, including any gems
    # you've limited to :test, :development, or :production.
    Bundler.require(*Rails.groups)

    # Now we load the whole Rapils framework to hook into rails environment
    require 'rapils/engine'
    require 'rapils/application'
  end
end

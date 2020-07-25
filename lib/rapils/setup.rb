module Rapils
  def self.setup(dependencies)
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

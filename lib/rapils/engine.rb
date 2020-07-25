require 'rapils/base_controller'

# Load all models
require_relative './models/base_record'
Dir["#{__dir__}/models/**/*.rb"].sort.each { |f| require f }

module Rapils
  class Engine < Rails::Engine
    isolate_namespace Rapils

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid

      # Disable things we never use
      g.assets false
      g.helper false
      g.resource_route false
    end
  end
end

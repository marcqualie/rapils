# Load all controllers
require 'rapils/controllers/base_controller'
Dir["#{__dir__}/controllers/**/*.rb"].sort.each { |f| require f }

# Load all models
require_relative './models/base_record'
Dir["#{__dir__}/models/**/*.rb"].sort.each { |f| require f }

# Load all serializers
require_relative './serializers/base_serializer'
Dir["#{__dir__}/serializers/**/*.rb"].sort.each { |f| require f }

module Rapils
  class Engine < Rails::Engine
    isolate_namespace Rapils

    # Generators for use within the engine itself, not the consuming rails app
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid

      # Disable things we never use
      g.assets false
      g.helper false
      g.resource_route false
    end
  end
end

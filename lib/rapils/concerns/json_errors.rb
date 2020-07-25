# require 'active_model'
# require 'active_record/errors'
# require 'active_record/validations'
# require 'active_support/concern'
require 'pundit'

module Rapils
  module Concerns
    module JsonErrors
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordNotFound, with: :render_json_notfound_errors
        rescue_from ActiveRecord::RecordInvalid, with: :render_json_validation_errors
        rescue_from Pundit::NotAuthorizedError, with: :render_json_notfound_errors
      end

      def json_error(title:, details: nil, status: 422)
        {
          status: status,
          details: details,
          title: title,
        }.compact
      end

      def render_json_error(title:, details: nil, status: 422)
        errors = [
          json_error(title: title, details: details, status: status),
        ]

        render json: { errors: errors }, status: status
      end

      def render_json_resource_error(resource, status: 422)
        render_json_error(title: resource.errors.full_messages.join(', '), status: status)
      end

      def render_json_validation_errors(error)
        if @resource
          render_json_error(title: @resource.errors.full_messages.join(', '), status: 422)
        else
          render_json_error(title: error.message, status: 422)
        end
      end

      def render_json_notfound_errors(error)
        render_json_error(title: error.message, status: 404)
      end
    end
  end
end

module Rapils
  module Concerns
    module TokenAuth
      extend ActiveSupport::Concern

      included do
        before_action :authenticate_api_user!
        before_action :update_access_token_used_at!
      end

      def access_token
        @access_token ||= begin
          token = session[:access_token] || request.headers['Authorization']&.gsub(/bearer\s*/i, '')
          return unless token

          access_token ||= ::AccessToken.eager_load(:user).find_by(token: token)
          return if access_token.nil? || access_token.expired? || access_token.invalidated?

          access_token
        end
      end

      def current_user
        return unless access_token

        @current_user ||= access_token.user
      end

      def authenticate_api_user!
        return true if current_user

        errors = [
          {
            'title' => 'Not Authorized',
          },
        ]
        render json: { errors: errors }, status: 401
      end

      def ensure_current_user_is_admin!
        return true if current_user&.admin_roles == ['*']

        errors = [
          {
            'title' => 'Not Authorized',
          },
        ]
        render json: { errors: errors }, status: 401
      end

      def update_access_token_used_at!
        return unless access_token

        access_token.update_columns(last_used_at: DateTime.now)
      end
    end
  end
end

require 'rapils/policies/permission_policy'

# Handles management of permissions via REST interface
module Rapils
  module Controllers
    class PermissionsController < BaseController
      def create
        @resource = Permission.new(
          subject_type: params[:subject_type],
          subject_id: params[:subject_id],
        )

        manual_authorize @resource

        user = User.find_by!(email: params[:email])
        @resource.update!(
          owner: user,
          actions: params[:actions],
        )

        render json: ::PermissionSerializer.new(@resource).serialized_json, status: 201
      end

      def index
        @resources = Permission.where(subject_type: params[:subject_type], subject_id: params[:subject_id])

        render json: ::PermissionSerializer.new(@resources).serialized_json
      end

      def destroy
        @resource = Permission.find(params[:id])
        authorize @resource, policy_class: Rapils::Policies::PermissionPolicy
        @resource.destroy!

        head 204
      end

      protected

      def manual_authorize(resource)
        subject = resource.subject
        permission = current_user.permissions.find_by(subject: subject)

        message = "Not allowed to manage #{subject.class.name.downcase.pluralize}"
        raise(Pundit::NotAuthorizedError, message) unless permission
        raise(Pundit::NotAuthorizedError, message) unless permission.actions.include?('all') || permission.actions.include?('manage')
      end
    end
  end
end

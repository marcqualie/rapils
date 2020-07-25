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

        # Bit annoying to do with pundit, so do this
        subject = @resource.subject
        permission = current_user.permissions.find_by(subject: subject)
        raise(Pundit::NotAuthorizedError, "Not allowed to manage #{subject.class.name.downcase.pluralize}") unless permission
        raise(Pundit::NotAuthorizedError, "Not allowed to manage #{subject.class.name.downcase.pluralize}") unless permission.actions.include?('all') || permission.actions.include?('manage')

        user = User.find_by!(email: params[:email])
        @resource.owner = user
        @resource.actions = params[:actions]
        @resource.save!

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
    end
  end
end

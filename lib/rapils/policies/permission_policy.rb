require_relative './application_policy'

module Rapils
  module Policies
    class PermissionPolicy < ApplicationPolicy
      def create?
        false
      end

      def destroy?
        return true if record.owner == user

        # If user does not own this permission, we need to see if thay
        # can manage permissions on the parent subject
        permission = Permission.find_by(owner: user, subject: record.subject)
        return false unless permission

        permission.actions.include?('all') || permission.actions.include?('manage')
      end
    end
  end
end

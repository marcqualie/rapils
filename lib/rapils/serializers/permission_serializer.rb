module Rapils
  module Serializers
    class PermissionSerializer < BaseSerializer
      attribute :subject_id
      attribute :subject_type
      attribute :owner_id
      attribute :owner_type
      attribute :owner_email
      attribute :owner_avatar_url
      attribute :actions
      attribute :created_at
      attribute :updated_at
    end
  end
end

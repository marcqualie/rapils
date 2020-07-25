module Rapils
  module Models
    class Permission < BaseRecord
      self.abstract_class = true

      ACTIONS = %w[
        all
        manage
        view
        edit
        delete
      ].freeze

      belongs_to :owner, polymorphic: true
      belongs_to :subject, polymorphic: true

      validates :owner_id, uniqueness: { scope: %i[owner_type subject_type subject_id], message: '+ Subject combination already assigned' }

      def owner_email
        owner&.email
      end

      def owner_avatar_url
        owner&.avatar_url
      end
    end
  end
end

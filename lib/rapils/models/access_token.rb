module Rapils
  module Models
    class AccessToken < BaseRecord
      self.abstract_class = true

      belongs_to :user, class_name: '::User'

      before_validation :generate_token

      validates :name, presence: true, length: { minimum: 4, maximum: 100 }

      scope :active, -> { where('(expires_at > ? OR expires_at IS NULL) AND invalidated_at IS NULL', DateTime.now) }

      def invalidate!
        update!(invalidated_at: DateTime.now)
      end

      def expired?
        return false if expires_at.nil?

        expires_at <= DateTime.now
      end

      def invalidated?
        !invalidated_at.nil?
      end

      protected

      def generate_token
        self.token ||= SecureRandom.hex(16)
      end
    end
  end
end

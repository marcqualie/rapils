module Rapils
  module Models
    class User < BaseRecord
      self.abstract_class = true

      has_many :access_tokens, class_name: '::AccessToken'
      has_many :permissions, class_name: '::Permission', as: :owner

      def admin?
        admin_roles == ['*']
      end

      def access_granted?
        access_granted_at && access_granted_at < DateTime.now ? true : false
      end

      def grant_access!
        self.access_granted_at ||= DateTime.now
        save! if changed?
      end

      def avatar_url
        "https://www.gravatar.com/avatar/#{gravatar_hash}?s=160&d=identicon"
      end

      def gravatar_hash
        Digest::MD5.hexdigest email.strip.downcase
      end
    end
  end
end

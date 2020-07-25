module Rapils
  module Models
    class User < BaseRecord
      self.abstract_class = true

      has_many :access_tokens, class_name: '::AccessToken'
    end
  end
end

module Rapils
  module Models
    class User < BaseRecord
      self.table_name = 'users'

      has_many :access_tokens, class_name: '::AccessToken'
    end
  end
end

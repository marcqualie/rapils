module Rapils
  module Models
    class User < BaseRecord
      self.table_name = 'users'

      has_many :access_tokens
    end
  end
end

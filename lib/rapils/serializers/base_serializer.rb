require 'fast_jsonapi'

module Rapils
  module Serializers
    class BaseSerializer
      include FastJsonapi::ObjectSerializer

      set_key_transform :camel_lower

      attribute :id
    end
  end
end

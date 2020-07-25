require 'rapils/concerns/json_errors'
require 'rapils/concerns/token_auth'

module Rapils
  module Controllers
    class BaseController < ActionController::API
      include Concerns::JsonErrors
      include Concerns::TokenAuth
      include Pundit
    end
  end
end

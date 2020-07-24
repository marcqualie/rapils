require 'rapils/concerns/json_errors'
require 'action_controller/api'

module Rapils
  class BaseController < ActionController::API
    include Concerns::JsonErrors
  end
end

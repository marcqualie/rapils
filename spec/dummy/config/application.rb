require_relative 'boot'

require 'rapils/setup'
Rapils.setup

module Dummy
  class Application < Rapils::Application
  end
end


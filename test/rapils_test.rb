require 'test_helper'

class RapilsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rapils::VERSION
  end

  def test_it_defines_root_module
    assert defined?(Rapils)
  end
end

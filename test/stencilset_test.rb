require 'test_helper'

class StencilsetTest < Minitest::Test
  def test_get
    assert org.jrubyactiviti.StencilsetResource.getStencilset()
  end
end
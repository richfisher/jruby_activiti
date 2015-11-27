require 'test_helper'

class StencilsetTest < Minitest::Test
  def test_get
    assert Java::Jrubyactiviti::StencilsetResource.getStencilset()
  end
end
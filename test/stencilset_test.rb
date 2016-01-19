require 'test_helper'

class StencilsetTest < Minitest::Test
  def test_get
    assert Java::OrgJrubyactiviti::StencilsetResource.getStencilset()
  end
end
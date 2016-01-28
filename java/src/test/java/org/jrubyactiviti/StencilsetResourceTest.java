package org.jrubyactiviti;

import static org.junit.Assert.*;
import org.junit.Test;

import org.jrubyactiviti.StencilsetResource;

public class StencilsetResourceTest {
	@Test
	public void test_get_stencilset() {
		assertNotNull(StencilsetResource.getStencilset());
	}
}
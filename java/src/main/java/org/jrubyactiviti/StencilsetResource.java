package org.jrubyactiviti;

import java.io.InputStream;
import org.activiti.engine.ActivitiException;
import org.apache.commons.io.IOUtils;

public class StencilsetResource {
  public static String getStencilset() {
    InputStream stencilsetStream = StencilsetResource.class.getClassLoader().getResourceAsStream("stencilset.json");
    try {
      return IOUtils.toString(stencilsetStream, "utf-8");
    } catch (Exception e) {
      throw new ActivitiException("Error while loading stencil set", e);
    }
  }
}
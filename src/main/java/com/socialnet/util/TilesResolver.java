package com.socialnet.util;

import javax.servlet.ServletContext;

import org.apache.struts2.tiles.StrutsTilesListener;
import org.apache.tiles.TilesContainer;
import org.apache.tiles.TilesException;
import org.springframework.stereotype.Component;

@Component
public class TilesResolver extends StrutsTilesListener{
	
		public TilesContainer createContainer(ServletContext context) throws TilesException{
			return super.createContainer(context);
		}
		
	
}

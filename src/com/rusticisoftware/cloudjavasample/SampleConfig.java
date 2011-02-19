package com.rusticisoftware.cloudjavasample;

import com.rusticisoftware.hostedengine.client.*;
import java.util.*;
import java.io.*;

public class SampleConfig {
	
	public static ScormEngineService GetScormEngineService() throws FileNotFoundException, IOException{
		
		Properties props = new Properties();
		InputStream is = SampleConfig.class.getClassLoader().getResourceAsStream("/CloudJavaSample.properties");
		props.loadFromXML(is);
		
		String appId = props.getProperty("appId");
		String secretKey = props.getProperty("secretKey");
		String serviceUrl = props.getProperty("serviceUrl");
		return new ScormEngineService(serviceUrl,appId,secretKey);
	}
}
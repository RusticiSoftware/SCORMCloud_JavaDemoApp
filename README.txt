SCORM Cloud Service Java Demo App
Rustici Software

About:
The Java demo app is a Java application intended to provide samples of the basic library functions to aid in the development of other java applications that work with the SCORM Cloud Web Service.

Using the Demo App:
In the src/CloudJavaSample.properties file, set your appId and secret key to your account in the SCORM Cloud. These can be found on the Apps page of the SCORM Cloud app site (http://cloud.scorm.com).  
Deploy using "ant clean deploy" from the package folder.  Copy the created .war file from the build/war/ folder to your webapps folder on your tomcat server. 
On your webserver, browse to the JavaDemoApp/. For instance, http://localhost/JavaDemoApp/, depending on your server.




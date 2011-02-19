<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:directive.page import="java.util.*" />
<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%

ScormEngineService cs = SampleConfig.GetScormEngineService();
boolean ping = cs.getDebugService().CloudPing();
boolean authPing = cs.getDebugService().CloudAuthPing();

%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cloud Java Sample</title>
</head>
<body>
Hi There! It's <%= new Date() %>
<br/>
<% if (ping){ %>
	The ping is good.
<% } else {  %>
	The ping is not good.
<% } %>
<br/>
<% if (authPing){ %>
	Your cloud credentials are good.
<% } else {  %>
	Your cloud credentials are not good.
<% } %>
<br/><br/>
<a href="CourseList.jsp">Go to the Course List</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:directive.page import="java.util.*" />
<jsp:directive.page import="org.w3c.dom.*" />

<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%
String courseid = request.getParameter("courseid"); 

ScormEngineService cs = SampleConfig.GetScormEngineService();
CourseService csvc = cs.getCourseService();
RegistrationService rsvc = cs.getRegistrationService();

List<RegistrationData> regList = rsvc.GetRegistrationList(null,courseid);

String redirectUrl = request.getRequestURL().toString() + "?courseid=" + courseid;

ReportingService repsvc = cs.getReportingService();
String repAuth = repsvc.GetReportageAuth(Enums.ReportageNavPermission.FREENAV,true);
String reportageUrl = cs.getScormEngineServiceUrl().replace("EngineWebServices","") + "Reportage/reportage.php?appId=" + cs.getAppId() + "&courseId=" + courseid;
String reportUrl = repsvc.GetReportUrl(repAuth,reportageUrl);


%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Course Registration List</title>
<style>
	td {padding:1px 5px;}

</style>
</head>
<body>
	<a href="CourseList.jsp">Back to course list.</a>
	<h2>Your Course Registrations</h2>

	<table>
		<tr><td>Title</td><td>Completion</td><td>Success</td><td>Score</td><td>Total time(secs)</td></tr>
		
<%		for (RegistrationData rd: regList){ %>
			
			<tr>
			<td><%= rd.getRegistrationId() %></td>
			<% 	String regResult = rsvc.GetRegistrationResult(rd.getRegistrationId()); 
				Element xmlResult = XmlUtils.parseXmlString(regResult).getDocumentElement();
				
				String launchUrl = rsvc.GetLaunchUrl(rd.getRegistrationId(),redirectUrl);
				
			%>
			<td><%= xmlResult.getElementsByTagName("complete").item(0).getTextContent() %></td>
			<td><%= xmlResult.getElementsByTagName("success").item(0).getTextContent() %></td>
			<td><%= xmlResult.getElementsByTagName("score").item(0).getTextContent() %></td>
			<td><%= xmlResult.getElementsByTagName("totaltime").item(0).getTextContent() %></td>
			<td><a href="<%= launchUrl %>">Launch</a></td>
			<td><a href="ResetRegistration.jsp?courseid=<%=courseid %>&regid=<%= rd.getRegistrationId() %>">Reset</a></td>
			</tr>
		
<% } %>
	</table>
	
	
	<h3><a href="<%=reportUrl %>">Go to reportage for this course.</a></h3>
	
	<h3>Add a Registration:</h3>
	<form action="CreateRegistration.jsp" method="GET">
		<input type="hidden" name="courseid" value="<%= courseid %>"/>
		<h3>Create New Registration</h3>
		Email: <input type="text" name="learnerid" /><br/>
		First Name:<input type="text" name="fname" /><br/>
		Last Name:<input type="text" name="lname" /><br/>
		<input type="submit" name="submit" value="Submit" />
	</form>
</body>
</html>
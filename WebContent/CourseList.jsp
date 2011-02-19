<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:directive.page import="java.util.*" />
<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%

ScormEngineService cs = SampleConfig.GetScormEngineService();
CourseService csvc = cs.getCourseService();
UploadService usvc = cs.getUploadService();

List<CourseData> courseList = csvc.GetCourseList();

String redirectUrl = request.getRequestURL().toString().replace("CourseList","FinishUpload");
String uploadUrl = usvc.GetUploadUrl(redirectUrl);


ReportingService repsvc = cs.getReportingService();
String repAuth = repsvc.GetReportageAuth(Enums.ReportageNavPermission.FREENAV,true);
String reportageUrl = cs.getScormEngineServiceUrl().replace("EngineWebServices","") + "Reportage/reportage.php?appId=" + cs.getAppId();
String reportUrl = repsvc.GetReportUrl(repAuth,reportageUrl);

%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cloud Course List</title>
<style>
	td {padding:1px 5px;}

</style>
</head>
<body>
	<h2>Your Cloud Course List</h2>

	<table>
		<tr><td>Title</td><td>Registrations</td><td></td><td></td></tr>
		
<%		for (CourseData cd: courseList){ %>
			
			<tr>
			<td><%= cd.getTitle() %></td>
			<td><a href="CourseRegistrations.jsp?courseid=<%= cd.getCourseId() %>"><%= cd.getNumberOfRegistrations() %></a></td>
			<td><a href="CourseProperties.jsp?courseid=<%= cd.getCourseId() %>">Properties</a></td>
			<td><a href="PreviewCourse.jsp?courseid=<%= cd.getCourseId() %>">Preview</a></td>
			<td><a href="DeleteCourse.jsp?courseid=<%= cd.getCourseId() %>">Delete</a></td>
			</tr>
		
<% } %>
	</table>
	
	<h3>Upload a course:</h3>
	<form action="<%= uploadUrl %>" method="post" enctype="multipart/form-data">
	<h4>Select Your Zip Package</h4>
		<input type="file" name="filedata" size="40" />
		<input type="submit" value="Import This Course"/>
	</form>
	<br/><br/>
	<h3><a href="<%=reportUrl %>">Go to reportage for your App Id.</a></h3>
</body>
</html>
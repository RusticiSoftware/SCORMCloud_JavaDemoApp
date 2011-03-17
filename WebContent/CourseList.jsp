<%--
    Software License Agreement (BSD License)
    
    Copyright (c) 2010-2011, Rustici Software, LLC
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
        * Redistributions of source code must retain the above copyright
          notice, this list of conditions and the following disclaimer.
        * Redistributions in binary form must reproduce the above copyright
          notice, this list of conditions and the following disclaimer in the
          documentation and/or other materials provided with the distribution.
        * Neither the name of the <organization> nor the
          names of its contributors may be used to endorse or promote products
          derived from this software without specific prior written permission.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL Rustici Software, LLC BE LIABLE FOR ANY
    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:directive.page import="java.util.*" />
<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.hostedengine.client.datatypes.CourseData" %>
<%@ page import="com.rusticisoftware.hostedengine.client.datatypes.Enums" %>
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
			<%
			if (csvc.Exists(cd.getCourseId())){
			%><td>EXISTS</td> <%	
			} else {
			%><td>Nope</td> <%
			}%>
			
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
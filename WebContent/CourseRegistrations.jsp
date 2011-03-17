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
<jsp:directive.page import="org.w3c.dom.*" />

<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.hostedengine.client.datatypes.RegistrationData" %>
<%@ page import="com.rusticisoftware.hostedengine.client.datatypes.Enums" %>
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
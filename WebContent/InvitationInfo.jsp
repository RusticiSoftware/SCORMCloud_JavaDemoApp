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
<%@ page import="com.rusticisoftware.hostedengine.client.datatypes.InvitationInfo" %>
<%@ page import="com.rusticisoftware.hostedengine.client.datatypes.UserInvitationStatus" %>
<%@ page import="com.rusticisoftware.hostedengine.client.datatypes.Enums" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%
String invitationid = request.getParameter("invitationid"); 

ScormEngineService cs = SampleConfig.GetScormEngineService();
InvitationService isvc = cs.getInvitationService();

InvitationInfo invInfo = isvc.getInvitationInfo(invitationid,true);




%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Course Invitation List</title>
<style>
	td {padding:1px 5px;}

</style>
</head>
<body>
	<a href="CourseInvitations.jsp?courseid=<%= invInfo.get_courseId() %>">Back to invitation list.</a>
	<h2>Your Invitation Info</h2>

	<div>Invitation Id: <%= invInfo.get_id() %></div>
	<div>Course ID: <%= invInfo.get_courseId() %></div>
	<div>Public: <%= invInfo.is_Public() %></div>
	<div>Allow New Registrations: <%= invInfo.is_allowNewRegistrations() %></div>
	<div>Allow launches: <%= invInfo.is_allowLaunch() %></div>
	<div>Public launch Url: <%= invInfo.get_url() %></div>
	<div>is Created: <%= invInfo.is_created() %></div>
	<div>Create Date: <%= invInfo.get_createDate() %></div>
	<div>Email Subject: <%= invInfo.get_subject() %></div>
	<div>Email Body: <%= invInfo.get_message() %></div>
	
	<br/><br/>
	<h2>Your Invitation Users</h2>
	
		<table>
			<tr><td>ID</td><td>email</td><td>is started</td><td>url</td></tr>

	<%		for (UserInvitationStatus uInv: invInfo.get_userInvitations()){ 
				
		%>

				<tr>
				<td><%= uInv.get_registrationId() %></td>
				<td><%= uInv.get_email() %></td>
				<td><%= uInv.is_isStarted() %></td>
				<td><%= uInv.get_url() %></td>
				</tr>

	<% } %>
		</table>

	
	
	
</body>
</html>
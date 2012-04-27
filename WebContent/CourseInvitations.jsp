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
<%@ page import="com.rusticisoftware.hostedengine.client.datatypes.Enums" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%
String courseid = request.getParameter("courseid"); 

ScormEngineService cs = SampleConfig.GetScormEngineService();
InvitationService isvc = cs.getInvitationService();

List<InvitationInfo> invList = isvc.getInvitationList(null,courseid);




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
	<a href="CourseList.jsp">Back to course list.</a>
	<h2>Your Course Invitations</h2>

	<table>
		<tr><td>ID</td><td>subject</td><td>status</td><td>is public</td><td>allow registrations</td><td>allow launches</td></tr>
		
<%		for (InvitationInfo inv: invList){ 
			String status = isvc.getInvitationStatus(inv.get_id());
	%>
			
			<tr>
			<td><a href="InvitationInfo.jsp?invitationid=<%= inv.get_id() %>"><%= inv.get_id() %></a></td>
			<td><%= inv.get_subject() %></td>
			<td><%= status %></td>
			<td><%= inv.is_Public() %></td>
			<% if (inv.is_Public())  { %>		
				<td><a href="InvitationChangeStatus.jsp?invitationid=<%= inv.get_id() %>&courseid=<%= inv.get_courseId() %>&enable=<%= inv.is_allowLaunch() %>&open=<%= !inv.is_allowNewRegistrations() %>"><%= inv.is_allowNewRegistrations() %></a></td>
			
			<% } else { %>
				<td>(not public)</td>
			<% }  %>
			<td><a href="InvitationChangeStatus.jsp?invitationid=<%= inv.get_id() %>&courseid=<%= inv.get_courseId() %>&enable=<%= !inv.is_allowLaunch() %>&open=<%= inv.is_allowNewRegistrations() %>"><%= inv.is_allowLaunch() %></a></td>
			
			</tr>
		
<% } %>
	</table>
	
	<h3>Add an Invitation:</h3>
	<form action="CreateInvitation.jsp" method="GET">
		<input type="hidden" name="courseid" value="<%= courseid %>"/>
		<h3>Create New Registration</h3>
		Sender's Email: <input type="text" name="creator" /><br/>
		<input type="checkbox" name="public" /> Public Invite<br/>
		<input type="checkbox" name="async" /> Send Async<br/>
		<input type="checkbox" name="send" /> Send Emails<br/>
		&nbsp;&nbsp;&nbsp; Recipients: <input type="text" name="addresses" /><br/>
		<input type="submit" name="submit" value="Submit" />
	</form>
	
	
	
	
</body>
</html>
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
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%

String courseid = request.getParameter("courseid");

ScormEngineService cs = SampleConfig.GetScormEngineService();
CourseService csvc = cs.getCourseService();

String propsUrl = csvc.GetPropertyEditorUrl(courseid);

HashMap<String, String> attributePairs = csvc.GetAttributes(courseid);



%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Course Properties</title>
</head>
<body>
<a href="CourseList.jsp">Back to Course List</a>
<h2>Course Properties</h2>
<iframe width="80%" height="500px" src="<%=propsUrl %>"></iframe>

<br/><br/>

<h2>Direct Attribute Updates:</h2>



<form action="CourseAttributesUpdate.jsp" method="Get">
	
	Attribute:<select name="att">
<%
for (String key : attributePairs.keySet())
{
	String val = attributePairs.get(key);
    if (!Utils.isNullOrEmpty(val) && (val.equalsIgnoreCase("true") || val.equalsIgnoreCase("false")))
    { %>
        <option value='<%= key %>'><%= key %></option>
    <%
    }
}		
%>
		
	</select>
	
	&nbsp;&nbsp;&nbsp;
	<select name="attval">
		<option value=""></option>
		<option value="true">true</option>
		<option value="false">false</option>
	</select>
	<input type="hidden" name="courseid" value="<%= courseid %>"/>
	<input type="submit" value="submit"/>
</form>


</body>
</html>
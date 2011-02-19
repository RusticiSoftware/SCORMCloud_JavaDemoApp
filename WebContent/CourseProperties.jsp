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
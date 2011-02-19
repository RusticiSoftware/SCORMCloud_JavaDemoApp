<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:directive.page import="java.util.*" />
<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%

String courseid = request.getParameter("courseid");
String att = request.getParameter("att");
String attval = request.getParameter("attval");

ScormEngineService cs = SampleConfig.GetScormEngineService();
CourseService csvc = cs.getCourseService();

HashMap<String, String> attributeHashMap = new HashMap<String, String>();
attributeHashMap.put(att, attval);

HashMap<String, String> changedAtts = csvc.UpdateAttributes(courseid,attributeHashMap);


String redirectURL = "CourseProperties.jsp?courseid=" + courseid;
response.sendRedirect(redirectURL);


%>
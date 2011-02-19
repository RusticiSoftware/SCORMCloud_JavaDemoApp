<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:directive.page import="java.util.*" />
<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%

String courseid = request.getParameter("courseid");
String learnerid = request.getParameter("learnerid");
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");

ScormEngineService cs = SampleConfig.GetScormEngineService();
RegistrationService rsvc = cs.getRegistrationService();

rsvc.CreateRegistration(UUID.randomUUID().toString(),courseid,learnerid,fname,lname);


String redirectUrl = request.getRequestURL().toString().replace("CreateRegistration","CourseRegistrations") + "?courseid=" + courseid;
response.sendRedirect(redirectUrl);


%>
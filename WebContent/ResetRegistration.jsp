<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:directive.page import="java.util.*" />
<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%

String courseid = request.getParameter("courseid");
String regid = request.getParameter("regid");

ScormEngineService cs = SampleConfig.GetScormEngineService();
RegistrationService rsvc = cs.getRegistrationService();

rsvc.ResetRegistration(regid);

String redirectUrl = request.getRequestURL().toString().replace("ResetRegistration","CourseRegistrations") + "?courseid=" + courseid;
response.sendRedirect(redirectUrl);


%>
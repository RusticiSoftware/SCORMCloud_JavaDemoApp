<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:directive.page import="java.util.*" />
<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%

String location = request.getParameter("location");

ScormEngineService cs = SampleConfig.GetScormEngineService();
CourseService csvc = cs.getCourseService();

csvc.ImportUploadedCourse(UUID.randomUUID().toString(),location);

UploadService usvc = cs.getUploadService();
usvc.DeleteFile(location);

String redirectURL = "CourseList.jsp";
response.sendRedirect(redirectURL);




%>
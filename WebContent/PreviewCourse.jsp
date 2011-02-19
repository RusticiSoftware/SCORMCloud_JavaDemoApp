<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:directive.page import="java.util.*" />
<%@ page import="com.rusticisoftware.hostedengine.client.*" %>
<%@ page import="com.rusticisoftware.cloudjavasample.*" %>
<%

String courseid = request.getParameter("courseid");

ScormEngineService cs = SampleConfig.GetScormEngineService();
CourseService csvc = cs.getCourseService();

String redirectUrl = request.getRequestURL().toString().replace("PreviewCourse","CourseList");

String previewUrl = csvc.GetPreviewUrl(courseid, redirectUrl);


response.sendRedirect(previewUrl);


%>
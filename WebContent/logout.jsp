<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%
	session.invalidate();
	response.sendRedirect("login.jsp");
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logout</title>
</head>
<body>

</body>
</html>
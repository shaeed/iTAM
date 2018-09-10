<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>iTam - Something went wrong</title>

<s:head/>
</head>
<body>
<center>
<img alt="Something went wrong. Go to Home." src="img/Internal_Server_Error.png">
<form action="getAllTams">
		<input type="submit" value="Home" />
</form>
<hr>
<i><s:property value="message"/></i>
<p>Please contact Shaeed (E863021).</p>
</center>


</body>
</html>
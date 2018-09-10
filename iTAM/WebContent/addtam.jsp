<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New TAM - iTAM</title>

<s:head />
<script src="jquery/jquery-3.2.1.min.js"></script>
<link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="jquery-ui-1.12.1/jquery-ui.js"></script>

<style type="text/css">
form {
	margin: 20px 0;
}

form input, button {
	padding: 5px;
}

table {
	width: 100%;
	margin-bottom: 20px;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid #cdcdcd;
}

table th, table td {
	padding: 10px;
	text-align: left;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>

</head>
<body>
	<h1>New TAM</h1>	
	<div id="add-tam-div">
		<fieldset>
			<legend>TAM Details</legend>
			<form id="add-form" action="addTam" method="post">
				<input type="text" name="tamId" placeholder="An unique ID" autofocus required /> 
				<input type="text" name="team" placeholder="Team" required />
				<input type="text" name="admin" placeholder="Admin eid" required />
				<input type="text" name="responsible" placeholder="Responsible" required />
				<input type="time" name="tamTime" placeholder="Tam Time" title="Enter TAM timing" required />
				<input type="text" name="type" placeholder="Tam Type" required />
				<input type="text" name="theme" placeholder="Theme" required />
				<input type="submit" class="add-row" value="Add TAM" />
			</form>
		</fieldset>
	</div>
</body>
</html>
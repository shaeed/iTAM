<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>iTAM</title>
<script src="jquery/jquery-3.2.1.min.js"></script>
<link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="jquery-ui-1.12.1/jquery-ui.js"></script>

<style>
table {
	border-collapse: collapse;
	text-align: left;
	margin: 20px;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

body {
	font-family: "Trebuchet MS", sans-serif;
	margin: 50px;
}
</style>

<script>
	$(function() {
		$("#add-tam-button").button({
			icon : "ui-icon-plusthick"
		}).on("click", function() {
			window.location = "redirectAddTam";
		});

		$(".tam-button").button();
		$(".tam-button-manage").button({
			icon : "ui-icon-gear"
		});
	});
</script>
</head>
<body>
	<div id="add-tam">
		<button id="add-tam-button">Add TAM</button>
	</div>
	
	<!-- List of tams -->
	<div id='all-tams'>
		<table>
			<s:if test="tams != null">
				<s:iterator value="tams">
					<tr>
						<!-- Create button for every item -->
						<td>
							<form action="openTam" method="post">
								<input type="hidden" name="tamId" value='<s:property value="id" />'>
								<input type="hidden" name="team" value='<s:property value="team" />'>
								<input type="hidden" name="responsible" value='<s:property value="responsible" />'>
								<input type="hidden" name="tamTime" value='<s:property value="tamTime" />'>
								<input type="hidden" name="theme" value='<s:property value="theme" />'>
								<input type="submit" class="tam-button" value='<s:property value="team" />' />
							</form>
						</td>
						<td>
							<form action="manageTam" method="post">
								<input type="hidden" name="tamId" value='<s:property value="id" />'>
								<button type="submit" class="tam-button-manage" >Manage</button>
							</form>

						</td>
					</tr>
				</s:iterator>
			</s:if>
			<s:else>
				<s:property value="message" />
			</s:else>
		</table>
	</div>
</body>
</html>
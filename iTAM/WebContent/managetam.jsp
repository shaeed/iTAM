<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage - iTAM</title>

<s:head />
<script src="jquery/jquery-3.2.1.min.js"></script>
<link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="jquery-ui-1.12.1/jquery-ui.js"></script>

<jsp:include page="snackbar.jsp"></jsp:include>

<style type="text/css">
form {
	margin: 20px 0;
}

form input, button {
	padding: 5px;
}


</style>

<script type="text/javascript">
	$(document).ready(function() {
		$(".inAttendee").blur(function() {
			updateAttendee(this);
		});
		$(".inTam").blur(function() {
			updateTam(this);
		});
	});
	
	function updateAttendee(indata){
		//Task table
			var col = $(indata).attr("col");
			var eid = $(indata).attr("eid");
			var val = $(indata).val();
			//Save data
			$.ajax({
				type : 'POST',
				url : 'updateAttendee',
				//data : 'data=' + val + '&column=' + col + '&eid=' + eid,
				data: {
					'data' : val,
					'column' : col,
					'eid' : eid
				},
				dataType : 'JSON',
				async : true,
				success : function(result) {
					snackMessage(result.message);
				}
			});
	}
	
	function updateTam(indata){
		//Task table
			var col = $(indata).attr("col");
			var tamId = $(indata).attr("tamId");
			var val = $(indata).val();
			//Save data
			$.ajax({
				type : 'POST',
				url : 'updateTam',
				data: {
					'data' : val,
					'column' : col,
					'tamId' : tamId
				},
				dataType : 'JSON',
				async : true,
				success : function(result) {
					snackMessage(result.message);
				}
			});
	}
</script>

</head>
<body>
	<h1>Manage TAM</h1>
	<div id="add-div">
		<fieldset>
			<legend>New Attendee</legend>
			<form id="add-form" action="addAttendee" method="post">
				<input type="text" name="eid" placeholder="Employee ID" autofocus required />
				<input type="text" name="first" placeholder="First Name" required />
				<input type="text" name="last" placeholder="Last Name" required />
				<input type="email" name="email" placeholder="Email" required />
				<input type="hidden" name="tamId" value='<s:property value="tamId"/>' />
				<input type="submit" value="Add Attendee" />
			</form>
		</fieldset>
	</div>
	<p><s:property value="message"/></p>
	<div id="edit-div">
		<fieldset>
			<legend>Manage TAM</legend>
				<s:if test="tam != null">
					<form class="add-form" action="deactivateTam" method="post">
					<input type="text" name="tamId" placeholder="Tam ID" value='<s:property value="tam.id"/>' title="An unique TAM id" readonly />
					<input class="inTam" tamId='<s:property value="tam.id"/>' type="text" col="team" title="Team" value='<s:property value="tam.team"/>' /> 
					<input class="inTam" tamId='<s:property value="tam.id"/>' type="text" col="admin" title="Admin eid" value='<s:property value="tam.admin"/>' /> 
					<input class="inTam" tamId='<s:property value="tam.id"/>' type="text" col="responsible" title="Responsible" value='<s:property value="tam.responsible"/>' /> 
					<input class="inTam" tamId='<s:property value="tam.id"/>' type="time" col="tamtime" title="Tam Time" value='<s:property value="tam.tamTime"/>' /> 
					<input class="inTam" tamId='<s:property value="tam.id"/>' type="text" col="type" title="Tam Type" value='<s:property value="tam.type"/>' /> 
					<input class="inTam" tamId='<s:property value="tam.id"/>' type="text" col="theme" title="Theme" value='<s:property value="tam.theme"/>' /> 
					<input type="submit" value="Deactivate TAM" />
					</form>
				</s:if>
				<s:else>
					<p>Something went wrong.</p>
				</s:else>
		</fieldset>
	
		<fieldset>
			<legend>Manage Attendee</legend>

			<table id="attendee-table">
				<tbody>
					<s:if test="atnds != null">
						<s:iterator value="atnds">
							<!-- Create row for every item -->
							<tr><td>
								<form class="add-form" action="deleteAttendee" method="post">
									<input type="text" name="eid" placeholder="Employee ID" value='<s:property value="eid"/>' readonly />
									<input type="hidden" name="tamId" value='<s:property value="tamId"/>' />
									<input class="inAttendee" eid='<s:property value="eid"/>' type="text" col="first" placeholder="First Name" value='<s:property value="first"/>' /> 
									<input class="inAttendee" eid='<s:property value="eid"/>' type="text" col="last" placeholder="Last Name" value='<s:property value="last"/>' /> 
									<input class="inAttendee" eid='<s:property value="eid"/>' type="email" col="email" placeholder="Email" value='<s:property value="email"/>' /> 
									<input type="submit" value="Delete" />
								</form>
							</td></tr>
						</s:iterator>
					</s:if>
					<s:else>
						<tr><td>Looks line no one is added.</td></tr>
					</s:else>
				</tbody>
			</table>

		</fieldset>
	</div>
</body>
</html>
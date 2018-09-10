<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>iTAM - <s:property value="team" /></title>

<s:head />
<script src="jquery/jquery-3.2.1.min.js"></script>
<link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="jquery-ui-1.12.1/jquery-ui.js"></script>

<jsp:include page="snackbar.jsp"></jsp:include>
<jsp:include page="headerb.jsp"></jsp:include>
<jsp:include page="tam-history.jsp"></jsp:include>

<style>
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 60%;
	font-size: 12px;
	text-align: left;
	margin: 20px;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

input {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	border: none;
}

tr:hover td {
	background-color: light blue;
}

body {
	font-family: "Trebuchet MS", sans-serif;
	margin: 50px;
}

.demoHeaders {
	margin-top: 2em;
}

#dialog-link {
	padding: .4em 1em .4em 20px;
	text-decoration: none;
	position: relative;
}

#dialog-link span.ui-icon {
	margin: 0 5px 0 0;
	position: absolute;
	left: .2em;
	top: 50%;
	margin-top: -8px;
}

#icons {
	margin: 0;
	padding: 0;
}

#icons li {
	margin: 2px;
	position: relative;
	padding: 4px 0;
	cursor: pointer;
	float: left;
	list-style: none;
}

#icons span.ui-icon {
	float: left;
	margin: 0 4px;
}

.fakewindowcontain .ui-widget-overlay {
	position: absolute;
}

select {
	width: 200px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$(".intask").blur(function() {
			saveTask(this);
		});

		//Activity table
		$(".inactivity").blur(function() {
			saveActivity(this);
		});
		$(".inactivity-date").on("change", function() {
			saveActivity(this);
		});

		//Tabs
		$("#tam-tabs").tabs();

		//Date picker
		$(".inactivity-date").datepicker({
			minDate : -10,
			maxDate : "+1M +10D",
			dateFormat : "d M, y"
		});
		$(".inactivity-date-add").datepicker({
			minDate : -10,
			maxDate : "+1M +10D",
			dateFormat : "d M, y"
		});

		//Refresh button
		$(".tam-button").button();

		//Completed button
		$(".inactivity-complete-button").button();
		$(".inactivity-complete-button").click(function() {
			completeActivity(this);
		});

		
	});
	
	function saveActivity(indata) {
		var col = $(indata).attr("col");
		var sn = $(indata).attr("sn");
		var val = $(indata).val();
		//Save data
		$.ajax({
			type : 'POST',
			url : 'saveActivity',
			data : 'data=' + val + '&column=' + col + '&sno=' + sn,
			dataType : 'JSON',
			success : function(result) {
				snackMessage(result.message);
			},
			error : function(result) {
				snackMessage(result.message);
			}
		});
	}

	function completeActivity(indata) {
		//Task table
		var col = $(indata).attr("col");
		var sn = $(indata).attr("sn");
		var val = 1;
		//Save data
		$.ajax({
			type : 'POST',
			url : 'saveActivityComplete',
			data : {
				'data' : 1,
				'column' : col,
				'sno' : sn
			},
			dataType : 'JSON',
			success : function(result) {
				snackMessage(result.message);
				$("input[sn='" + sn + "'][col='endDate']").val(result.data);
				$(indata).hide();
			},
			error : function(result) {
				snackMessage(result.message);
			}
		});
	}
</script>
</head>
<body>

	<!-- Tam header -->
	<fieldset>
		<legend>
			<s:property value="team" />
		</legend>
		<div id="controlgroup">
			<label for="today-date" class="ui-controlgroup-label">Date: </label>
			<label id="today-date"><s:property value="todayDate" /></label>
			<label for="responsible" class="ui-controlgroup-label">Responsible: </label>
			<label id="responsible"><s:property value="responsible" /></label>
			<form action="openTam" method="post">
				<input type="hidden" name="tamId" value='<s:property value="tamId" />'>
				<input type="hidden" name="team" value='<s:property value="team" />'>
				<input type="hidden" name="responsible" value='<s:property value="responsible" />'>
				<input type="submit" class="tam-button" value='Refresh' />
			</form>
		</div>
	</fieldset>
	<br>
	<div id="tam-tabs">
		<ul>
			<li><a href="#agenda">Agenda</a></li>
			<li><a href="#task-tab">Task</a></li>
			<li><a href="#key-act-tab">Key Activities</a></li>
			<li><a href="#info-tab">Information</a></li>
			<li><a href="#imprv-idea-tab">Improvement Ideas</a></li>
			<li><a href="#and-on-tab">AndOn</a></li>
		</ul>
		<!-- Task Tab -->
		<div id="agenda">
			<p>TAM timing: 9:30AM</p>
		</div>
		<!-- Tasks -->
		<div id="task-tab">
			<!-- New Task -->
			<div class="add-task-div">
				<fieldset>
					<legend>New Task</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<s:select list="#session.atndList" listValue="first" listKey="eid" headerValue="Team" headerKey="team" theme="simple" name="responsible"></s:select>
						<input type="text" name="activity" placeholder="Task" required />
						<input type="text" class="inactivity-date-add" name="startDate" placeholder="Target Date" required /> 
						<input type="text" name="type" value="4" hidden />
						<input type="submit" value="Add Task" />
					</form>
				</fieldset>
			</div>
			<!-- End New Task -->
			<!-- List available task -->
			<s:if test="task != null">
				<table id="tasktable">
					<thead>
						<tr>
							<th>Responsible</th>
							<th>Task</th>
							<th>Target Date</th>
							<th>Closure</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="task">
							<!-- Create row for every item -->
							<tr bgcolor='<s:property value="color" />'>
								<td><s:property value="responsible" /></td>
								<td><input class="inactivity" sn='<s:property value="sno" />' col="activity" value='<s:property value="activity" />' /></td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="startDate" value='<s:property value="startDate" />' /></td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="endDate" value='<s:property value="endDate" />' /></td>
								<td>
									<s:if test="completed != 1">
										<button class="inactivity-complete-button" sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if>
			<s:else>
				<p>No Work ... Full Enjoy :D :D</p>
			</s:else>
			<button class="old-act-button" type="4">Task History</button>
		</div>
		<!-- Key Activities -->
		<div id="key-act-tab">
			<!-- New Entry -->
			<div class="add-task-div">
				<fieldset>
					<legend>Add Key Activity</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<input type="text" name="activity" placeholder="Task" required />
						<s:select list="#session.atndList" listValue="first" listKey="eid" headerValue="Team" headerKey="team" theme="simple" name="responsible"></s:select>
						<input type="text" class="inactivity-date-add" name="startDate" placeholder="Target Date" required />
						<input type="text" name="type" value="1" hidden />
						<input type="submit" value="Add Task" />
					</form>
				</fieldset>
			</div>
			<!-- End New Entry -->

			<!-- Display -->
			<s:if test="keyactivity != null">
				<table class="activitytable">
					<thead>
						<tr>
							<th>Key Activities</th>
							<th>Resp</th>
							<th>Target Date</th>
							<th>Actual Closure</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="keyactivity">
							<!-- Create row for every item -->
							<tr bgcolor='<s:property value="color" />'>
								<td><input class="inactivity" sn='<s:property value="sno" />' col="activity" value='<s:property value="activity" />' /></td>
								<td><s:property value="responsible" /></td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="startDate" value='<s:property value="startDate" />' /></td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="endDate" value='<s:property value="endDate" />' /></td>
								<td>
									<s:if test="completed != 1">
										<button class="inactivity-complete-button" sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if>
			<s:else>
				<p>No Work ... Full Enjoy :D :D</p>
			</s:else>
			<button class="old-act-button" type="1">Activities History</button>
		</div>

		<!-- Information sharing -->
		<div id="info-tab">
			<!-- New Entry -->
			<div class="add-task-div">
				<fieldset>
					<legend>New Information</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<input type="text" name="activity" placeholder="Details" required />
						<input type="text" class="inactivity-date-add" name="startDate" placeholder="Expires On" required />
						<input type="text" name="type" value="5" hidden />
						<input type="submit" value="Add" />
					</form>
				</fieldset>
			</div>
			<!-- End New Entry -->

			<!-- Dispaly -->
			<s:if test="info != null">
				<table class="activitytable">
					<thead>
						<tr>
							<th>Details</th>
							<th>Expire On</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="info">
							<!-- Create row for every item -->
							<tr>
								<td> <input class="inactivity" sn='<s:property value="sno" />' col="activity" value='<s:property value="activity" />' /> </td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="startDate" value='<s:property value="startDate" />' /> </td>
								<td>
									<s:if test="completed != 1">
										<button class="inactivity-complete-button" sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if>
			<s:else>
				<p>Nothing here !!</p>
			</s:else>
			<button class="old-act-button" type="5">Information History</button>
		</div>
		<!-- Improvement Ideas -->
		<div id="imprv-idea-tab">
			<!-- New Entry -->
			<div class="add-task-div">
				<fieldset>
					<legend>Improve Something</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<input type="text" name="activity" placeholder="Activity details" required />
						<s:select list="#session.atndList" listValue="first" listKey="eid" headerValue="Team" headerKey="team" theme="simple" name="responsible"></s:select>
						<input type="text" class="inactivity-date-add" name="startDate" placeholder="Target Date" required />
						<input type="text" name="type" value="2" hidden />
						<input type="submit" value="Add" />
					</form>
				</fieldset>
			</div>
			<!-- End New Entry -->

			<!-- Display -->
			<s:if test="impidea != null">
				<table class="activitytable">
					<thead>
						<tr>
							<th>Improvement Ideas</th>
							<th>Resp</th>
							<th>Target Date</th>
							<th>Actual Closure</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="impidea">
							<!-- Create row for every item -->
							<tr bgcolor='<s:property value="color" />'>
								<td><input class="inactivity" sn='<s:property value="sno" />' col="activity" value='<s:property value="activity" />' /></td>
								<td><s:property value="responsible" /></td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="startDate" value='<s:property value="startDate" />' /></td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="endDate" value='<s:property value="endDate" />' /></td>
								<td>
									<s:if test="completed != 1">
										<button class="inactivity-complete-button" sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if>
			<s:else>
				<p>There is a lot to improve .. Go beyond !!</p>
			</s:else>
			<button class="old-act-button" type="2">Improvement Ideas History</button>
		</div>
		<!-- And On -->
		<div id="and-on-tab">
			<!-- New Entry -->
			<div class="add-task-div">
				<fieldset>
					<legend>New AndOn</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<input type="text" name="activity" placeholder="And On details" required />
						<s:select list="#session.atndList" listValue="first" listKey="eid" headerValue="Team" headerKey="team" theme="simple" name="responsible"></s:select>
						<input type="text" class="inactivity-date-add" name="startDate" placeholder="Target Date" required />
						<input type="text" name="type" value="3" hidden />
						<input type="submit" value="Add" />
					</form>
				</fieldset>
			</div>
			<!-- End New Entry -->

			<!-- Display -->
			<s:if test="addon != null">
				<table class="activitytable">
					<thead>
						<tr>
							<th>Add On</th>
							<th>Resp</th>
							<th>Target Date</th>
							<th>Actual Closure</th>
						</tr>
					</thead>
					<tbody>

						<s:iterator value="addon">
							<!-- Create row for every item -->
							<tr bgcolor='<s:property value="color" />'>
								<td><input class="inactivity" sn='<s:property value="sno" />' col="activity" value='<s:property value="activity" />' /></td>
								<td><s:property value="responsible" /></td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="startDate" value='<s:property value="startDate" />' /></td>
								<td><input class="inactivity-date" sn='<s:property value="sno" />' col="endDate" value='<s:property value="endDate" />' /></td>
								<td>
									<s:if test="completed != 1">
										<button class="inactivity-complete-button" sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if>
			<s:else>
				<p>Huhaaa ... Nothing here !!</p>
			</s:else>
			<button class="old-act-button" type="3">AndOn History</button>
		</div>
	</div>
	<!-- End Tam-tabs -->

</body>
</html>
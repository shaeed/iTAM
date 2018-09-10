<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>iTAM - <s:property value="team" /></title>

<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main_stellar.css" />

<s:head />
<script src="jquery/jquery-3.2.1.min.js"></script>
<link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="jquery-ui-1.12.1/jquery-ui.min.js"></script>

<jsp:include page="snackbar.jsp"></jsp:include>

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

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Header -->
		<header id="header">
		<h1>
			<s:property value="team" />
		</h1>
		<p>
			Date:
			<s:property value="todayDate" />
			Responsible:
			<s:property value="responsible" />
		</p>
		</header>

		<!-- Nav -->
		<nav id="nav">
		<ul>
			<li><a href="#agenda">Agenda</a></li>
			<li><a href="#task-tab">Task</a></li>
			<li><a href="#key-act-tab">Key Activities</a></li>
			<li><a href="#info-tab">Information</a></li>
			<li><a href="#imprv-idea-tab">Improvement Ideas</a></li>
			<li><a href="#and-on-tab">And On</a></li>
		</ul>
		</nav>

		<!-- Main -->
		<div id="main">

			<!-- Agenda -->
			<section id="agenda" class="main">
			<div class="spotlight">
				<div class="content">
					<header class="major">
					<h2>TAM Timing: 9:30AM</h2>
					</header>

				</div>

			</div>
			</section>

			<!-- Task Section -->
			<section id="task-tab" class="main special"> <header
				class="major">
			<h2>Tasks</h2>
			</header> <!-- Start --> <!-- New Task -->
			<div class="add-task-div">
				<fieldset>
					<legend>New Task</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<table>
							<tr>
								<td><s:select list="#session.atndList" listValue="first"
										listKey="eid" headerValue="Team" headerKey="team"
										theme="simple" name="responsible"></s:select></td>
								<td><input type="text" name="activity" placeholder="Task"
									required /></td>
								<td><input type="text" class="inactivity-date-add"
									name="startDate" placeholder="Target Date" required /></td>
								<td><input type="hidden" name="type" value="4" /> <input
									type="submit" value="Add Task" /></td>
							</tr>
						</table>
					</form>
				</fieldset>
			</div>
			<!-- End New Task --> <!-- List available task --> <s:if
				test="task != null">
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
								<td><input class="inactivity"
									sn='<s:property value="sno" />' col="activity"
									value='<s:property value="activity" />' /></td>
								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="startDate"
									value='<s:property value="startDate" />' /></td>
								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="endDate"
									value='<s:property value="endDate" />' /></td>
								<td><s:if test="completed != 1">
										<button class="inactivity-complete-button"
											sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if> <s:else>
				<p>No Work ... Full Enjoy :D :D</p>
			</s:else> <!-- End --> <footer class="major">
			<ul class="actions">
				<li>
					<form action="openTam#task-tab" method="post">
						<input type="hidden" name="tamId"
							value='<s:property value="tamId" />'> <input
							type="hidden" name="team" value='<s:property value="team" />'>
						<input type="hidden" name="responsible"
							value='<s:property value="responsible" />'> <input
							type="submit" class="tam-button" value='Refresh' />
					</form>
				</li>
			</ul>
			</footer> </section>

			<!-- Key Activity Section -->
			<section id="key-act-tab" class="main special"> <header
				class="major">
			<h2>Key Activities</h2>
			</header> <!-- Start --> <!-- New Entry -->
			<div class="add-task-div">
				<fieldset>
					<legend>Add Key Activity</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<table>
							<tr>
								<td><input type="text" name="activity" placeholder="Activity details" required /></td>
								<td><s:select list="#session.atndList" listValue="first" listKey="eid"
							headerValue="Team" headerKey="team" theme="simple"
							name="responsible"></s:select></td>
								<td><input type="text" class="inactivity-date-add"
									name="startDate" placeholder="Target Date" required /></td>
								<td><input type="hidden" name="type" value="1" /> <input
									type="submit" value="Add" /></td>
							</tr>
						</table>
					</form>
				</fieldset>
				
			</div>
			<!-- End New Entry --> <!-- Display --> <s:if
				test="keyactivity != null">
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
								<td><input class="inactivity"
									sn='<s:property value="sno" />' col="activity"
									value='<s:property value="activity" />' /></td>
								<td><s:property value="responsible" /></td>
								<!-- td><input class="inactivity"
									sn='<s:property value="sno" />' col="eid"
									value='<s:property value="eid" />' list="attendee-list" /></td> -->
								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="startDate"
									value='<s:property value="startDate" />' /></td>
								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="endDate"
									value='<s:property value="endDate" />' /></td>
								<td><s:if test="completed != 1">
										<button class="inactivity-complete-button"
											sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if> <s:else>
				<p>No Work ... Full Enjoy :D :D</p>
			</s:else> <!-- End --> <footer class="major">
			<ul class="actions">
				<li>
					<form action="openTam#key-act-tab" method="post">
						<input type="hidden" name="tamId"
							value='<s:property value="tamId" />'> <input
							type="hidden" name="team" value='<s:property value="team" />'>
						<input type="hidden" name="responsible"
							value='<s:property value="responsible" />'> <input
							type="submit" class="tam-button" value='Refresh' />
					</form>
				</li>
			</ul>
			</footer> </section>

			<!-- Information Section -->
			<section id="info-tab" class="main special"> <header
				class="major">
			<h2>Information</h2>
			</header> <!-- Start --> <!-- New Entry -->
			<div class="add-task-div">
				<fieldset>
					<legend>New Information</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<table>
							<tr>
								<td><input type="text" name="activity" placeholder="Details" required /></td>
								<td><input type="text" class="inactivity-date-add" name="startDate"
							placeholder="Expires On" required /></td>
								<td><input type="hidden" name="type" value="5" /> <input
									type="submit" value="Add" /></td>
							</tr>
						</table>
					</form>
				</fieldset>
			</div>
			<!-- End New Entry --> <!-- Dispaly --> <s:if test="info != null">
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
								<td><input class="inactivity"
									sn='<s:property value="sno" />' col="activity"
									value='<s:property value="activity" />' /></td>

								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="startDate"
									value='<s:property value="startDate" />' /></td>

								<td><s:if test="completed != 1">
										<button class="inactivity-complete-button"
											sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if> <s:else>
				<p>Nothing here !!</p>
			</s:else> <!-- End --> <footer class="major">
			<ul class="actions">
				<li>
					<form action="openTam#info-tab" method="post">
						<input type="hidden" name="tamId"
							value='<s:property value="tamId" />'> <input
							type="hidden" name="team" value='<s:property value="team" />'>
						<input type="hidden" name="responsible"
							value='<s:property value="responsible" />'> <input
							type="submit" class="tam-button" value='Refresh' />
					</form>
				</li>
			</ul>
			</footer> </section>

			<!-- Improvement ideas Section -->
			<section id="imprv-idea-tab" class="main special"> <header
				class="major">
			<h2>Improvement Ideas</h2>
			</header> <!-- Start --> <!-- New Entry -->
			<div class="add-task-div">
				<fieldset>
					<legend>Improve Something</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<table>
							<tr>
								<td><input type="text" name="activity" placeholder="Improvement Idea" required /></td>
								<td><s:select list="#session.atndList" listValue="first" listKey="eid"
							headerValue="Team" headerKey="team" theme="simple"
							name="responsible"></s:select></td>
								<td><input type="text" class="inactivity-date-add"
									name="startDate" placeholder="Target Date" required /></td>
								<td><input type="hidden" name="type" value="2" /> <input
									type="submit" value="Add" /></td>
							</tr>
						</table>
					</form>
				</fieldset>
			</div>
			<!-- End New Entry --> <!-- Display --> <s:if test="impidea != null">
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
								<td><input class="inactivity"
									sn='<s:property value="sno" />' col="activity"
									value='<s:property value="activity" />' /></td>
								<td><s:property value="responsible" /></td>
								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="startDate"
									value='<s:property value="startDate" />' /></td>
								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="endDate"
									value='<s:property value="endDate" />' /></td>
								<td><s:if test="completed != 1">
										<button class="inactivity-complete-button"
											sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if> <s:else>
				<p>There is a lot to improve .. Go beyond !!</p>
			</s:else> <!-- End --> <footer class="major">
			<ul class="actions">
				<li>
					<form action="openTam#imprv-idea-tab" method="post">
						<input type="hidden" name="tamId"
							value='<s:property value="tamId" />'> <input
							type="hidden" name="team" value='<s:property value="team" />'>
						<input type="hidden" name="responsible"
							value='<s:property value="responsible" />'> <input
							type="submit" class="tam-button" value='Refresh' />
					</form>
				</li>
			</ul>
			</footer> </section>

			<!-- AndOn Section -->
			<section id="and-on-tab" class="main special"> <header
				class="major">
			<h2>And On</h2>
			</header> <!-- Start --> <!-- New Entry -->
			<div class="add-task-div">
				<fieldset>
					<legend>New AndOn</legend>
					<form class="add-task-form" action="addActivity" method="post">
						<table>
							<tr>
								<td><input type="text" name="activity" placeholder="And On details" required /></td>
								<td><s:select list="#session.atndList" listValue="first" listKey="eid"
							headerValue="Team" headerKey="team" theme="simple"
							name="responsible"></s:select></td>
								<td><input type="text" class="inactivity-date-add"
									name="startDate" placeholder="Target Date" required /></td>
								<td><input type="hidden" name="type" value="3" /> <input
									type="submit" value="Add" /></td>
							</tr>
						</table>
					</form>
				</fieldset>
			</div>
			<!-- End New Entry --> <!-- Display --> <s:if test="addon != null">
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
								<td><input class="inactivity"
									sn='<s:property value="sno" />' col="activity"
									value='<s:property value="activity" />' /></td>
								<td><s:property value="responsible" /></td>
								<!-- td><input class="inactivity"
									sn='<s:property value="sno" />' col="eid"
									value='<s:property value="eid" />' list="attendee-list" /></td> -->
								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="startDate"
									value='<s:property value="startDate" />' /></td>
								<td><input class="inactivity-date"
									sn='<s:property value="sno" />' col="endDate"
									value='<s:property value="endDate" />' /></td>
								<td><s:if test="completed != 1">
										<button class="inactivity-complete-button"
											sn='<s:property value="sno" />' col="completed">Completed</button>
									</s:if></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if> <s:else>
				<p>Huhaaa ... Nothing here !!</p>
			</s:else> <!-- End --> <footer class="major">
			<ul class="actions">
				<li>
					<form action="openTam#and-on-tab" method="post">
						<input type="hidden" name="tamId"
							value='<s:property value="tamId" />'> <input
							type="hidden" name="team" value='<s:property value="team" />'>
						<input type="hidden" name="responsible"
							value='<s:property value="responsible" />'> <input
							type="submit" class="tam-button" value='Refresh' />
					</form>
				</li>
			</ul>
			</footer> </section>

		</div>

	</div>

	<!-- Scripts -->
	<!-- script src="assets/js/jquery.min.js"></script -->
	<script src="assets/js/jquery.scrollex.min.js"></script>
	<script src="assets/js/jquery.scrolly.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main_stellar.js"></script>

</body>
</html>
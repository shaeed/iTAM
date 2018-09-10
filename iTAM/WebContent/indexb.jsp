<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script src="jquery/jquery-3.2.1.min.js"></script>
<link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="jquery-ui-1.12.1/jquery-ui.js"></script>

<jsp:include page="snackbar.jsp"></jsp:include>

<style type="text/css">
#rounded-corner {
	font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
	font-size: 12px;
	width: 480px;
	text-align: left;
	border-collapse: collapse;
	margin: 20px;
}

#rounded-corner tr:hover td {
	background-color: green;
}
</style>

<script>
	$(document).ready(function() {
		$("#ajax-test").blur(function(){
			ajaxTest(this);
		});
	});

	function ajaxTest(a) {
		var d = $(a).val();
		$.ajax({
			type: "GET",
			url: "ajaxTest",
			//data: "shaeed=" + d,
			data: {'shaeed' : d},
			dataType: "json",
			success: function(data){
				alert(data.message);
			},
			error: function(data){
				alert(data.message);
			}
		});
	}
</script>

</head>
<body>

	<form action="getAllTams">
		<input type="submit" value="Open iTam" />
	</form>
	<hr>
	<p>Test area ..</p>
	<div>
		<input id="ajax-test" /> shaeed: <input id="ajax-tes2t" /> <select
			class="attendee-dropdown" value="Shaeeddef"></select> <select
			class="attendee-dropdown" value="Shaeeddef2"></select>
			
			<hr>
			<input class="ins" list="attendee-list" value="Khan" />
			<datalist id="attendee-list">
				<option value="Shaeed">
				<option value="Shaeed2">
				<option value="Shaeed3">
			</datalist>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".attendee-dropdown").html(function(){
				addSelect(this);
			})
		});
		
		function addSelect(area){
			ht = $(area);
			ht.find('option').remove();
			$('<option>').val('e863021').text('Shaeed').appendTo(ht);
			$('<option>').val('e863022').text('Shaeed2').appendTo(ht);
			$('<option>').val('e863023').text('Shaeed3').appendTo(ht);
		}
	</script>
</body>
</html>
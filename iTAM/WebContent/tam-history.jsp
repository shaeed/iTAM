<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<s:head />
<script src="jquery/jquery-3.2.1.min.js"></script>
<link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="jquery-ui-1.12.1/jquery-ui.js"></script>

<script>
$(document).ready(function() {
	//Hostory
	var win = $(window);
	$("#old-act-count").hide();
	$("#old-act-more").hide();
	$("#old-act-type").hide();
	$("#dlg-old-act").dialog({
		autoOpen : false,
		height : win.height() * 0.8,
		width : win.width() * 0.9,
		show : {
			effect : "blind",
			duration : 400
		},
		hide : {
			effect : "explode",
			duration : 500
		},
		buttons : {
			Ok : function() {
				$(this).dialog("close");
			}
		}
	});
	
	$(".old-act-button").on("click", function() {
		$("#dlg-old-act").dialog("open");
		$("#old-act-count").text("0");
		$("#old-act-more").text("1");
		var type = $(this).attr("type");
		$("#old-act-type").text(type);
		fillInitialScreen(type);
	});
	
	// Each time the user scrolls
	$("#dlg-old-act").scroll(function() {
		var finished = parseInt($("#old-act-more").text());
		if ((finished == 1) && ($("#old-act").height() - $("#dlg-old-act").height() <= $("#dlg-old-act").scrollTop()+10)) {
			var start = $("#old-act-count").text();
			var end = parseInt(start) + 10;
			var type = $("#old-act-type").text();
			//alert("In while, type=" + type + ", end=" + end);
			fillDataStart(type, start, 10);
			//Save the number of rows fetched
			$("#old-act-count").text(end);
		}
	});
});

//Fill the initial screen
function fillInitialScreen(type) {
	var start = 0;
	//Set table header
	dt = fillRowTitle(type);
	$("#old-act").html(dt);
	do {
		fillDataStart(type, start, 20);
		start = start + 20;
		if (start == 20)
			break;
	} while ($("#old-act").height() < $("#dlg-old-act").height());
	//Save the number of rows fetched
	$("#old-act-count").text(start);
}

// Get History
function fillDataStart(type, start, end) {
	$('#loading').show();
	//Fetch data
	var dt = getOldActivity(type, start, end);
}

function fillDataEnd(dt) {
	pv = $("#old-act").html();
	dt = pv + dt;
	$("#old-act").html(dt);
	$('#loading').hide();
}

function getOldActivity(type, start, end) {
	//Get data
	var rows = "";
	$.ajax({
		type : 'POST',
		url : 'getOldActivityb',
		data : {
			'type' : type,
			'start' : start,
			'end' : end
		},
		dataType : 'JSON',
		success : function(result) {
			rows = fillRowData(type, result.acts);
		},
		error : function(result) {
			snackMessage("Something went wrong.");
		},
		complete : function(data) {
			fillDataEnd(rows);
		}
	});

}//End getOldActivity

function fillRowTitle(type) {
	var header = "<tr>";
	switch (type) {
	case "1":
		//Key Activities
		header = header + "<td>Key Activities</td>";
		header = header + "<td>Resp</td>";
		header = header + "<td>Target Date</td>";
		header = header + "<td>Actual Closure</td>";
		break;

	case "2":
		//Improvement Ideas
		header = header + "<td>Improvement Ideas</td>";
		header = header + "<td>Resp</td>";
		header = header + "<td>Target Date</td>";
		header = header + "<td>Actual Closure</td>";
		break;

	case "3":
		//AndOn
		header = header + "<td>And On</td>";
		header = header + "<td>Resp</td>";
		header = header + "<td>Target Date</td>";
		header = header + "<td>Actual Closure</td>";
		break;

	case "4":
		//Task
		header = header + "<td>Resp</td>";
		header = header + "<td>Task</td>";
		header = header + "<td>Target Date</td>";
		header = header + "<td>Actual Closure</td>";
		break;

	case "5":
		//Information
		header = header + "<td>Details</td>";
		header = header + "<td>Expired On</td>";
		break;

	default:
		break;
	}

	header = header + "</tr>";

	return header;
}//End fillRowTitle

function fillRowData(type, ac) {
	var rows = "";
	var count = 0;
	for ( var i in ac) {
		count++;
		switch (type) {
		case "1":
			//Key Activities
		case "2":
			//Improvement Ideas
		case "3":
			//AndOn
			rows += "<tr>";
			rows = rows + "<td>" + ac[i].activity + "</td>";
			rows = rows + "<td>" + ac[i].responsible + "</td>";
			rows = rows + "<td>" + ac[i].startDate + "</td>";
			rows = rows + "<td>" + ac[i].endDate + "</td>";
			rows += "</tr>";
			break;

		case "4":
			//Task
			rows += "<tr>";
			rows = rows + "<td>" + ac[i].responsible + "</td>";
			rows = rows + "<td>" + ac[i].activity + "</td>";
			rows = rows + "<td>" + ac[i].startDate + "</td>";
			rows = rows + "<td>" + ac[i].endDate + "</td>";
			rows += "</tr>";
			break;

		case "5":
			//Information
			rows += "<tr>";
			rows = rows + "<td>" + ac[i].activity + "</td>";
			rows = rows + "<td>" + ac[i].endDate + "</td>";
			rows += "</tr>";
			break;

		default:
			break;
		}//End switch
	}//End for
	if(count < 10){
		//No further rows in DB
		rows = rows + "<tr><td>Thats All .. </tr></td>";
		$("#old-act-more").text("0");
	}
	return rows;
}//End fillRowData
</script>

</head>
<body>



	<!-- Old activity Start -->
	<div id="old-act-count">0</div>
	<div id="old-act-type">0</div>
	<div id="old-act-more">1</div>
	<div id="dlg-old-act" title="History">
		<div id="old-act"></div>
		<p id="loading">
			<img src="img/3.gif" alt="Loading ..." />
		</p>
	</div>

	<!-- Old Activity End -->

</body>
</html>
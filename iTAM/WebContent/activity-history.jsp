<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Task History</title>
<s:head />

<script src="jquery/jquery-3.2.1.min.js"></script>
<link href="jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet">
<script src="jquery-ui-1.12.1/jquery-ui.js"></script>

<script>
$(document).ready(function() {
	$('#loading').hide();
    var win = $(window);
    
    while($("#hist-act").height() < win.height()){
    	$('#loading').show();
    	//Fetch data
        $('#loading').hide();
    }
	
    // Each time the user scrolls
    win.scroll(function() {
        // End of the document reached?
        if ($(document).height() - win.height() == win.scrollTop()) {
            $('#loading').show();
          //Fetch data
            $('#hist-act').append(randomPost());
            $('#loading').hide();
        }
    });
});

// Generate a random post
function getOldActivity() {
	var number = $("#act-number").text();
	//Save data
	$.ajax({
		type : 'POST',
		url : 'getOldActivity',
		data : {
			'number' : number
		},
		dataType : 'JSON',
		success : function(result) {
			snackMessage(result.message);
		},
		error : function(result) {
			snackMessage(result.message);
		}
	});

    return "<hr>shaeed";
}
	
</script>

</head>
<body>
<button id="check">Click</button>
	<div id="posts">
		This is first line.
	</div>
        
	<p id="loading">
		<img src="img/3.gif" alt="Loading ..." />
	</p>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<title>Start - iTAM</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="assets/css/main.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->



</head>
<body class="homepage">
	<div id="page-wrapper">

		<!-- Header -->
		<div id="header">
			<!-- Inner -->
			<div class="inner">
				<header>
					<p>Available TAMs</p>
					<!-- Start -->
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
												<input type="submit" class="tam-button" value='<s:property value="team" />' />
											</form>
										</td>
										<td>
											<form action="manageTam" method="post">
												<input type="hidden" name="tamId" value='<s:property value="id" />'>
												<button type="submit" class="tam-button-manage">Manage</button>
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
					<!-- End -->
					<hr />
				</header>
				<footer>
					<form action="redirectAddTam">
						<input type="submit" value="Add TAM" />
					</form>
				</footer>
			</div>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li><a href="index.jsp">Home</a></li>
					<li><a href="underwork.jsp">About</a></li>
				</ul>
			</nav>

		</div>

		<!-- Banner -->
		<section id="banner">
			<header>
				<h2>
					Hi. You're looking at <strong>iTAM</strong>.
				</h2>
				<p>TAM in new style ...</p>
			</header>
		</section>

	</div>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.dropotron.min.js"></script>
	<script src="assets/js/jquery.scrolly.min.js"></script>
	<script src="assets/js/jquery.onvisible.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="assets/js/main.js"></script>

</body>
</html>
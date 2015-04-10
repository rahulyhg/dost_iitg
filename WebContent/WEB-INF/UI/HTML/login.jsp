<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
	<head>
		<title>Login Now : Your D.O.S.T - IIT Guwahati</title>
	</head>
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/sha3.js"></script>
	<script>
	$(document).ready( function() {
		
		<% if(request.getParameter("error") != null) 
		{
		%>
		$("#errorAlert").html("<p> Your username or password is incorrect</p>");
		$("#errorAlert").show();
		<%}%>
	$('#forgot').click(function() {
		    var x = document.forms["loginForm"]["username"].value;
		    /* if (x == null || x == "") {
		        $("#errorAlert").show();
		        return false;
		    } */
		    window.location.href = "/dost/forgotPassword?username="+x;
	    //$('form').attr("action", "forgotPassword");  //change the form action
	    //$('form').attr("method", "GET");  //change the form action
	    //$('form').submit();  // submit the form
	});
	});
	function updateEncPass () {
		var pass = $("#viewPassword").val();
		var encPass = CryptoJS.SHA3(pass);
		$("#password").val(encPass);
		return true;
	}
	</script>
	
		
	<body class="container-fluid  theme-default" onload='document.loginForm.username.focus();'>
			<jsp:include page="includes/header.jsp"></jsp:include>
		<div class="container row-fluid welcomePage">
			<div class="col-md-9">
				
			<form name='loginForm' onsubmit="return updateEncPass();" action="<c:url value='/j_spring_security_check' />" method='POST'>
				<h3 class="col-md-offset-4 form-signin-heading">
					<p>Hi,</p>
					<p>Don't worry, whatever it is.. we can fix it together. <em>Get Started!</em></p>
				</h3>
				
				<div class="well well-large row  col-md-offset-4 signinFormOuterContainer">
					<div class="col-md-offset-1">
					<div class="error alert alert-danger" id="errorAlert" role="alert" style="display: none;"><p>Username must be filled out.</p></div>
						<label>Username</label>
						<input type="text" required id="username" name="username" class="input-block-level form-control" placeholder="Username">
						<br/><br/>
						
						<label>Password</label>
						<input type="password" required id="viewPassword" class="input-block-level form-control" placeholder="Password">
						<input type="hidden" id="password" name="password">
						<a id="forgot" class="pull-right forgotPasswordText" alt="Forgot Password" href="#">Forgot Password / Username?</a>
						<label class="checkbox">
							<input type="checkbox" value="remember-me"> Remember me
						</label>
						<br/><br/>
						<button class="pull-right btn btn-large btn-primary" type="submit">Sign in</button>
						<a class="pull-right signupNowText" href="signupNow" alt="Signup for a new account">Don't have an account? SIGNUP NOW</a>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</div>
				</div>
				<div class="clearfix"></div>
			</form>


			</div>
		</div>
		<jsp:include page="includes/commonFooter.jsp"></jsp:include>

</body>
</html>

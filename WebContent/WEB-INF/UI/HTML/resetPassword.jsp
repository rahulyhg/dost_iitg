<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>

	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/sha3.js"></script>
	
	<script>
		var identifier = getUrlParameter("identifier");
		function resetSPassSubmit() {
			var pass = $("#password").val();
			var pass1 = $("#password1").val();
			if(pass !== pass1) {
				alert("Passwords typed do not match, please re-enter your passwords.");
				return false;
			}
			var encPass = CryptoJS.SHA3(pass);
			$.post( "/dost/api/user/resetpassword", {identifier: identifier , password: encPass.toString() })
			  .done(function( data ) {
			    if(data.status == "success") {
			    	$("#resetForm").hide();
			    	$("#succMsg").show().html("You password is changed successfully. You will be redirected to Login page shortly.");
			    	setTimeout(function(){ window.location.href = "/dost/login";}, 3000);
			    }else if(data.status == "failure") {
			    	$("#resetForm").hide();
			    	$("#succMsg").show().html('Error: Unable to change you password. Please try again resetting the password, if you still face issue contact <strong><a title="Contact for enquiries" target="_blank" href="mailto:yourdostiitg@gmail.com">yourdostiitg@gmail.com</a></strong>');	
			    } 
			});
		}
	</script>
	
	<body class="container-fluid  theme-default">
			<jsp:include page="includes/header.jsp"></jsp:include>
			<div class="container row-fluid welcomePage">
						<div class="well well-large row col-md-7 col-md-offset-2 forgotPasswordContainer">
							<div id="resetForm" class="col-md-offset-1">
								<label>Enter new password</label>
								<input type="password" required id="password" name="password" class="input-block-level form-control" placeholder="password">
								<br/><br/>
								<label>Confirm password</label>
								<input type="password" required id="password1" name="password1" class="input-block-level form-control" placeholder="password">
								<br/><br/>
								<input type="hidden" id="identifier" name="identifier" value="">
								<br/><br/>
								<button onclick="resetSPassSubmit();" class="pull-right btn btn-large btn-primary" type="button">Submit ></button>
							</div>
							<div id="succMsg" style="display:none;" class="col-md-offset-1">You password is changed successfully. You will be redirected to login page shortly.</div>
						</div>
						<div class="clearfix"></div>
			</div>
		<jsp:include page="includes/commonFooter.jsp"></jsp:include>

</body>
</html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>

<!DOCTYPE html>
<html lang="en">

	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<script>
	var avatar = null;
	$(function() {
		/* Adding question*/
		$("#signup").click(function(event) {
			var datatosend = 'username='+$("#username").val()+'&password=' + $("#password").val()+'&avatarId=' + avatar;
			$.post('http://localhost:8800/dost/api/signup', datatosend, function(data,status) {
				alert("Data: " + data + "\nStatus: " + status);
				//$('#visitFormResponse').text(response);
			});
		});
		
		 $('#avatarId').on("click", "img", function () {
			 avatar = this.id;
		 });
		
		
	});
	
	</script>
	
	<body class="container-fluid theme-default">
		<jsp:include page="includes/header.jsp"></jsp:include>
				
		<div class="container">
			<a class="pull-right loginText" href="login" alt="Login to an existing account">Have an account? LOGIN NOW</a>
			<div class="clearfix"></div>
			<form id="signin" class="form-signin" action="">
				<h3 class="col-md-7 col-md-offset-2 form-signin-heading">
					<p>Hi,</p>
					<p>Don't worry, whatever it is.. we can fix it together. <em>Get Started!</em></p>
				</h3>
				<div class="well well-large row col-md-7 col-md-offset-2 signinFormOuterContainer">
					<div id="signindiv" class="span5 offset1">
						<label class="chooseAvatar">Choose your avatar <span>(This is how I will know you)</span></label>
						<div id="avatarId" class="avatarHolder">
							<img class="avatar" id="avatar1" src="avatar/avatar1.jpg" name="avatar1" />
							<img class="avatar" id="avatar2" src="avatar/avatar2.jpg"/>
							<img class="avatar" id="avatar3" src="avatar/avatar3.jpg"/>
							<img class="avatar" id="avatar4" src="avatar/avatar4.jpg"/>
							<img class="avatar" id="avatar5" src="avatar/avatar5.jpg"/>
						</div>
						<div class="avatarHolder">
							<img class="avatar" id="avatar6" src="avatar/avatar6.jpg"/>
							<img class="avatar" id="avatar7" src="avatar/avatar7.jpg"/>
							<img class="avatar" id="avatar8" src="avatar/avatar8.jpg"/>
							<img class="avatar" id="avatar9" src="avatar/avatar9.jpg"/>
							<img class="avatar" id="avatar10" src="avatar/avatar10.jpg"/>
						</div>
						<br/><br/>
						<label>Username</label>
						<input id ="username" type="text" class="input-block-level" placeholder="Username">
						<br/><br/>
						
						<label>Password</label>
						<input id="password" type="password" class="input-block-level" placeholder="Password">
						<br/><br/>
						<button id="signup" class="pull-right btn btn-large btn-primary" type="submit">Proceed ></button>
						<a class="pull-left loginText" href="login" alt="Login to an existing account">Have an account? Login Now</a>
					</div>
				</div>
				<div class="clearfix"></div>
			</form>
    </div> <!-- /container -->

	<footer></footer>
	</body>
</html>
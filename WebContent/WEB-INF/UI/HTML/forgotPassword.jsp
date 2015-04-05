<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>

<jsp:include page="includes/commonHeader.jsp"></jsp:include>
<style>
.forgot_password_message{
padding: 50px ;
margin-top: 50px;
}
</style>
<body class="container-fluid  theme-default">
<jsp:include page="includes/header.jsp"></jsp:include>
<div class="container row-fluid welcomePage">
<div class="col-md-7">
				<h3 class="col-md-offset-2 form-signin-heading">
				<div class="well well-large row  col-md-offset-2 signinFormOuterContainer">
				<div id="forgotBlock">
				<div class="error alert alert-danger" id="errorAlert" role="alert" style="display: none;"><p>Please enter valid email.</p></div>
					<p>Having trouble signing in?</p>
					<div>
						<input onchange="showForgotEmailText('inputEmail','inputUsername');" type="radio" name="forgot" value="email">&nbsp;I am registered with Email<br>
						<div style="display:none;padding:10px 2px 0px 2px;" id="inputEmail">
						<p style="font-size:10px;font-weight:normal;">To reset your password, enter the email address and Submit. We will send you email with details about your username and link to update password.</p>
							<input type="email" required="" id="email" name="email" class="input-block-level form-control" placeholder="Email">
							<button onclick="submitForgotEmail();" class="pull-right btn btn-large btn-primary" type="button">Submit</button>
							<div class="clearfix"></div>
						</div>	
					</div>
					<div>
						<input type="radio" onchange="showForgotEmailText('inputUsername','inputEmail');" name="forgot" value="email">&nbsp;I am registered with User name
						<div style="display:none;"  class="col-md-10 well" id="inputUsername">
							Please send us a mail at <a href="mailto:yourdostiitg@gmail.com">yourdostiitg@gmail.com</a> and we will quickly send across the password.
							<br/>We are troubling you because we want to be sure, no-one is misusing your account.
						</div>
					</div>
					
				</div>
				<div style="display:none;" id="emailSentMsg">
					We have sent an email to you at 'EMAIL ID' with details about your username and link to update password.
				</div>
					
				</div>
				
				<div class="clearfix"></div>



			</div>
</div>
<jsp:include page="includes/commonFooter.jsp"></jsp:include>

</body>
</html>
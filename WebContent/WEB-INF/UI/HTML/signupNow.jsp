<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>

<!DOCTYPE html>
<html lang="en">

	<head>
		<title>Sign Up Now : Your D.O.S.T - IIT Guwahati</title>
	</head>
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/sha3.js"></script>
	<script>
	$( document ).ready(function() {
		var pageUrl=window.location.href;
		var txt="=";
		if(pageUrl.indexOf(txt) > -1) {
			var username = window.location.href.split("=");
			$("#username").val(username[username.length-1]);
		}
		
		
		$.get('/dost/api/securityquestions/all', function(response) {
			$("#question1").append('<option value="blank">Select your first secret question</option>');
			$.each(JSON.parse(JSON.stringify(response)), function(index, value){
				$("#question1").append($('<option></option>').val(value.questionId).html(value.question));
			});
		});
		
		$.get('/dost/api/securityquestions/all', function(response) {
			$("#question2").append('<option value="blank">Select your second secret question</option>');
			$.each(JSON.parse(JSON.stringify(response)), function(index, value){
				$("#question2").append($('<option></option>').val(value.questionId).html(value.question));
			});
		});
		
		$('#username').blur( function(){
			
			var valid_user = validate_username();
		});
		
		function validate_username(){
			var text=$(" #username").val();
			
			var hostname=$(location).attr('host');   
			if( !text.match(/^([a-zA-Z0-9]+)$/)){
				//alert("1");
				$(" #username").css("border-color","red")
				$(".error").show();
				$(".error").html("only alphabets and numbers accepted").css("color","#666")
				//$("#viewPassword").attr("disabled","true") 
				//$("#signin").attr("disabled","true") ;
			                      
			}
			else  if(text.length >= 4 && isNaN(text.substring(0,1)) === true)
			{ 
				$.ajax("http://"+hostname+"/dost/api/user/"+text+"/exists").done(function(response){
					if(response.status){
						
						
						$("#username").css("border-color","red")
						//$(".exists").removeClass("hidden")
						//$(".exists").css("color","red")
						$(".error").show();
						$(".error").html("username exists");
						$("#signin").attr("disabled","true") 
						//$("#viewPassword").attr("disabled","true") 
	                      				
					}
					else{
						$("#viewPassword").removeAttr("disabled")
						$(" #username").css("border-color","green")
						//$(".exists").addClass("hidden")
						$(".error").hide();
						
						
						//$("#signin").removeAttr("disabled") ;
					}
				});
			
			}
			else{
				$(" #username").css("border-color","red")
				//$("#viewPassword").attr("disabled","true") 
				$(".exists").html("uername length should be atleast 4 and start with  a letter").css("color","red")
				//$("#signin").attr("disabled","true") ;
			}
		}; 
$('#email').blur( function(){
        	$(" #email").removeClass("has-error");			
			var valid_email = validate_email();
		});
function validate_email(){
	var text_email=$(" #email").val();
	
	var hostname=$(location).attr('host'); 
	if($(" #email").val().length === 0){
		$("#viewPassword").removeAttr("disabled")
		$(" #email").css("border-color","green");
		$(".error").hide();
		$("#signin").removeAttr("disabled")
	}
	else if( !text_email.match(/^\S+@\S+\.\S+$/)){
		//alert("1");
		$(" #email").css("border-color","red").addClass("has-error");
		$(".error").show();
		$(".error").html("<p>email format will be example@xyz.com</p>");
		$("#signin").attr("disabled","true") 
	                      
	}

	else {
		$.ajax("http://"+hostname+"/dost/api/email/"+text_email+"/exists").done(function(response){
		if(response.status){
			
			
			$("#email").css("border-color","red").addClass("has-error");
			$(".error").show();
			$(".error").html("<p>email already taken</p>");
			$("#signin").attr("disabled","true") 
			//$("#viewPassword").attr("disabled","true") 
              				
		}
		else{
			$("#viewPassword").removeAttr("disabled")
			$(" #email").css("border-color","green")
			$(".error").hide();
			$("#signin").removeAttr("disabled")
			
			//$("#signin").removeAttr("disabled") ;
		}
	});
	}
};
		
		$('input[name="viewPassword"]').keyup( function(){
			var valid_password = validate_password() ;		
			var valid_user = validate_username();
		});
		
		//$('input[name="username"]').keyup( function(){
			//var valid_user = validate_username();
	//	});
		
		$('input[name="viewPassword"]').keyup( function(){
			var valid_password = validate_password() ;			
		});
	
	});
	
	/*function validate_username(){
		var username = $('input[name="username"]').val() ;
		if( !username.match( /[a-zA-Z]/ ) ){
			$("#usernameError").show()           ;
			$("#signin").attr("disabled","true") ;
			return  0                            ;	
		}else{
			$("#usernameError").hide()          ;
			$("#signin").removeAttr("disabled") ;
			return 1                            ;
		}
		
		
	}*/
	
	function validate_password(){
		var password       = $('input[name="viewPassword"]').val()   ;
		var contains_space = check_if_contains_space( password ) ;
		if( contains_space || !password ){
			$("#passwordError").show()           ;
			$("#signin").attr("disabled","true") ;
			return  0                            ;	
		}else{
			$("#passwordError").hide()          ;
			$("#signin").removeAttr("disabled") ;
			return 1                            ;
		}
	}
	
	function validateForm() {
		$(".error").html("");
		$(".error").hide();
		var usernameRegex = /^[a-zA-Z0-9]+$/;
		$(".alert-success").html("");
		$(".alert-success").hide();
		var userName = $("#username").val();
		var checkAvatar = $(".avatar").hasClass("selectedImage");		
		if(checkAvatar==false){
			$(".error").show();
			$("<p>Please select an avatar</p>").appendTo(".error");
			$('[id$=signin]').removeAttr("disabled");
			event.preventDefault();
		}
		else if(userName == false){
			$(".error").show();
			$("<p>Please enter username</p>").appendTo(".error");
			$('[id$=signin]').removeAttr("disabled");
			event.preventDefault();
		}
		else if(userName.length < 4){
			$(".error").show();
			$("<p>Your username must be at least 4 characters long.</p>").appendTo(".error");
			$('[id$=signin]').removeAttr("disabled");
			event.preventDefault();
		}
		else if(isNaN(userName.substring(0,1)) === false){
			$(".error").show();
			$("<p>Your username must begin with a letter.</p>").appendTo(".error");
			$('[id$=signin]').removeAttr("disabled");
			event.preventDefault();
		}
		else if(userName.match(usernameRegex) === null){
			$(".error").show();
			$("<p>Please enter valid username. Only letters and numbers are allowed</p>").appendTo(".error");
			$('[id$=signin]').removeAttr("disabled");
			event.preventDefault();
		}
		else if($("#viewPassword").val()==false){
			$(".error").show();
			$("<p>Please enter password</p>").appendTo(".error");
			$('[id$=signin]').removeAttr("disabled");
			event.preventDefault();
		}				
		else if($(".has-error").length>0){
			$(".error").show();
			$("<p>Please enter right details in the field marked in red</p>").appendTo(".error");
			event.preventDefault();
		}
		else{			
		}
	}
	
	var avatar = null;
	$(function() { 
		$('#avatarId').on("click", "img", function () {
			 $(".avatar").removeClass("selectedImage");
			 $(this).addClass("selectedImage");
			 avatar = this.id;
			 $("input[id=avatarinput]").val(avatar);
		 });
	});
	
	function updateEncPass () {
		var pass = $("#viewPassword").val();
		var encPass = CryptoJS.SHA3(pass);
		$("#password").val(encPass);
		var newPass = "";
		for (var i=0;i<pass.length;i++) {
			newPass += "*";
		}
		$("#viewPassword").val(newPass)
		return true;
	}
	</script>
	
	<body class="container-fluid theme-default">
		<jsp:include page="includes/header.jsp"></jsp:include>
				
		<div class="container">
			
			<form  onsubmit="return updateEncPass();"  method='POST' class="form-signin" action="http://localhost:8800/dost/api/signup" >
				<div class="col-md-6 col-md-offset-3 form-signin-heading">
					<p>Hi,</p>
					<p>Don't worry, whatever it is.. we can fix it together. <em>Get Started!</em></p>
				</div>
				<div class="well well-large row col-md-6 col-md-offset-3 signinFormOuterContainer">
					<div class="error alert alert-danger" role="alert"></div>
					<div class="alert alert-success" role="alert"></div>
					<div id="signindiv" class="col-md-offset-2">
						
						</div><label class="chooseAvatar">Choose your avatar* <span>(This is how I will know you)</span></label>

						<div id="avatarId" class="avatarHolder">
							<img class="avatar" src="${pageContext.request.contextPath}/avatar/avatar1.png" id="avatar1"/>
							<img class="avatar" src="${pageContext.request.contextPath}/avatar/avatar2.png" id="avatar2"/>
							<img class="avatar" src="${pageContext.request.contextPath}/avatar/avatar3.png" id="avatar3"/>
							<img class="avatar" src="${pageContext.request.contextPath}/avatar/avatar4.png" id="avatar4"/>
							<img class="avatar" src="${pageContext.request.contextPath}/avatar/avatar5.png" id="avatar5"/>
							<img class="avatar" src="${pageContext.request.contextPath}/avatar/avatar6.png" id="avatar6"/>
							<img class="avatar" src="${pageContext.request.contextPath}/avatar/avatar7.png" id="avatar7"/>
							
						</div>
						<br/>
						<input id="avatarinput" type="hidden" name="avatarinput">
						<label>Username*</label>
						<input id="username"  name="username" autocomplete="off" required pattern="[a-zA-Z0-9]+" type="text" class="form-control input-block-level" placeholder="Create a username">
                        <label class="exists hidden">Username already exists</label>
                        <!-- <div id="usernameError" class="errorMsg">Username should contain atleast one alphabet</div> -->
						<br/>
						
						<label>Password*</label>

						<input id="viewPassword" name="viewPassword" autocomplete="off" required type="password" class="form-control input-block-level" placeholder="Set a password">
						<input id="password" name="password" type="hidden">
						
						
						<br/>
						<label>Email</label>
						<input id="email" name="email" type="text" class="form-control input-block-level" placeholder="Set an Email (It will never be shared with anyone)">
					
					   <!-- <div id="passwordError" class="errorMsg">Invalid Password</div> -->
						<br>
<!-- Commenting for now, we think we are asking too much information to users						
						<label>Secret Question <span>(It will help you generate your password, even if you forget)</span></label>
						<br>
						<select required class="form-control" id="question1" name="question1"></select>
						<br/>
						<input required id="answer1" name="answer1" required type="text" class="form-control input-block-level" placeholder="Please provide the answer">
						
						<br/><br/><br/>
						
						<select required class="form-control" id="question2" name="question2"></select>
						<br/>
						<input id="answer2" required  name="answer2" required type="text" class="form-control input-block-level" placeholder="Please provide the answer">
 -->
 <br/>
						<div class="medical_warning">
						By signing up you are agreeing to <a target="_blank" href="termsOfService">Terms and Services</a> of Your D.O.S.T - IIT Guwahati</div>					
						<br/><br/>
						<button id="signin" class="pull-right btn btn-large btn-primary" type="submit" onclick="validateForm();">Proceed &gt;</button>
						<a class="pull-right loginText" href="login" alt="Login to an existing account">Have an account? Login Now</a>
					</div>
				</div>
				<div class="clearfix"></div>
			</form>
    </div> <!-- /container -->
	<jsp:include page="includes/commonFooter.jsp"></jsp:include>
	</body>
</html>

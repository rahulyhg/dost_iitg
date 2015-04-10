<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Talk To Your Friend, Your D.O.S.T - IIT Guwahati</title>
	</head>
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<body class="theme-default" >
		<jsp:include page="includes/header.jsp"></jsp:include>
		<script>
			$(document).ready(function(){
				
			});
		</script>
		<style>
			textarea.box{
				font-size: 15px;
			}
		</style>
		<!-- 
		<div class="container row-fluid">
			<div class="col-md-7 message quotesBg">
				<div class="pageTop messageForQuotes">
					<h2 class="subHeading ">Hey, we are working to get this page up and running. </h2>
					<p class="subHeading">In the mean-time, why don't you check out <a href="${pageContext.request.contextPath}/faqs">Frequently Asked Questions</a>. It is a comprehensive list put together by experts.</p>
    			</div>
    			<ul class="stickyNote">
				    <li>
				      <a href="#">
				        <h2>Work in Progress</h2>
				      </a>
				    </li>
				  </ul>
    			
			</div>
		</div>
		-->
		
		 <div class="container  row-fluid ">
				<div class="col-md-12">
					<div class="pageTop">
						<h2 class="pageHeading pull-left">Talk To A Friend</h2>
					</div>	
					<div class="clearfix"></div>
					<div class="">
							<div class="col-md-6 message_counselor">
								<p>Hi <strong>${pageContext.request.userPrincipal.name}</strong>,</p>
								<br/>
								<p>I am here for you. <br/>
								   Just tell me what&rsquo;s on your mind and I will help you.
								   Believe me, even I have been in some situations myself and I know how hard it can get at times.
								   I can assure you, I am your friend - not a computer program and I am here to help you in any way I can.
								</p>
							</div>
							<div class="col-md-6 worried_person"></div>
							<div class="clearfix"></div>
							
							<script language="JavaScript" type="text/javascript" src="http://localhost:8800/webchat/jivelive.jsp"></script>
							<script>showButtonWithoutUI('demo@workgroup.richasingh-pc', 'username=${pageContext.request.userPrincipal.name}');</script>
							<div class="clearfix"></div>
					</div>
				</div>
				
				<div>
					<!-- <nav class="chat_nav navbar navbar-default col-md-6" role="navigation"" role="navigation">
					<div class="chat_container ">
						<ul class="nav navbar-nav chat_options">
						  <li class="active text_chat"><a href="#">Chat</a></li>
						  <li><a href="#">Virtual Room</a></li>
						  <li><a href="#">Call</a></li>
						  <li><a class="leaveMessage">Send Email</a></li>
						</ul>
						<div class="clearfix"></div>
						<div class="chat_display_area">
							<p>Can I really share with you?</p>
							
						</div>
						<div class="clearfix"></div>
						 <div class="">
							<div class="input-group">
							  <input type="text" class="form-control" placeholder="Tell me what are you thinking">
							  <span class="input-group-btn">
								<button class="btn btn-default" type="button">SEND</button>
							  </span>
							</div>
						 </div>
						 <div class="clearfix"></div>
					</div>
					</nav>
					-->
					
				</div>

				
			</div>
		<div class="clearfix"></div>	 
		<jsp:include page="includes/commonFooter.jsp"></jsp:include>
	</body>
</html>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Client History, Your D.O.S.T - IIT Guwahati</title>
	</head>
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	
	<script>
	$( document ).ready(function() {
		var selectedUser;
		var loggedinUser;
		$.getJSON("/dost/api/user/${pageContext.request.userPrincipal.name}", function(user) {
			loggedinUser=user;
			userid = user.userId;
			userRole = user.dbUserRole.role;
			var threadId = window.location.href.split("=");
			
			
			// Setting message as read
			//message/{messageId}/user/{userId}/markasread"
			$.getJSON("/dost/api/message/"+threadId[1]+"/user/" + userid +"/markasread", function(messages) {
			});
			
			/*Manipulating json for conversation thread*/
			$.getJSON("/dost/api/message/"+threadId[1]+"/", function(messages) {
				
				$(".loading").hide();	
				
				$("#subjectHeading").text(messages[0].subject);
				for (var i = 0 ; i < messages.length ; i++) {
//						$(".conversation_history").append('<li>'+
//														'<h4 class="media-heading">'+ messages[i].sender.username+ '<span> &nbsp' +messages[i].sentDate +'</span></h4>'+
//														messages[i].content+
//													'</li>');
						// From Druveen
						$(".conversation_history").append('<li style="white-space: pre-wrap;">'+'<h4 class="media-heading">'+ messages[i].sender.username+ '<span> &nbsp' +
							formatDate(messages[i].sentDate) +'</span></h4>'+Linkify(messages[i].content)+'</li>');						
			
						// Richa?? I am not sure if this is the correct way of getting Sohil
						if(messages[i].sender.dbUserRole.role=="ROLE_USER"){
							selectedUser = messages[i].sender;
						}
				}
				
				$(".sendReply").click(function(){
					if(userRole == "ROLE_USER"){
						var receipient = "all";
					}
					else{
						for (var i = 0 ; i < messages.length ; i++){
							if(messages[i].sender.dbUserRole.role=="ROLE_USER"){
								var receipient = messages[i].sender.userId;
								break;
							}

						}
						
					}
					$(".error").html("");
					$(".error").hide();
					
					
					//var datatosend = 'subject='+messages[0].subject+'&content=' + $("#messageContent").val()+ '&recipients='+receipient+'&senderId=' + userid+'&msgId='+threadId[1];
					// Added to handle special characters
					var encodedSubject = encodeURIComponent(messages[0].subject);
                    var encodedContent = encodeURIComponent($("#messageContent").val());
                    var datatosend = 'subject='+ encodedSubject +'&content=' + encodedContent + '&recipients='+receipient+'&senderId=' + userid+'&msgId='+threadId[1]+'&counselorTag='+messages[0].categoryId;
					
					if($("#messageContent").val() =='') {
						$(".error").show().text("Please type out the reply");
					}
					else{
						$.post('http://localhost:8800/dost/api/user/message', datatosend, function(response) {							
						//$('#visitFormResponse').text(response);
						});
						
						window.setTimeout('location.reload()', 1000);
						receipient = 'all';
					}
				});	
				
			} );
			/*End of Manipulating json for conversation thread*/
		});	
		
		$(".addNote").click(function(){
			$(".notePopup").show();		
		});
		$(document).on("click",".addNoteButton",function(){
		 if ($("textarea[name='messageContent']").val()==""){
			 $(".error").removeClass("hidden").show().css("color","red");
			
		 }
		 else{
			var hostname=$(location).attr('host');   
			$.getJSON("http://"+hostname+"/dost/api/message/"+ window.location.href.split("=")[1]+"/", function(messages){
				
				  var formData = {};
			      
			      formData["msgId"]=  window.location.href.split("=")[1];
			      formData["messageId"]= messages[0].messageId;
			      formData["note"]= $("textarea[name='messageContent']").val();
			      formData["userId"]= messages[0].sender.userId;
			      console.log(formData);
			      $.ajax({
			           type: "POST",
			           url: "http:\/\/"+hostname+"/dost/api/notes/add",
			           contentType: "application/json",
			           data:JSON.stringify(formData),
			                 dataType: "jsonP",
			                 success: function(response){
			                  $("textarea[name='messageContent']").val("");
			                 },                 
			             error: function(){
			                   $("textarea[name='messageContent']").val("");
			             }
			     });
			});
			
			// $(".error").addClass("hidden");
			$(this).closest(".notePopup").hide();
		
		 }
		
			});
		
		$(".cancelButton").click(function(){
			$(this).closest(".notePopup").hide();
		});
		
		$(".addDetail").click(function(){
			//$(".detailPopup").show();	
			$("#dialogMessage").dialog("open");
			$('.ui-widget-overlay').css('background', 'white');
		});
		
		$("#dialogMessage").dialog({
			modal: true,
			autoOpen : false,
			width : 600,
			buttons : [ {
				text : "CANCEL",
				click : function() {
					$(this).dialog("close");
				}
			}, 
			{
				text : "SEND",
				click : function() {
						$(".error").html("");
						$(".error").hide();
						
						var datatosend = 'fname='+$("#fname").val()+'&lname=' + $("#lname").val()+'&hostel=' + $("#hostel").val()+
											'&year=' + $("#year").val()+'&branch=' + $("#branch").val()+'&userId=' + selectedUser.userId;
						 
						if($("#fname").val()== '' || $("#lname").val()== '') {
							$(".error").show().text("Please fill in details");
						}
						else{
							
							$.post('http://localhost:8800/dost/api/userdetail/add', datatosend, function(response) {							
								if(response = ""){
										$(".status").show().html("sending..");
								}
							});
							
							setTimeout(function(){
								location.reload(function(){
									
									
									
								});
								$(".status").show().html("sent");
							}, 1000);
							
							
							//$debugger;
							//receipient = 'all';
						}
				}
			}]	
	});
		
		$(".cancelButton").click(function(){
			$(this).closest(".detailPopup").hide();
		});
		
		$(".replyBtn").click(function(){
			$('html, body').animate({
			    scrollTop: $("#replyArea").offset().top
			}, 1000);
		});
		
		// Code from Druveen to handle space and link url
		function Linkify(inputText) {
			//debugger;
			if (inputText && inputText.indexOf("href=") != -1) {
			  return inputText;
			} 
			    //URLs starting with http://, https://, or ftp://
			    var replacePattern1 = /(\b(https?|ftp):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gim;
			    var replacedText = inputText.replace(replacePattern1, '<a href="$1" target="_blank">$1</a>');

			    //URLs starting with www. (without // before it, or it'd re-link the ones done above)
			    var replacePattern2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim;
			    var replacedText = replacedText.replace(replacePattern2, '$1<a href="http://$2" target="_blank">$2</a>');

			    //Change email addresses to mailto:: links
			    var replacePattern3 = /(\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6})/gim;
			    var replacedText = replacedText.replace(replacePattern3, '<a href="mailto:$1">$1</a>');

			    return replacedText
			}
		
		
	});
	
	</script>
	
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	
	<body class="theme-default theme-default-counselor" >
	</sec:authorize>
	<sec:authorize access="!hasRole('ROLE_ADMIN')">
	<body class="theme-default">
	</sec:authorize>
		<jsp:include page="includes/header.jsp"></jsp:include>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<div class="container">
				<div class="col-md-11">
					<div class="pageTop">
						<h2 class="pull-left pageHeading col-md-offset-2">
								<a  href="conversations">&larr; Back to all Conversations</a>
						</h2>
						<div class="clearfix"></div>
					</div>
					
					<!-- <ul class="pull-left col-md-2 left_nav">
						<li><a href="#">Compose</a><br/><br/></li>
						<li class="active"><a href="#">Inbox</a></li>
						<li><a href="#">Sent Items</a></li>
						<li><a href="#">Drafts</a><br/><br/></li>
						<li><a href="#">Label 1</a></li>
						<li><a href="#">Label 2</a></li> 
					</ul>-->
					<div class="pull-right col-md-10">
						<div class="pull-left col-md-9">
							<h4 id="subjectHeading" class="pull-left"></h4>
							<div class="pull-right">
								<div class="btn-group">
								  <button type="button" class="replyBtn btn btn-default">Reply</button>
								  <button type="button" class="btn btn-default addNote">Add Note</button> 
								<!--    <button type="button" class="btn btn-default addDetail">Add Detail</button> -->
	
								  <!-- <div class="btn-group">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
									  Label
									  <span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
									  <li><a href="#">career</a></li>
									  <li><a href="#">love relationship</a></li>
									  <li><a href="#">office stress</a></li>
									</ul>
								  </div> -->
								</div>
							</div>
							<div class="clearfix"></div>
							<ul class="conversation_history well">
								<li class="loading" id="loading">
									<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
								</li>
							</ul>
							<!--<a href="#" class="pull-right conversationDetails"> View more conversations
								<span class="glyphicon glyphicon-chevron-right"></span>
							</a> -->
							<div class="clearfix"></div>
							<div id="replyArea" class="reply_to_conversation">
								<textarea class="form-control"   id="messageContent" rows="3"></textarea>
								<button type="button" class="sendReply pull-right btn btn-primary">Submit</button>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="clearfix"></div>
						
					</div>
				</div>
						
			</div>
		</sec:authorize>
		<sec:authorize access="!hasRole('ROLE_ADMIN')">
			<div class="container">
				<div class="col-md-11">
					<div class="pageTop">
						<h2 class="pull-left pageHeading col-md-offset-2">
								<a  href="conversations">&larr; Back to all Conversations</a>
						</h2>
						<div class="clearfix"></div>
					</div>
					
					<div class="pull-right col-md-10">
						<div class="">
							<h4 id="subjectHeading" class="pull-left"></h4>
							<div class="pull-right">
								<div class="btn-group">
								  
								  <button type="button" class="replyBtn btn btn-default">Reply</button>
								 <!--   <button type="button" class="btn btn-default addNote">Add Note</button> -->
								  
								  <!--  <div class="btn-group">
									<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
									  Label
									  <span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
									  <li><a href="#">career</a></li>
									  <li><a href="#">love relationship</a></li>
									  <li><a href="#">office stress</a></li>
									</ul>
								  -->
								  </div>
								</div>
							</div>
							<div class="clearfix"></div>
							<ul class="conversation_history well">
								<li class="loading" id="loading">
									<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
								</li>
								
							</ul>
							<!-- <a href="#" class="pull-right conversationDetails"> View more conversations
								<span class="glyphicon glyphicon-chevron-right"></span>
							</a>					 
							-->
							<div class="clearfix"></div>
							<div id="replyArea" class="reply_to_conversation">
								<div class="error alert alert-danger" role="alert"></div>
								<textarea placeholder="Write your reply"class="form-control" id="messageContent" rows="3"></textarea>
								<button type="button"  class="sendReply pull-right btn btn-primary">Submit</button>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="clearfix"></div>
						
					</div>
				</div>
						
			</div>
				
		</sec:authorize>
	 <jsp:include page="includes/notesPopup.jsp"></jsp:include>
		

		<jsp:include page="includes/popupUserDetails.jsp"></jsp:include>
		<jsp:include page="includes/commonFooter.jsp"></jsp:include>
	</body>
</html>

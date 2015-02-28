<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	
	<script>
	$( document ).ready(function() {
		var selectedUser;
		$.getJSON("/dost/api/user/${pageContext.request.userPrincipal.name}", function(user) {
			userid = user.userId;
			userRole = user.dbUserRole.role;
			var threadId = window.location.href.split("=");
		
			/*Manipulating json for conversation thread*/
			$.getJSON("/dost/api/chathistory/"+threadId[1]+"/", function(chats) {
				
				for(i=0; i<chats.length; i++){
					$(".conversations").append(
							'<li class=" media each_conversation">'+
									'<div class="pull-left col-md-2">'+
										'<div class="patient_name"><strong>'+ chats[i].toJIDResource +'</strong></div>'+
										'<div class="post_details">'+timeConverter(chats[i].sentDate) +'</div>'+
									'</div>' +
									'<div class="media-body col-md-8">'+
											'<span>'+chats[i].body+'</span>'+
									'</div>'+
								'</li>');
				}

				$(".loading").hide();	
				/**
				$(".conversations").append('<div class="categoryList"><h3 class="subject secondary_heading" id='+i+'_subject>'+'Chat on ' + timeConverter(inner.userChats[0].sentDate) +'</h3>');
				$("#"+ i+"_subject").after("<ul></ul></div>");						
				for(var k in inner.userChats) {
					//debugger;
					$("#"+ i+"_subject").siblings("ul").append('<li class=" media each_conversation">'+
							'<div class="pull-left col-md-2">'+
								'<div class="patient_name"><strong>'+ inner.userChats[k].toJIDResource +'</strong></div>'+
								'<div class="post_details">'+timeConverter(inner.userChats[k].sentDate) +'</div>'+
							'</div>' +
							'<div class="media-body col-md-8">'+
									'<span>'+inner.userChats[k].body+'</span>'+
							'</div>'+
						'</li>');							
				}
				*/
			} );
			/*End of Manipulating json for conversation thread*/
		});	
		
		// Code from Druveen to handle space and link url
		function Linkify(inputText) {
			debugger;
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
		
		function timeConverter(UNIX_timestamp){
			  var a = new Date(UNIX_timestamp * 1);
			  var months = ['1','2','3','4','5','6','7','8','9','10','11','12'];
			  var year = a.getFullYear();
			  var month = months[a.getMonth()];
			  var date = a.getDate();
			  var hour = a.getHours();
			  var min = a.getMinutes();
			  var sec = a.getSeconds();
			  var time = year + '-' + month + '-' + date + ' ' + hour + ':' + min + ':' + sec ;
			  return time;
		}
		
	});
	
	</script>
	
	<body class="theme-default">
		<jsp:include page="includes/header.jsp"></jsp:include>
		<div class="col-md-8 well">
			<ul class="conversations conversation_History_details">
				<li class="loading" id="loading">
						<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
				</li>
			</ul>
		</div>
		<jsp:include page="includes/commonFooter.jsp"></jsp:include>
	</body>
</html>
$( document ).ready(function() {
		
		/*applying properties based on url*/
		var url = $(location).attr("pathname").split("/");
		$('#main-navbar .menuItems a[href="'+url[url.length-1]+'"]').parent("li").addClass("active");
		
		if(url[url.length-3] ==('posts' || 'forums')){
			$('li#discussions').addClass("active");			
		}
		
		
		if(window.location.href.indexOf("counselor") > -1){
			$("body").addClass("theme-default-counselor");
		}
		
		if(window.location.href.indexOf("login") > -1){
			$(".login_now").hide();
		}
		
		if(window.location.href.indexOf("signupNow") > -1){
			$(".signup_now").hide();
		}
		/*end of applying properties based on url*/	
		
		/*open send message from email*/
		$(".mail").click(function(){
			$( ".leaveMessage" ).trigger( "click" );	
		});
		/*end */
		
				
		/*end of highlighting the new mail*/
		
		/*styling the favorite discussion iframe*/
		setTimeout(function(){
			$("iframe.popularDiscussions").contents().find("li").css({
					'list-style':'none',
					'margin-bottom':'10px',
					
			});
			
			$("iframe.talkToFriendChatBox ").find(".box").css({
				'font-family': '"Open Sans", Arial,sans-serif',
				'font-size': '12px',
			});
			
			
			$("iframe.popularDiscussions").contents().find("a").css({
				'color':'#333333',
				'font-family': 'Arial,Helvetica,sans-serif',
				'font-size':'12px',
				'text-decoration': 'none',
			});
			
			$("iframe.popularDiscussions").contents().find("a").attr('target','_blank');
			
			$("iframe.popularDiscussions").contents().find("a:hover").css({
				'text-decoration': 'underline',
			});
			
			$("iframe.popularDiscussions").contents().find("ul").css({
				'padding-left': '0',
			});
			$("iframe.popularDiscussions").contents().find("li").css({
				'list-style': 'none',
				'margin-left': '0px'
			});
			$("iframe.quotes").contents().find(".status-msg-wrap").css({
				'display': 'none'
				
			});
		},1000);
		/*end of styling the favorite discussion iframe*/
});


function check_if_contains_space( value ){
	
	if( value.match( /\s/ ) ){
		return 1 ;	
	}else{
		return 0 ;
	}
	
}
function blockUser(name,ele) {
	$.getJSON("/dost/api/user/"+name+"/block", function(data) {
		if(data.status == "true") {
			$(ele).parent().parent().css({"background-color":"#E2E2E2"});
			$(ele).parent().html('<p class="pull-right">BLOCKED</p>');
		}
		
	});
}
function showButton(ele) {
	$(ele).find("button").show();
}
function hideButton(ele) {
	$(ele).find("button").hide();
}

function showForgotEmailText(show,hide) {
	$("#"+show).show();
	$("#"+hide).hide();
}

function validateEmail(email) {
    var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    return re.test(email);
}

function submitForgotEmail() {
	
	var email = $("#email").val();
	var userName = $("#username").val();
	
	if (email === "" && userName === "") {
		$("#errorAlert").show().html("Please enter Username or Email");
		return;
	}
	
	if(email !== "" &&!validateEmail(email)) {
		$("#errorAlert").show();
		return;
	}
	
	/*$("#emailSentMsg").show().html("We have sent an email to you at "+email+" with details about your username and link to update password.");
	$("#forgotBlock").hide();
	*/
	$.ajax({
		  method: "POST",
		  url: '/dost/api/user/emailpassword',
		  data: { username :userName, email: email }
		}).done(function( msg ) {
			if(msg.status == "success") {
				$("#emailSentMsg").show().html("We have sent an email with details about your username and link to update password.");
				$("#forgotBlock").hide();
			}else if(msg.status == "usernotpresent") {
				$("#errorAlert").show().html("Username '"+userName+"' not registered with us. Don't worry, we are here for you. Please <a href='/dost/signupNow'>SIGNUP</a>  and get started.");
			}else if(msg.status == "emailnotpresent") {
				$("#errorAlert").show().html("Email '"+email+"' not registered with us. Don't worry, we are here for you. Please <a href='/dost/signupNow'>SIGNUP</a>  and get started.");
			}else if(msg.status == "emailnotpresentcontactcustomecare") {
				$("#errorAlert").hide()
				$("#emailNotPresent").show();
				$("#forgotUserPassBlock").hide();
			} 
		});
}

function getUrlParameter(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) 
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) 
        {
            return sParameterName[1];
        }
    }
}

function loadingImage(className) {
	$("."+className).append('<li class="secondloading"><img src="/dost/resources/img/ajax-loader.gif" alt="Loader" /></li>');
}


// Code from Druveen to handle space and link url
function Linkify(inputText) {
//		debugger;
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

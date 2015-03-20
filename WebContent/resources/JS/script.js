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

function submitForgotEmail() {
	var email = $("email").val();
	$("#emailSentMsg").show();
	$("#forgotBlock").hide();
	
	/*$.ajax({
		  method: "POST",
		  url: "",
		  data: { email: email }
		}).done(function( msg ) {
		    $("#emailSentMsg").show();
		    
		});*/
}
<!DOCTYPE html>

<%@taglib prefix="sec"
uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html lang="en">
<head>
	<meta name="description" content="Is something bothering you - career, relationships, family, work, education, parents? Your D.O.S.T is a your emotional support system where you can be complete anonymous and vent out your feelings to special friends consiting of compassionate psychologists and others. You can privately discuss all your problems with special friends through one to one chat, explore self help and engage with others going through tough times on discussion forums"/>
	<meta name="keywords" content="virtual counseling system, emotional support system, share your feelings, online counseling, share your problems, speak to counselor for free, free therapy, shre emotions, speak to a therapist, find a listener, your trusted friend, your supportive friend"/>
	<meta name="author" content="Your D.O.S.T.">
	<title>Your D.O.S.T - IIT Guwahati : An Emotional Support System</title>
	<link rel="shortcut icon" href="http://iitg.yourdost.com/favicon.ico" />
	<!-- <link rel="image_src" href="http://iitg.yourdost.com/resources/img/dostLogo.jpg" />
	<meta property="og:image" content="http://yourdost.com/resources/img/dostLogo.jpg"/>
	<meta property="og:title" content="Your D.O.S.T - An Emotional Support System"/>
	<meta property="og:image" content="Is something bothering you - career, relationships, family, work, education, parents? Your D.O.S.T is a your emotional support system where you can be complete anonymous and vent out your feelings to special friends consiting of compassionate psychologists and others. You can privately discuss all your problems with special friends through one to one chat, explore self help and engage with others going through tough times on discussion forums"/>
	 -->
</head>

<jsp:include page="includes/commonHeader.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/jquery.more.css"> 
<script src="${pageContext.request.contextPath}/resources/JS/jquery.plugin.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/JS/jquery.more.js" type="text/javascript"></script>




<script>
$( document ).ready(function() {
	
	/*FAQ listing on index page*/
	$.getJSON("/dost/api/faqcategory/all", function(FAQ) {	
	$("#faqs .loadingIndex").hide();
	var numberOfCategories = FAQ.length;
	for (var i = 0 ; i < numberOfCategories; i++) {
		var numberOfQuestions = FAQ[i].faqs.length;
		$("#faqs ul").append('<li class="questionIndex"><a href="faqs?='+FAQ[i].faqs[numberOfQuestions-1].faqId+'"+>'+ FAQ[i].faqs[numberOfQuestions-1].question +'</a></li>');
	}
 
	});
	/*end of FAQ listing on index page*/
	/*Discussion listing on index page*/

	$.ajax({
	 url : "/dost/api/forums/checkForAccess",
	 success : function(data){ 
		 if( !data ){
	 		$("#discussions .loadingIndex").hide();
			var hostname = $(location).attr('host');
			var loginLink = hostname.match("localhost") ? "/dost/login" : "/login" ;
	
			$("#discussions .card_heading").attr("href", "#" ) ;		
			$("#discussions ul").append('<li class="eachDiscussion">Looks like you are outside IIT Guwahati campus ' + 
					                      ' <br/><a href="'+ loginLink +'" >Login to view discussion</li>' );
	 	}else{
	 		$.getJSON("/dost/api/topics/count/4", function(discussionTopic) {	
	 			$("#discussions .loadingIndex").hide();

	 			for (var i = 0 ; i < discussionTopic.length; i++) {
	 				$("#discussions ul").append('<li class="eachDiscussion">'+
	 				'<a style="display:block" href="posts/list/' + discussionTopic[i].topicId + '.page">'+
	 				'<div class="wrapper" >'+ discussionTopic[i].topicTitle +
	 				'</div>'+
	 				'</a>'+
	 				'<span class="secondary_information">Last updated: '+discussionTopic[i].forumPosts[0].postTime+'</span>'+	
	 				'</li>');	
	 			}
	 		});
	 		
	 		/*end of discussion listing on index page*/
	 		/*Showing Ellipsis - dotdotdot plugin*/
	 		setTimeout(function(){
	 			$('.wrapper').more({length: 120});
	 		},10000);
	 		/*End of showing ellipsis*/
	 		/*for showing counter*/ 		
	 	}
	 }
});
	
	
	$.getJSON('/dost/api/users/count', function(count) {
		$("#counter").append(count.count + ' people already seeking help from special friends!');;
	});
	/*end of showing counter*/
	/*moving the username to next page*/
	$(".bannerLargeform .banner-signup").click(function(){
		var usernameFilled=$(this).siblings("input").val();
		var hrefToNavigate="${pageContext.request.contextPath}/signupNow/?="+usernameFilled;
		$(this).parent("a").attr("href", hrefToNavigate);
	});
	/*moving the username to next page*/

	/*testimonial slideshow*/
	$("#slideshow > div:gt(0)").hide();

	setInterval(function() { 
		  $('#slideshow > div:first')
		    .fadeOut(2000)
			    .next()
			    .fadeIn(2000)
			    .end()
			    .appendTo('#slideshow');
	},  3000);
			/*end of testimonial slideshow*/
});
</script>

<body class="container-fluid   theme-default welcome">
	<jsp:include page="includes/header.jsp"></jsp:include>

	<div class=" row-fluid welcomePage">
		<sec:authorize access="!hasRole('ROLE_ADMIN')">
			<div class="bannerSignup bannerLarge">
			<!-- Alert message start-->
			<!-- Commenting this during Richa's IITG visit 
				<div style="position:absolute;left:35%;padding: 0px 25px 0px 25px;top:50px;background-color:#FFE390;"> 
						<p  class="message_for_suicideprevention">It is not a suicide prevention support portal. If you are feeling suicidal,<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;please call suicide prevention helpline at <strong>+91 80110 89898</strong></p>
				</div>
			 -->
			 <!-- Alert message end-->
				<img class="hand bannerLargehand" src="${pageContext.request.contextPath}/resources/img/hand.png">
				<img class="sadPerson bannerLargesadPerson" src="${pageContext.request.contextPath}/resources/img/sad_person.png">
				<p class="col-md-7 bannerLargep">IS SOMETHING BOTHERING YOU? ARE YOU FEELING LONELY?<br/>
					<span><strong>Anonymously</strong> discuss your worries by<strong> chatting online</strong> with counselors and experienced individuals<br/>
				</p>
				<sec:authorize ifNotGranted="ROLE_USER">
					<a class="bannerLargeform">
						<input class="bannerLargeinput" type="text" placeholder="Choose a virtual name">
						<button class="banner-signup bannerLargebutton signup_now" type="button">SIGNUP NOW</button>
					</a>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_USER')">
					<a class="loggedInbannerLargeform" href="${pageContext.request.contextPath}/talkToFriend" >
					<button class="banner-signup bannerLargebutton" type="button" data-toggle="" data-target=".signupForm">START TALKING TO YOUR FRIEND</button>
						<p class="counter" id="counter"></p> 
					</a> 
				</sec:authorize>	
			</div>
		</sec:authorize>
		<div class="hrdivider">
			<div class="col-md-12">
				<hr class="col-md-5">
				<div class="col-md-1">Explore</div>
				<hr class="col-md-5">
			</div>
		</div>
		<div class="container">
		<ul>
			<li class="exploration_option well col-md-4" id="discussions">
				<a class="card_heading" href="${pageContext.request.contextPath}/forums/show/6.page">
					<h3 class="categoryName">DISCUSSIONS</h3>
					<img height="42px " src="${pageContext.request.contextPath}/resources/img/support-discussion.png">
				</a>
				<ul class="discussions_list details_box">
					<li class="loadingIndex" id="loading">
						<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
					</li>	
				</ul>
				<div class="disclaimer_discussion">The discussion is opinion of individual users of the portal. IIT Guwahati does not endorse or takes any responsibility about discussions on the portal in any form</div>
				
			</li>
			<li class="exploration_option well col-md-4" id="faqs">
				<a class="card_heading" href="${pageContext.request.contextPath}/faqs">
				<h3 class="categoryName">Frequently Asked Questions</h3>
					<img src="${pageContext.request.contextPath}/resources/img/small-faq.png">
				</a>
				<ul class="details_box">
					<li class="loadingIndex" id="loading">
						<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
					</li>
				</ul>
			</li>
			<li class="exploration_option well col-md-4" id="quotes" >
				<a class="card_heading" href="${pageContext.request.contextPath}/quotes">
					<h3 class="categoryName">Motivational Quotes</h3>
					<img src="${pageContext.request.contextPath}/resources/img/small-motivation.png">
				</a>
				<a class="quotes_list" href="${pageContext.request.contextPath}/quotes">
				<ul class="details_box">
					<li>
						It always seems impossible, until it is done.
					</li>
					<li>
						The Only Person You Should Try To Be Better Than Is The Person You Were Yesterday.
					</li>
					<li>Not to Have Tried Is The True Failure</li>
					<li>
						The Only Person You Should Try To Be Better Than Is The Person You Were Yesterday.
					</li>
					<li>
						A bird sitting on a tree is never afraid of the branch breaking because her trust is not on the branch but on it's own wings					
					</li>
					<li>
						You have to fight to reach your dream, you have to sacrifice and work hard for it
					</li>
					
					<li>
						If God gives you a dream, he gives you an ability to achieve it.
					</li>
					<li>
						Our greatest weekness lies in giving up. The more certain way to succeed is always to try just one more time  <span class="secondary_information">~Thomas A Edison</span>
					</li>
				</ul>
				</a>
			</li>
			<li class="exploration_option well col-md-4" id="destressing">
				<a class="card_heading" href="http://quotesdost.blogspot.in/search/label/de-stressing%20technique">
				<h3 class="categoryName">Destressing Techniques</h3>
					<img src="${pageContext.request.contextPath}/resources/img/small-stress.png">
				</a>
				<ul class="details_box">
					<li>
						<a href="http://quotesdost.blogspot.in/2015/02/journey-within-guided-meditation-by-sri.html">
							<h4>Journey Within - Guided meditationn</h4>
							<span class="secondary_information">Experience timelessness and come out fresh to continue your work.</span>
							<div class="clearfix"></div>
						</a>
					</li>
					<li>
						<a href="http://quotesdost.blogspot.in/2015/01/squeeze-away-tension-progressive-muscle.html">
							<h4>Squeeze Away Tension</h4>
							<span class="secondary_information">A progressive muscle relaxation exercise that will help you squeeze away muscle tension and feel peaceful and calm</span>
							<div class="clearfix"></div>
						</a>
					</li>
					<li>
						<a href="http://quotesdost.blogspot.in/2015/01/sleep-relaxation.html">
							<h4>Sleep Relaxation</h4>
							<span class="secondary_information">Relax your body and mind so that you are able to drift off into a peaceful sleep</span>
							<div class="clearfix"></div>
						</a>
					</li>
					<li>
						<a href="http://quotesdost.blogspot.in/2015/01/body-scan-relaxation.html">
							<h4>Body Scan Relaxation</h4>
							<span class="secondary_information"> Learn to recognize the sensations of tension and stress that can arise within our body before it actually does</span>
							<div class="clearfix"></div>
						</a>
					</li>
					<li>
						<a href="http://quotesdost.blogspot.in/2015/01/mindfulness-exercise.html">
							<h4>Mindfulness Exercise</h4>
							<span class="secondary_information">Cope with difficult and painful thoughts, feelings & sensations</span>
							<div class="clearfix"></div>
						</a>
					</li>
				</ul>
			</li>
			<li class="exploration_option well col-md-4" id="personalityTest">
				<a class="card_heading">
					<h3 class="categoryName ">Know your Personality</h3>
					<img src="${pageContext.request.contextPath}/resources/img/small-personality.png">
				</a>
				<ul class="details_box">
					<li>
						<h4 class="topic_categoryName coming_soon">Find out about your personality!<br/> COMING SOON</h4>
					</li>
				</ul>
			</li>
			<li class="exploration_option well col-md-4" id="articles">
				<a class="card_heading" href="${pageContext.request.contextPath}/blog">
					<h3 class="categoryName ">Blogs</h3>
					<img src="${pageContext.request.contextPath}/resources/img/small-articles.png">
				</a>
				<ul class="details_box">
				<li>
				<li>
					<a href="http://yourdostiitg.blogspot.in/2015/04/it-is-never-too-late-to-make-it-happen.html">
						<h4>It is never too late to make it happen! </h4>
					</a>
				</li>
				<li>
					<a href="http://yourdostiitg.blogspot.in/2015/03/your-first-job-not-end-to-all.html">
						<h4>Your first Job- Not an end to all</h4>
					</a>
				</li>
				<li>
					<a href="http://yourdostiitg.blogspot.in/2015/03/this-is-my-second-blog-with-your-d.html">
						<h4>Dream is something which doesn’t let you sleep! </h4>
					</a>
				</li>
				<li>
					<a href="http://yourdostiitg.blogspot.in/2015/03/no-guy-cares-for-me.html">
						<h4>No guy cares for me!</h4>
					</a>
				</li>
				<li>
					<a href="http://yourdostiitg.blogspot.in/2015/03/depression-lets-get-over-it-why-sit-on.html">
						<h4>DEPRESSION!!!! Let's get over it, why sit on an electric chair..</h4>
					</a>
				</li>
			</li>
		</ul>
	</li>
	<li class="clearfix"></li>
</ul>
</div>
</div>
<jsp:include page="includes/commonFooter.jsp"></jsp:include>
</body>
</html>
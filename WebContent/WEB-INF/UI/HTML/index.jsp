<!DOCTYPE html>

<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html lang="en">
<head>
	<meta name="description" content="Is something bothering you - career, relationships, family, work, education, parents? D.O.S.T is a your virtual emotional support system where you can be complete anonymous and vent out your feelings to special friends consiting of compassionate psychologists and others. You can privately discuss all your problems with special friends through one to one chat, explore self help and engage with others going through tough times on discussion forums"/>
	<meta name="keywords" content="virtual counseling system, emotional support system, share your feelings, online counseling, share your problems, speak to counselor for free, free therapy, shre emotions, speak to a therapist, find a listener, your trusted friend, your supportive friend"/>
	<meta name="author" content="D.O.S.T.">
	<title>D.O.S.T - A Virtual Emotional Support System</title>
	<link rel="shortcut icon" href="http://54.209.217.90:80/dost/favicon.ico" />
	<link rel="image_src" href="http://yourdost.com/resources/img/logoSmall.jpg" />
	<meta property="og:image" content="http://yourdost.com/resources/img/logoSmall.jpg"/>
	<meta property="og:title" content="D.O.S.T - A Virtual Emotional Support System"/>
	<meta property="og:image" content="Is something bothering you - career, relationships, family, work, education, parents? D.O.S.T is a your virtual emotional support system where you can be complete anonymous and vent out your feelings to special friends consiting of compassionate psychologists and others. You can privately discuss all your problems with special friends through one to one chat, explore self help and engage with others going through tough times on discussion forums
"/>

</head>
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/jquery.more.css"> 
	<script src="${pageContext.request.contextPath}/resources/JS/jquery.plugin.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/resources/JS/jquery.more.js" type="text/javascript"></script>

	
	<script>
		$( document ).ready(function() {
			$(".horoscopes a").click(function(){
				var clickedZodiac =$(this).text();
				$(this).attr("href","horoscope?="+clickedZodiac);
			});
			
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
					/*$(".wrapper").dotdotdot({
							
					});*/
					$('.wrapper').more({length: 120});
			},10000);
			
			/*End of showing ellipsis*/
			 
			
		});
	</script>
	<body class="container-fluid   theme-default welcome">
		<jsp:include page="includes/header.jsp"></jsp:include>
		<div class="container row-fluid welcomePage">
			<div  class="col-md-12 banner well"> 
				<div class="col-md-8 testimonial" >
					<h5>What users say about us?</h5>
					<p><strong>&ldquo;</strong>i was thinking to personally meet a professional life coach or something because i was getting overwhelmed with my recursive thoughts but since i have you guys helping me... i think my search has ended here</p>
					<em>(BTech  Graduate, preparing for banking exam and struggling to find herself)</em>
					<a class="pull-right" href="testimonials">View More<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></a>
					<div class="clearfix"></div>
				</div>
				<div class="col-md-3 counter pull-right">
					<p><strong>300+ </strong>users supported in 30 days</p>
					<mark>32 Supporters</mark>
					<br/>
					<a href="https://milaap.org/campaigns/dost" target="_blank">SUPPORT THE CAUSE</a>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="col-md-8">
				<ul>
					<li class="exploration_option well col-md-6" id="discussions">
							<h3 class="categoryName"><a href="forums/show/6.page">Discussions</a></h3>
							<ul class="discussions_list details_box">
								<li class="loadingIndex" id="loading">
									<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
								</li>	
							</ul>
					</li>
					
					<li class="exploration_option well col-md-6" id="faqs">
						<h3 class="categoryName"><a href="faqs">Frequently Asked Questions</a></h3>
							<ul class="details_box">
								<li class="loadingIndex" id="loading">
									<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
								</li>
							</ul>
					</li>
					
					<li class="exploration_option well col-md-6" id="quotes" >
					<a href="quotes">
						<h3 class="categoryName">Quotes</h3>
						<ul class="details_box">
								<li>
									If you tell the truth, you don't have to remember anything.<span class="secondary_information">~Mark Twain</span>
								</li>
								<li>
									If an egg is broken by an outside force, LIFE ENDS. If broken by an inside force, LIFE BEGINS. Great things always begin from inside.
								</li>
								<li>
									Winners are not people who never fail, but people who never quit.
								</li>
								<li>
									One day you will wake up and there won't be any more time to do the things you've always wanted to do. DO IT NOW.
								</li>
								<li>
									Our greatest weekness lies in giving up. The more certain way to succeed is always to try just one more time  <span class="secondary_information">~Thomas A Edison</span>
								</li>
								<li>
									If God gives you a dream, he gives you an ability to achieve it.
								</li>
								
							</ul>
					</a>
					</li>
					<li class="exploration_option well col-md-6" id="signupNow_index">
						<a href="signupNow">
							<ul class="details_box">
								<li>
									<h4 class="topic_categoryName coming_soon"><strong>SIGNUP NOW</strong> and get into 1 to 1 chat with professional psychologists and other experienced people</h4>
								</li>
								
							</ul>
							
							
						</a>
					</li>
					<!-- <li class="exploration_option well horoscopes">
						<h3 class="categoryName">Horoscopes</h3>
						<ul>
							<li><a>Aquarius</a></li>
							<li><a>Pisces</a></li>
							<li><a>Aries</a></li>
							<li><a>Taurus</a></li>
							<li><a>Gemini</a></li>
							<li><a>Cancer</a></li>
							<li><a>Leo</a></li>
							<li><a>Virgo</a></li>
							<li><a>Libra</a></li>
							<li><a>Scorpio</a></li>
							<li><a>Saggitarius</a></li>
							<li><a>Capricon</a></li>
						</ul>
					</li>
					 -->
					
					<li class="exploration_option well col-md-6" >
						<h3 class="categoryName">Destressing Techniques</h3>
						<ul class="details_box">
								<li>
									<h4 class="topic_categoryName coming_soon">COMING SOON</h4>
								</li>
								
						</ul>
					</li>
					
					<li class="exploration_option well col-md-6" id="personalityTest">
						<h3 class="categoryName ">Personality Tests</h3>
						<ul class="details_box">
							<li>
								<h4 class="topic_categoryName coming_soon">Find out about your personality!<br/> COMING SOON</h4>
							</li>
						</ul>
					</li>
					
					<li class="clearfix"></li>
				</ul>
			</div>
			<sec:authorize access="!hasRole('ROLE_ADMIN')">
				<sec:authorize ifNotGranted="ROLE_USER">
					<jsp:include page="includes/signUp.jsp"></jsp:include>
				</sec:authorize>
				
				<sec:authorize access="hasRole('ROLE_USER')">
						<jsp:include page="includes/side_unit.jsp"></jsp:include>
				</sec:authorize>
			</sec:authorize>
		</div>
		<jsp:include page="includes/commonFooter.jsp"></jsp:include>
	</body>
</html>

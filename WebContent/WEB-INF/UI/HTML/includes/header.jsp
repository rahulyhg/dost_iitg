<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sec:authorize access="hasRole('ROLE_ADMIN')">
	<header id="main-navbar" class="navbar navbar-default navbar-fixed-top">
	  <div class="navbar-inner">
		<div>
		  <a class="navbar-brand" href="${pageContext.request.contextPath}/index" >
			  	<img src="${pageContext.request.contextPath}/resources/img/logoSmall.jpg" height="47px"/>
		  </a>
		  <div class="nav-collapse nav-collapse navbar-collapse">
		  
			<!--<p class="navbar-text pull-right">
				<a href="#" class="navbar-link">Create your account</a>
			</p>-->
			
				<ul class="nav navbar-nav pull-right ">
					<li><a href="#" class="navbar-link">${pageContext.request.userPrincipal.name}</a></li>
					<li><a href="dost/j_spring_security_logout" class="navbar-link">Logout</a></li>
				</ul>
				<ul class="nav navbar-nav pull-left menuItems">
					  <!-- Adding this after talking to Richa, conversation link should appear only for Prashant and Aarti -->
					  <%
					  if(request.getUserPrincipal().getName().equalsIgnoreCase("prashant") || request.getUserPrincipal().getName().equalsIgnoreCase("aarti")) {
					  %>
					  <li id="conversations"><a href="${pageContext.request.contextPath}/conversations">Conversations</a></li>
					  <%
					  }
					  %>
					  
					  <li id="patientHistory"><a href="${pageContext.request.contextPath}/patientList">Client History</a></li>
					  <!-- <li id="onlineCounseling"><a href="onlineCounseling">Online Counseling</a></li> -->
					  <li id="forums"><a href="${pageContext.request.contextPath}/forums/show/6.page">Discussions</a></li>
					  <li id="faqs"><a href="${pageContext.request.contextPath}/faqs">FAQs</a></li>
					  <li id="quotes"><a href="${pageContext.request.contextPath}/quotes">Quotes</a></li>
					  <li class="dropdown" id="blog">
					  		 <a href="#" data-toggle="dropdown" class="dropdown-toggle">Blogs <b class="caret"></b></a>
				             <ul class="dropdown-menu">
				                    <li><a href="${pageContext.request.contextPath}/blog/?=love">Relationships</a></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=marriage">Marriages</a></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=education">Education</a></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=parents">Parents/Kids</a></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=experience">Experiences</a></li>
				                    <li class="divider"></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=counseling%20profession">Counseling Profession</a></li>
				                </ul>
		            </li>
		             <li style="" id="team"><a href="${pageContext.request.contextPath}/team">Team</a></li>
				</ul>
			
		  </div><!--/.nav-collapse -->
		</div>
	  </div>
	</header>
</sec:authorize>
<sec:authorize access="!hasRole('ROLE_ADMIN')">
	<header id="main-navbar" class="navbar navbar-inverse navbar-fixed-top">
		  <div class="navbar-inner">
			<div>
			  <a class="navbar-brand" href="${pageContext.request.contextPath}/index" >
			  	<img src="${pageContext.request.contextPath}/resources/img/logoSmall.jpg" height="47px"/>
			  </a>
			  <div class="nav-collapse navbar-collapse ">
				<ul class="nav navbar-nav pull-right ">
					<sec:authorize ifNotGranted="ROLE_USER">
						<li style=""><a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-large login_now">LOGIN</a></li>
						<li style=""><a href="${pageContext.request.contextPath}/signupNow" class="btn btn-primary btn-large signup_now">SIGNUP NOW</a></li>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_USER')">
						<li><a href="#" class="navbar-link">${pageContext.request.userPrincipal.name}</a></li>
						<li><a href="dost/j_spring_security_logout" class="navbar-link">Logout</a></li>
					</sec:authorize>
				</ul>
				<ul class="nav navbar-nav pull-left menuItems">
				  <sec:authorize access="hasRole('ROLE_USER')">
					<li style="" id="conversations"><a href="${pageContext.request.contextPath}/conversations">My Conversations</a></li>
				  </sec:authorize>
				  <li style="" id="discussions"><a href="${pageContext.request.contextPath}/forums/show/6.page">Discussions</a></li>
				  <sec:authorize access="hasRole('ROLE_USER')">
				  	<li style="" id="talkToFriend"><a href="${pageContext.request.contextPath}/talkToFriend">Talk To a Friend</a></li>
				  </sec:authorize>
				  <sec:authorize access="hasRole('ROLE_USER')">
				  	<li style="" id="talkToSpecificFriend"><a href="${pageContext.request.contextPath}/chat2">Talk To Specific Friend</a></li>
				  </sec:authorize>				  
				  <li id="faqs"><a href="${pageContext.request.contextPath}/faqs">FAQs</a></li>
				  <li style="" id="quotes"><a href="${pageContext.request.contextPath}/quotes">Quotes</a></li>
				  <!-- <li id="blogs"><a href="http://blog.yourdost.com" target="_blank">Blog</a></li>-->
				  <li class="dropdown" id="blogs">
					  		 <a href="#" data-toggle="dropdown" class="dropdown-toggle">Blogs <b class="caret"></b></a>
				             <ul class="dropdown-menu">
				                    <li><a href="${pageContext.request.contextPath}/blog/?=love">Relationships</a></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=marriage">Marriages</a></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=education">Education</a></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=parents">Parents/Kids</a></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=experience">Experiences</a></li>
				                    <li class="divider"></li>
				                    <li><a href="${pageContext.request.contextPath}/blog/?=counseling%20profession">Counseling Profession</a></li>
				                </ul>
		            </li>
		            <li style="" id="team"><a href="${pageContext.request.contextPath}/team">Team</a></li>
				</ul>
			  </div><!--/.nav-collapse -->
			</div>
		  </div>
	</header>
</sec:authorize>

	

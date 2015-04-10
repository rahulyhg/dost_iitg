<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<head>
		<meta charset="utf-8">
		<title>Quotes : Your D.O.S.T - IIT Guwahati</title>
	</head>
	<style>
		body, html { width:100% ;
		height:100% ;
		overflow:hidden ;
		}
		
		iframe { width:100% ;
		    height:100% ;
		border:none ;
		}
	</style>
	<body>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		
		<body class="theme-default theme-default-counselor" >
		</sec:authorize>
		<sec:authorize access="!hasRole('ROLE_ADMIN')">
		<body class="theme-default">
		</sec:authorize>
		<jsp:include page="includes/header.jsp"></jsp:include>					
		
		<iframe class="quotes" src="http://quotesiitg.blogspot.in/search/label/quote" height="100%"></iframe>
	
	</body>
	<!--<sec:authorize access="hasRole('ROLE_ADMIN')">
	<body class="theme-default theme-default-counselor" >
	</sec:authorize>
	<sec:authorize access="!hasRole('ROLE_ADMIN')">
	<body class="theme-default">
	</sec:authorize>

		<jsp:include page="includes/header.jsp"></jsp:include>
		
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
			<sec:authorize ifNotGranted="ROLE_USER">
				<jsp:include page="includes/signUp.jsp"></jsp:include>
			</sec:authorize>
		</div>-->
		
</html>

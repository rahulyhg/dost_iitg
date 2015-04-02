<!DOCTYPE html>
<html lang="en">
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<body class="theme-default  theme-default-counselor" >
		<jsp:include page="includes/header.jsp"></jsp:include>
		<div class="container">
			<div class="col-md-11">
				<div class="pageTop">
					<h2 class="pull-left pageHeading">Online clients</h2>
					<div class="clearfix"></div>
				</div>
				
				<ul class="pull-left col-md-2 left_nav">
					<li class="active"><a href="#">Current</a></li>
					<li><a href="#">Scheduled</a></li>
				</ul>
				<ul class="pull-right col-md-10">
					<!-- each online patient-->
					<li class="media conversation_topic">
						<div class="well media">
							<a class="pull-left col-md-1" href="#">
								<img class="media-object profile_pic"/>
							</a>
							<div class="pull-left media-body col-md-3">
								<h4 class="owner_name">Brusley</h4>
								<span class="pull-left chatPatient">Chat </span>
								<span class="pull-left emailPatient"> 
									<span class="glyphicon glyphicon-envelope"></span>Email
								</span>
							</div>
							<div class="pull-left col-md-4">
								<span class="label label-warning">New</span>
								<div>Hi, can I really talk to you?</div>
							</div>
							<div class="pull-left col-md-2">
								<a href="#">+Label</a><br/>
								<a href="#">+Note</a>
							</div>
						</div>
					</li>
					<!-- each online patient-->
					
					<!-- each online patient-->
					<li class="media conversation_topic">
						<div class="well media">
							<a class="pull-left col-md-1" href="#">
								<img class="media-object profile_pic"/>
							</a>
							<div class="pull-left media-body col-md-3">
								<h4 class="owner_name">Brusley</h4>
								<span class="pull-left chatPatient">Chat </span>
								<span class="pull-left emailPatient"> 
									<span class="glyphicon glyphicon-envelope"></span>Email
								</span>
							</div>
							<div class="pull-left col-md-4">
								<span class="label label-primary">Ongoing</span>
								<div>By: Prashant</div>
							</div>
							<div class="pull-left col-md-2">
								<span>Career,</span><span>Relationship,</span><span>Child,</span><a href="#">+Label</a>
								<a href="#">+Note</a>
							</div>
						</div>
					</li>
					<!-- each online patient-->
					
					<!-- each online patient-->
					<li class="media conversation_topic">
						<div class="well media">
							<a class="pull-left col-md-1" href="#">
								<img class="media-object profile_pic"/>
							</a>
							<div class="pull-left media-body col-md-3">
								<h4 class="owner_name">Brusley</h4>
								<span class="pull-left chatPatient">Chat </span>
								<span class="pull-left emailPatient"> 
									<span class="glyphicon glyphicon-envelope"></span>Email
								</span>
							</div>
							<div class="pull-left col-md-4">
								<span class="label label-info">Existing</span>
								<div>By: Santosh</div>
								<div>Old: Sina, Reshma</div>
							</div>
							<div class="pull-left col-md-2">
								<span>Career,</span><span>Relationship,</span><span>Child,</span><a href="#">+Label</a>
								<a href="#">+Note</a>
							</div>
						</div>
					</li>
					<!-- each online patient-->
					
				</ul>
					
			</div>
		</div>
		<jsp:include page="includes/commonFooter.jsp"></jsp:include>
	</body>
</html>
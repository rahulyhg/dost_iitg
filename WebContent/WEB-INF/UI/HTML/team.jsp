<!DOCTYPE html>

<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Your D.O.S.T Team</title>
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/teams.css"> 
		<script>
		$(document).ready(function(){
		    $(document).ajaxStart(function(){
		        $(".loading").css("display", "block");
		    });
		    
		    
		});
		</script>
	<script>
		$.getJSON( "${pageContext.request.contextPath}/resources/JSON/teams.json", function( data ){
				var core_team  = data[ "core_team"  ] ;
				var volunteers = data[ "volunteers" ] ;	
				var campus = data[ "campus" ] ;	
				//ajax loading done
				$(document).ajaxComplete(function(){
			        $(".loading").css("display", "none");
			        alert("loading done");
			    });
				
				$.each( core_team, function( index, elem ){
					var html = return_team_html() ;
					
					$("#coreTeam .details").append(html) ;
					
					var this_list_html = $("#coreTeam").find(".listOuterContainer").last() ;
					
					$(this_list_html).find(".listheading").text( elem.name ) ;
					$(this_list_html).find(".listContent").html( elem.details ) ;
					$(this_list_html).find(".linkedin a").attr("href", elem.linkedin ) ;
					$(this_list_html).find(".twitter a").attr("href", elem.twitter ) ;
					var background_image= '#FFEDB5 url("resources/img/team/'+elem.image+'") no-repeat center center';
					$(this_list_html).find(".listImage").css("background", background_image ) ;
					
					if( index > 0 ){
						$(this_list_html).addClass("col-md-offset-1") ;
						
					}
					
				});


				$.each( volunteers, function( index, elem ){
					var html = return_team_html() ;
					
					$("#volunteers .details").append(html) ;
					
					var this_list_html = $("#volunteers").find(".listOuterContainer").last() ;
					
					$(this_list_html).find(".listheading").text( elem.name ) ;
					$(this_list_html).find(".listContent").html( elem.details ) ;
					$(this_list_html).find(".linkedin a").attr("href", elem.linkedin ) ;
					$(this_list_html).find(".twitter").attr("id", elem.name ) ;
					$(this_list_html).find(".twitter a").attr("href", elem.twitter ) ;
					
					var background_image= '#FFEDB5 url("resources/img/team/'+elem.image+'") no-repeat center center';
					$(this_list_html).find(".listImage").css("background", background_image ) ;
					
					if( index > 0 && (index % 3 ) ){
						$(this_list_html).addClass("col-md-offset-1") ;
						
					}
					
					if( index >= 3 ){
						
						$(this_list_html).css("margin-top","40px" ) ;
					}
					
				});
				
				/* $.each(campus, function( index, elem ){
					var html = return_team_html() ;
					
					$("#campusAmbassador .details").append(html) ;
					
					var this_list_html = $("#campusAmbassador").find(".listOuterContainer").last() ;
					
					$(this_list_html).find(".listheading").text( elem.name ) ;
					$(this_list_html).find(".listContent").html( elem.details ) ;
					$(this_list_html).find(".linkedin a").attr("href", elem.linkedin ) ;
					$(this_list_html).find(".twitter").attr("id", elem.name ) ;
					$(this_list_html).find(".twitter a").attr("href", elem.twitter ) ;
					
					var background_image= '#FFEDB5 url("resources/img/team/'+elem.image+'") no-repeat center center';
					$(this_list_html).find(".listImage").css("background", background_image ) ;
					
					if( index > 0 && (index % 3 ) ){
						$(this_list_html).addClass("col-md-offset-1") ;
						
					}
					
					if( index >= 3 ){
						
						$(this_list_html).css("margin-top","40px" ) ;
					}
					
				}); */

		});

	
		function return_team_html(){
			
			var html = '<div class="col-md-3 listOuterContainer" >'+
							'<div class="col-md-12">'+
								'<div>'+
									'<div class="col-md-8 col-md-offset-2 listheading"></div>'+
									'<div class="clearfix"></div>'+
								'</div>'+
								'<div>'+
									'<div class="col-md-8 col-md-offset-4 listImage"></div>'+
									'<div class="clearfix"></div>'+
								'</div>'+
								'<div>'+
									'<div class="listContent">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</div>'+
									'<div class="clearfix"></div>'+
								'</div>'+
								'<div>'+
									'<div class="listFooter">'+
										'<div class="col-md-6 linkedin"><a target="_blank" href="#">LinkedIn</a></div>'+
										'<div class="col-md-6 twitter" ><a target="_blank"href="#">Twitter</a></div>'+
										'<div class="clearfix"></div>'+
									'</div>'+
								'</div>'+
							'</div>'+
						'</div>';
			return html ;
		}	
		
		
	</script>	
		
	<body class="container-fluid   theme-default">

	<jsp:include page="includes/header.jsp"></jsp:include>
	<li class="loading" id="loading">
							<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
						</li>
				
	<div class="container row-fluid pageMainContainer" >
	
	
		<div id="coreTeam" class="row">	
		
			<div class="row">
				<h2 class="col-md-3 pageHeading">
					CORE TEAM
				</h2>
			</div>
			<div class="details well"></div>
		</div>
			
		<div id="volunteers" class="row">
			<div class="row">
				<h2 class="pull-left pageHeading">
                    VOLUNTEERS <em>(People who make this work seamlessly)</em>
				</h2>
				<!--  <a href="https://www.surveymonkey.com/s/FP6Z6QN" target="_blank" class="pull-left become_a_volunteer">Do you want to volunteer too?</a>-->
			</div>
			<div class="details well"></div>
			
		</div>
	
	 <!--  <div id="campusAmbassador" class="row" >	
			<div class="row">
				<h2 class="pull-left pageHeading">
					CAMPUS AMBASSADOR
				</h2>
				<a href="https://www.surveymonkey.com/s/FP6Z6QN" target="_blank" class="pull-left become_a_volunteer">Do you want to volunteer too?</a>
			</div>
			<div class="details well"></div>
	</div>	 -->	
</div>

		<jsp:include page="includes/commonFooter.jsp"></jsp:include>

</body>
</html>
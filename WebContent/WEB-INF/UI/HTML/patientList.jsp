<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
	<jsp:include page="includes/commonHeader.jsp"></jsp:include>
	<%-- <script src="${pageContext.request.contextPath}/resources/JS/jquery.jscroll.min.js"></script> --%>
	<script>
	$("document").ready(function() {
		loadPatientList();
	});

		var gloablFlag  = false;
		var gloablePage = 1;
		var gloablSearchPage = 1;
		var globalPerPage = 25;
		var globalScroll = true;
		 function triggerPagination() {
		   if($(window).scrollTop() + $(window).height() > $(document).height() - 300 && globalScroll) {
				if(gloablFlag) {
					var searchText = $("#patientSearch").val();
					if(searchText.length > 0) {
						searchPatient();
					} else {
						loadPatientList();	
					}
				}		
		   }
		 }
				function searchPatient(ele) {
					var searchText = $("#patientSearch").val();
					if(searchText.length >= 3) {
						loadingImage();
						if(gloablSearchPage <= 1) {
							$(".patient_list").empty();	
						}
						var url = '/dost/api/users?searchtext='+searchText+'&page='+gloablSearchPage+'&per_page='+globalPerPage+'&sort_by=userId&order=desc';
						loadPatientList(url, true);	
					}else if(searchText.length == 0){
						gloablePage = 1;
						gloablSearchPage = 1;
						loadingImage();
						$(".patient_list").empty();
						loadPatientList();
					}
				}
				function loadPatientList(url, isSearch) {
					if (!url) {
						url = '/dost/api/users?page='+gloablePage+'&per_page='+globalPerPage+'&sort_by=userId&order=desc';
					}
					$.ajax({
					      url: url,
					      type: "GET",
					      beforeSend: function( xhr ) {
					    	  gloablFlag = false;
					    	  loadingImage();
					      },
					      success: function(user){
					    	  gloablFlag = true;
					    	  if(isSearch) {
					    		  gloablSearchPage++;
					    	  } else {
					    		  gloablePage++;  
					    	  }
					    	  
					    	  $(".loading").hide();
								for(i=0; i<user.length; i++){
									$(".patient_list").append('<li onmouseover="showButton(this);" onmouseout="hideButton(this);" class="media ceac_patient">'+
																'<a class="pull-left col-md-6" href="patientDetails?='+user[i].username+"+"+user[i].userId+'">'+
																	'<img class="avatar" id='+user[i].avatar+' src="avatar/'+user[i].avatar+'.png" name='+user[i].avatar+'/>'+
																	'<span class="patient_name">'+user[i].username+'</span>'+
																	'<span class="pull-right glyphicon glyphicon-chevron-right"></span>'+
																'</a>'+
																'<button class="pull-right btn btn-large btn-primary" style="display:none;" type="button" onclick="blockUser(\''+user[i].username+'\',this)">Block</button>'+	
															'</li>');
									
								}
								
								if(user.length < globalPerPage) {
									globalScroll = false;
								}else {
									globalScroll = true;
								}
								if(user.length == 0 && isSearch) {
									$("#noSearchResult").remove();
									$(".patient_list").append("<div id='noSearchResult' >No Search result found.</div>")
								} else {
									$("#noSearchResult").remove();
								}
								$(".secondloading").remove();
					      },
					      error:function(){
					          alert("failure");
					          $("#result").append('Error Occurred while fetching data.');
					      }   
					    }); 
				}
				
				function loadingImage() {
					$(".patient_list").append('<li class="secondloading"><img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" /></li>');
				}

	</script>
		
	<body onscroll="triggerPagination();" class="theme-default theme-default-counselor" >
		<jsp:include page="includes/header.jsp"></jsp:include>
		<div class="container row-fluid">
			<div class="pageTop">
					<h2 class="pull-left pageHeading">
						Client History
					</h2>
					<div class="clearfix"></div>
			</div>
			<div class="searchBox"><label>Search: <input id="patientSearch" onkeyup="searchPatient(this)"; type="text"></label></div>
			<div class="col-md-11 well">
				<div class="pull-left col-md-12">
					<ul class="patient_list">
						<li class="loading" id="loading">
							<!--  <img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />-->
						</li>
					</ul>
					<div class="clearfix"></div>
				</div>
			</div>
					
		</div>
		<jsp:include page="includes/commonFooter.jsp"></jsp:include>
	</body>
</html>
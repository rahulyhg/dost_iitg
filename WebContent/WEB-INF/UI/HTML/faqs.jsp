<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<jsp:include page="includes/commonHeader.jsp"></jsp:include>
<jsp:include page="includes/header.jsp"></jsp:include>
<head>
<meta charset="utf-8">
<title>Frequently Asked Questions, Your D.O.S.T - IITG</title>
<script>
	$(function() {
		
		/*Manipulating json for FAQ*/
		$.getJSON("/dost/api/faqcategory/all", function(FAQ) {	
			
			$(".loading").hide();
			
			for (var i = 0 ; i < FAQ.length; i++) {
				
				/*FAQ listing on faq page*/
				$(".FAQList").append('<div class="well categoryList"><h3 class="categoryName subHeading" id='+FAQ[i].faqCategoryName+">"+FAQ[i].faqCategoryName+"</h3>");
				$("#"+FAQ[i].faqCategoryName).after("<ul></ul></div>");

				for (var j = 0 ; j < FAQ[i].faqs.length; j++) {
					$("#"+FAQ[i].faqCategoryName).siblings("ul").append('<li class="questionAnswer" id='+FAQ[i].faqs[j].faqId+'><div class="question">'+FAQ[i].faqs[j].question+'</div><div class="answer">'+ FAQ[i].faqs[j].answer +"</div></li>");
				}
				/* end of FAQ listing on faq page*/
				
				/*FAQ listing on index page*/
				var numberOfQuestions = FAQ[i].faqs.length;
				$("#faqs ul").append('<li>'+ FAQ[i].faqs[numberOfQuestions -1].question +'</li>');
				/*end of FAQ listing on index page*/
				
				
		}
		/*End of manipulating json for FAQ*/
		
		
		/*clicking FAQs*/
		$(".question").click(function(){
				$(this).addClass("clickedQuestion");
				$(this).closest(".questionAnswer").addClass("clicked");
				$(".nextPreviousNav").show();
				$(".allQuestions").show();
				$(".question").not(this).hide();
				var thisCategory = $(this).closest(".categoryList");
				$(".categoryList").not(thisCategory).hide();
				$(this).siblings(".answer").show();
				$(".searchBox").hide();	
				$("#deletebutton, #editbutton").removeClass("hide");
				
		});
		/*end of click on FAQs*/

		/*Moving through FAQs*/
		$(".allQuestions").click(function(){
				$(".categoryName").show();
				$(".question").removeClass("clickedQuestion");
				$(".questionAnswer").removeClass("clicked");
				$(".nextPreviousNav").hide();
				$(".allQuestions").hide();
				$(".categoryList").show();
				$(".questionAnswer").show();
				$(".question").show();
				$(".answer").hide();
				$(".searchBox").show();
				$("#deletebutton, #editbutton").addClass("hide");
		});
		/*End of Moving through FAQs*/
		
		if(window.location.href.indexOf("?=") > -1){
			var element = window.location.href.split("=");
			setTimeout(function() {
					$("#"+element[1]).children(".question").trigger("click");
			},10);
		}
		
		/*Next Previous navigation*/
		$(".next").click(function(){
			$(".clickedQuestion").closest("li.questionAnswer").hide();
			var nextQuestion = $(".clickedQuestion").closest("li").next("li");		
			
			if(nextQuestion.length == 0){
				nextCategory= $(".clickedQuestion").closest(".categoryList").next(".categoryList");
				if(nextCategory.length==0){
					nextCategory = $(".categoryList:first-child");
				}
				nextCategory.show();
				nextQuestion =	nextCategory.find("li:first-child");
				$(".clickedQuestion").removeClass("clickedQuestion").closest(".categoryList").hide();
			}
			
			
			$(".clickedQuestion").removeClass("clickedQuestion");
			nextQuestion.show();
			nextQuestion.find("div").show();
			nextQuestion.find(".question").addClass("clickedQuestion");
		});
		
		
		$(".previous").click(function(){
			$(".clickedQuestion").closest("li.questionAnswer").hide();
			var prevQuestion = $(".clickedQuestion").closest("li").prev("li");		
			
			if(prevQuestion.length == 0){
				prevCategory= $(".clickedQuestion").closest(".categoryList").prev(".categoryList");
				if(prevCategory.length==0){
					prevCategory = $(".categoryList:last-child");
				}
				prevCategory.show();
				prevQuestion =	prevCategory.find("li:last-child");
				$(".clickedQuestion").removeClass("clickedQuestion").closest(".categoryList").hide();
			}
			
			$(".clickedQuestion").removeClass("clickedQuestion");
			prevQuestion.show();
			prevQuestion.find("div").show();
			prevQuestion.find(".question").addClass("clickedQuestion");
		});
		/*end of next previous navigation*/
		
		
	});
	
	/*for search*/
		$(".FAQList").sieve({ itemSelector: ".question" });
		$(".FAQList").prev("div").addClass("searchBox");
	/*end of for search*/
		
	/*for adding edit/delete options for a question*/
		if($(".theme-default").hasClass("theme-default-counselor")){
			$(".questionAnswer").hover(
					function(){
						
						$(this).append('<div class="editDeleteOptions pull-right">'+
											'<div class="editQuestion col-md-1">Edit </div>'+ 
											'<div class="deleteQuestion  col-md-1"> Delete</div>'+
										'</div>');
					},
					function(){
						$(this).find(".editDeleteOptions").remove();
					}
			);
		}
		/*End of for adding edit/delete options for a question*/
		
		/* for editing the Question/Answer */
				
		$(".FAQList").on("click",".editQuestion", function(){
			$("#dialog").dialog("option","title", "Edit this question/Answer");
			$("#dialog").dialog("open");

			$("#faq").show();
			$(".confirm-delete").remove();
			$(".ui-dialog-buttonset button:last-child span").text("EDIT");
			
			var questionToBeEdited = $(".questionAnswer").find(".clickedQuestion").text();
			var answerToBeEdited = $(".questionAnswer").find(".clickedQuestion").next().text();
			$(".questionForm").val(questionToBeEdited);
			$(".answerForm").val(answerToBeEdited);
			$(".ui-dialog-buttonset button").show();
			$(".ui-dialog-buttonset button").eq(1).hide();
			$(".ui-dialog-buttonset button").eq(3).hide();
		});
		
		
		$(".FAQList").on("click","#deletebutton", function(){
			$("#dialog").dialog("option","title", "Delete the Question/Answer");
			$("#dialog").dialog("open");
			
			$("#faq").hide();
			$("#dialog").append('<h2 class="confirm-delete" style="color:#d55; text-align:center">Are you sure you want to delete?</h2>');
			$(".ui-dialog-buttonset button").show();
			$(".ui-dialog-buttonset button").eq(1).hide();
			$(".ui-dialog-buttonset button").eq(2).hide();
			$(".ui-dialog-buttonset button").eq(3).find("span").text("DELETE");
		});
		
		
		
		/* end of for editing the Question/Answer */

		
		//alert($("#faq").serialize());
		
		$("#dialog").dialog({
			modal: true,
			autoOpen : false,
			width : 600,
			buttons : [ {
				text : "CANCEL",
				click : function() {
					$(this).dialog("close");
				}
			}, {
				text : "ADD",
				click : function() {
					
					var datastring = $("#faq").serializeArray();
				      var formData = {};
				      $.map(datastring, function(n, i){
				          formData[n['name']] = n['value'];
				      });
					$.ajax({
	              		type: "POST",
	              		url: "http://localhost:8800/dost/api/faq/add",
	              		contentType: "application/json",
	              		data:JSON.stringify(formData),
	                      dataType: "jsonP"
	              	}).done(function(response){
	              	});
					$("#dialog").html('<h2 style="color:#5a5; text-align:center">Added Successfully</h2>')
					window.setTimeout('location.reload()', 1000);
				}
			}, {
				text : "EDIT",
				click : function() {
					var datastring = $("#faq").serializeArray();
				      var formData = {};
				      $.map(datastring, function(n, i){
				          formData[n['name']] = n['value'];
				      });

				      formData["id"]=$(".clicked").attr("id");
				      formData["categoryId"]=$('select#categoryid option:selected').attr("id");
					$.ajax({
                		type: "PUT",
                		url: "http://localhost:8800/dost/api/faq/update",
                		contentType: "application/json",
                		data:JSON.stringify(formData),
                        dataType: "jsonP"
                	}).done(function(response){
                	});
					$("#dialog").html('<h2 style="color:#5a5; text-align:center">Edited Successfully</h2>')
					window.setTimeout('location.reload()', 1000);
				}
			}, {
				text : "DELETE",
				click : function() {					
					$.ajax({
                		type: "DELETE",
                		url: "http://localhost:8800/dost/api/faq/"+$('.clicked').attr('id')+"/delete"
                	}).done(function(response){
                	});
					$("#dialog").html('<h2 style="color:#5a5; text-align:center">Deleted Successfully</h2>')
					window.setTimeout('location.reload()', 1000);
				}
			} ]
		});
		
		/* Adding question*/
		$("#addbutton").click(function(event) {
			$("#dialog").dialog("option","title", "Add New Question");
			$("#dialog").dialog("open");
			$("#faq").show();
			$(".confirm-delete").remove();
			$('.ui-widget-overlay').css('background', 'white');
			
			$(".questionForm").val("");
			$(".answerForm").val("");
			$(".ui-dialog-buttonset button").show();
			$(".ui-dialog-buttonset button").eq(2).hide();
			$(".ui-dialog-buttonset button").eq(3).hide();
		});
		
		
		
	});
	
	
</script>
</head>
<sec:authorize access="hasRole('ROLE_ADMIN')">
<body class="theme-default theme-default-counselor" >
</sec:authorize>
<sec:authorize access="!hasRole('ROLE_ADMIN')">
<body class="theme-default">
</sec:authorize>

	<div class="container row-fluid">
		<div class="col-md-7">
			<div class="pageTop">
				<h2 class="pull-left pageHeading">Frequently Asked Questions</h2>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button type="button" id="addbutton" class="addFAQs btn btn-primary pull-right">ADD FAQs</button>
				</sec:authorize>
				<div class="clearfix"></div>
			</div>
			<div>
				<div class="pull-left allQuestions">Back to List</div>
				<div class="pull-right nextPreviousNav">
					<span id="previous" class="previous">Previous</span> 
					<span id="next" class="next">Next</span>
				</div>
				<div class="clearfix"></div>
				<div class="FAQList">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<button type="button" id="editbutton" class="editQuestion btn btn-primary pull-right hide">EDIT</button>
					<button type="button" id="deletebutton" class="addFAQs btn btn-primary pull-right hide">DELETE</button>
				</sec:authorize>		
				</div>
				
				
			</div>
			<div class="loading" id="loading">
						<img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" alt="Loader" />
			</div>
			<p>We are extremely thankful to <a target="_blank" href="https://www.linkedin.com/profile/view?id=21998428">Mahalakshmi Rajagopal</a>, <a target="_blank" href="http://in.linkedin.com/in/tarun911">Tarun Verma</a>, <a target="_blank" href="http://ca.linkedin.com/pub/namrta-mohan/42/519/802">Namrta Moha</a>, <a target="_blank" href="http://in.linkedin.com/pub/veena-bose/3b/921/471">Veena Bose </a>, <a target="_blank" href="https://www.linkedin.com/profile/view?id=117319614">Anamika Papriwal</a> for helping us with frequenly asked questions</p>
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
	<!-- modal dialog -->
		<div id="dialog" class="modal-dialog" title="Add a Question">
		  <div>
		    <div>
		      <form name="faq" id="faq" action="" method="post">
				
				Question : <input id="question" name="question" type="text" value="Question" class="form-control questionForm" placeholder="Type your question"> </br> 
				Answer : <textarea id="answer" name="answer" placeholder="Type the answer" class="form-control answerForm" rows="3" ></textarea> </br> 
				
				Select Category : <select id="categoryid" name="category">
									  <option id="1" name="career" value="career">Career</option>
									  <option id="2" name="Love-Relationships" value="relationship">Love/Relationship</option>
									  <option id="3" name="family" value="family">Family</option>
									  <option id="4" name="friends" value="friends">Friends</option>
									  <option id="5" name="other" value="other">Other</option>
									</select> </br>
				
			
			</form>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
</body>
</html>

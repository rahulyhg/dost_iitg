<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="dialogMessage" class="modal-dialog" title="Leave a Message" >
	
		<div class="messageModal" >
	    		<sec:authorize access="hasRole('ROLE_USER')">
	    			<div class="mainMessage">
	    				<p>Hi ${pageContext.request.userPrincipal.name},</p>
						<p>I am here for you. Just tell me what’s on your mind and I will help you. 
					   		Believe me even I have been in some situations myself and I know how hard it can get at times.
					   		I can assure you, I am your friend - not a computer program and I am here to help you in any way I can.
						</p>
					</div>
					<br/>	
				</sec:authorize>
				
				<sec:authorize access="hasRole('ROLE_ADMIN')">
				<form id="message">
					<div class="error alert alert-danger" role="alert"></div>
					<label>To</label>
					<input id="recipient" required type="text" id="autocomplete" class="form-control questionForm autocomplete" placeholder="Send To"/>
					<input type="hidden" id="selected_recipient" />
					<br/>
					
					<label>Subject</label>
	      			<input required id="subject" type="text" class="form-control questionForm" placeholder="Subject"/>
	      			<br/>
	      			<label>Message</label>
	      			<textarea required id="messageContent"  rows="3" class="well form-control" placeholder="Type your query"></textarea>
	      		</form>
				</sec:authorize>
				
	      		<sec:authorize access="hasRole('ROLE_USER')">
	      		<form id="message">
	      			<div class="error alert alert-danger" role="alert"></div>
	      			<label>Subject</label>
	      			<input required id="subject" type="text" class="form-control questionForm" placeholder="Subject"/>
	      			<br/>
	      			<label>Message</label>
	      			<textarea required id="messageContent"  rows="3" class="well form-control" placeholder="Type your query"></textarea>
	      			<label>Tags</label>
	      			<select name="userTags" id="userTags" class="form-control"></select>
	      		</form>
	      		</sec:authorize>
	    </div>
	</div><!-- /.modal -->
<div class="col-md-3" >
	<div class="login_unit right_unit well">
		<p class="header_message">Is something bothering you?</p>
		<p class="message_signup">Discuss your worries by <strong>anonymously</strong> chatting with <strong>psychologists</strong> and other <strong>non-judgemental</strong> individuals</p>
		<div class="signupLoginOption">
			<a href="talkToFriend" class="btn btn-primary btn-large start_talking">START TALKING TO YOUR FRIEND</a>
			<p class="counter" id="counter"></p> 
		</div>
	</div>
	<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
	<script>
	$(document).ready(function() {
		
		$.getJSON('/dost/api/users/count', function(count) {
			$("#counter").append(count.count + ' people already seeking help from special friends!');
		});
	});
	</script>
</div>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- popup showing note -->
<div class="notePopup">
			<form>
				<textarea class="form-control" autocomplete="off" id="messageContent" name="messageContent" rows="3"></textarea>
				<label class="error hidden">add a note</label>
				<button type="button"  class="addNoteButton pull-right btn btn-primary">Submit</button>
				<button type="button"  class="cancelButton pull-right btn btn-outline">Cancel</button>
			</form>
</div>
<!-- end of popup showing note -->
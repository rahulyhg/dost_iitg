<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>

<jsp:include page="includes/commonHeader.jsp"></jsp:include>
<style>
.forgot_password_message{
padding: 50px ;
margin-top: 50px;
}
</style>
<body class="container-fluid  theme-default" onload='document.loginForm.username.focus();'>
<jsp:include page="includes/header.jsp"></jsp:include>
<div class="container row-fluid welcomePage">
<div class="col-md-10 well forgot_password_message">
Please send us a mail at <a href="mailto:yourdostiitg@gmail.com">yourdostiitg@gmail.com</a> and we will quickly send across the password.
<br/>We are troubling you because we want to be sure, no-one is misusing your account.
</div>
</div>
<jsp:include page="includes/commonFooter.jsp"></jsp:include>

</body>
</html>
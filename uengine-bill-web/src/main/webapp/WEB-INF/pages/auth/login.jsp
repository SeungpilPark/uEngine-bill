<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org"
      lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>uEngine Billing | HOME</title>

    <%@include file="../template/header_js.jsp" %>
</head>

<body class="gray-bg">

<div class="middle-box text-center loginscreen animated fadeInDown">
    <div>
        <div>

            <h1 class="logo-name">uEngine</h1>

        </div>
        <h3>Welcome to uEngine Billing</h3>

        <p>uEngine Billing is a powerful subscription management software which handles recurring billing and payments
            efficiently.Sign up for a free test account.
        </p>

        <p>Login in. To see it in action.</p>

        <form id="login_form" class="m-t" role="form">
            <input type="hidden" name="scope" value="uEngineSubscriptions/subscriptionsapi">

            <div class="form-group">
                <input type="text" name="username" class="form-control" placeholder="Username" required="">
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="Password" required="">
            </div>
            <button type="submit" class="btn btn-primary block full-width m-b">Login</button>

            <a href="#">
                <small>Forgot password?</small>
            </a>

            <p class="text-muted text-center">
                <small>Do not have an account?</small>
            </p>
            <a class="btn btn-sm btn-white btn-block" href="/registe/register">Create an account</a>
        </form>
        <p class="m-t">
            <small>uEngine subscription billing app &copy; 2016</small>
        </p>
    </div>
</div>

<%@include file="../template/footer_js.jsp" %>

</body>


<script>
    $(function () {
        $('#login_form').submit(function (event) {
            event.preventDefault();
            var data = uBilling.getFormData($(this));
            uBilling.login(data)
                    .done(function () {
                        window.location.href = '/';
                    })
                    .fail(function () {
                        window.location.href = '/auth/fail';
                    })
        });
    })
</script>
</body>
</html>

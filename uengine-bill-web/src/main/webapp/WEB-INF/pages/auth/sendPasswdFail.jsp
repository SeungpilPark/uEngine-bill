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
    <title>OCE IAM | HOME</title>

    <%@include file="../template/header_js.jsp" %>

    <link rel="stylesheet" href="/resources/assets/css/pages/page_log_reg_v1.css">
</head>

<!-- body classes:
        "boxed": boxed layout mode e.g. <body class="boxed">
        "pattern-1 ... pattern-9": background patterns for boxed layout mode e.g. <body class="boxed pattern-1">
-->

<div class="wrapper">
    <%@include file="../template/header.jsp" %>

    <!--=== Breadcrumbs ===-->
    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left"><uengine:message code="menu.login"/></h1>
            <ul class="pull-right breadcrumb">
                <li><a href="index.html"><uengine:message code="menu.home"/></a></li>
                <li class="active"><uengine:message code="menu.login"/></li>
            </ul>
        </div>
    </div>
    <!--/breadcrumbs-->

    <!--=== Content Part ===-->
    <div class="container content">
        <div class="row">
            <div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">

                <form id="login_form" class="reg-page" action="/auth/sendPasswd" method="post" role="form">
                    <div class="reg-header">
                        <h2><uengine:message code="login.sendpasswd.fail"></uengine:message> </h2>
                        <p><uengine:message code="login.forget.desc"></uengine:message> </p>
                    </div>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                        <input name="email" type="email" placeholder="Email" class="form-control">
                    </div>
                    <div class="input-group margin-bottom-20"></div>

                    <div class="row" style="margin-top: 30px;">
                        <button class="btn-u col-centered" type="submit" id="refresh_timer"><uengine:message code="common.send"></uengine:message> </button>
                    </div>

                    <hr>

                    <h4><uengine:message code="login.forget.email1"></uengine:message> </h4>
                    <p><uengine:message code="login.forget.email2"></uengine:message> <a class="color-green" href="/auth/forgetEmail"> <uengine:message code="login.forget.email3"></uengine:message> </a> <uengine:message code="login.forget.email4"></uengine:message> </p>
                </form>
            </div>
        </div><!--/row-->
    </div><!--/container-->
    <!--/container-->
    <!-- End Content Part -->


    <%@include file="../template/footer.jsp" %>
</div>
<!--/wrapper-->

<%@include file="../template/footer_js.jsp" %>

<script type="text/javascript">
    $(function () {
        $('#login_form').validate({

            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                email: {
                    required: message.msg('form.invalid.common'),
                    email: message.msg('form.invalid.email')
                }
            },
            invalidHandler: function() {
                blockStop();
            },
            errorPlacement: function(error, element) {
                element.parent().after(error);
            }
        });
    })
</script>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>

<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html xmlns="http://www.w3.org/1999/xhtml"
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
            <h1 class="pull-left"><uengine:message code="menu.register"/></h1>
            <ul class="pull-right breadcrumb">
                <li><a href="index.html"><uengine:message code="menu.home"/></a></li>
                <li class="active"><uengine:message code="menu.register"/></li>
            </ul>
        </div>
    </div>
    <!--/breadcrumbs-->

    <!--=== Content Part ===-->
    <div class="container content">
        <div class="row">
            <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                <form action="/registe/request" method="post" class="reg-page" id="register_form">
                    <div class="reg-header">
                        <h2><uengine:message code="registe.new.title"/> </h2>

                        <p><uengine:message code="login.sendpasswd.success2"/> <a href="/auth/login"
                                                                                   class="color-green">
                            <uengine:message code="login.sendpasswd.success3"/> </a> <uengine:message
                                code="login.sendpasswd.success4"/></p>
                        <br>
                    </div>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                        <input name="email" type="email" placeholder="<uengine:message code="registe.new.email"/>" class="form-control">
                    </div>
                    <div class="input-group margin-bottom-20"></div>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                        <input name="password" type="password" placeholder="<uengine:message code="registe.new.passwd"/>" class="form-control">
                    </div>
                    <div class="input-group margin-bottom-20"></div>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                        <input name="confirmPassword" type="password" placeholder="<uengine:message code="registe.new.confirm"/>"
                               class="form-control">
                    </div>
                    <div class="input-group margin-bottom-20"></div>

                    <hr>

                    <div class="row" style="margin-top: 30px;">
                        <div class="col-lg-6 checkbox">
                            <label>
                                <input type="checkbox" name="checkRead">
                                <a href="page_terms.html" class="color-green"><uengine:message code="registe.new.terms"/> </a>
                            </label>
                        </div>
                        <div class="col-lg-6 text-right">
                            <button class="btn-u" type="submit"><uengine:message code="registe.new.send"/> </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--/container-->


    <%@include file="../template/footer.jsp" %>
</div>
<!--/wrapper-->

<%@include file="../template/footer_js.jsp" %>

<script type="text/javascript">
    $(function () {
        $.validator.addMethod('passwdConfirm', function (value, element, param) {
            var passinput = $('#register_form').find('[name=password]');
            if (passinput.val() == value)
                return true;

            return false;
        });
        $('#register_form').validate({

            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                email: {
                    required: true,
                    email: true
                },
                password: {
                    required: true,
                    minlength: 8,
                    alphanumeric: true
                },
                confirmPassword: {
                    required: true,
                    passwdConfirm: true
                },
                checkRead: {
                    required: true
                }
            },
            messages: {
                email: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>",
                    email: "<span style='color: red;'>"+message.msg('registe.new.email')+"</span>"
                },
                password: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>",
                    minlength: "<span style='color: red;'>"+message.msg('form.invalid.passwd')+"</span>",
                    alphanumeric: "<span style='color: red;'>"+message.msg('form.invalid.passwd')+"</span>"
                },
                confirmPassword: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>",
                    passwdConfirm: "<span style='color: red;'>"+message.msg('form.invalid.confirm')+"</span>"
                },
                checkRead: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>"
                }
            },
            invalidHandler: function() {
                blockStop();
            },
            errorPlacement: function (error, element) {
                element.parent().after(error);
            }
        });
    })
</script>
</html>

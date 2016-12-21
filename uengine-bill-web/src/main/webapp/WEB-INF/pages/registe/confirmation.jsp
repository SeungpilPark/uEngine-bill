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
                <form class="reg-page" id="register_form">
                    <div class="reg-header">
                        <h2><uengine:message code="registe.confirmation.title"/></h2>

                        <p><uengine:message code="login.sendpasswd.success2"/> <a href="/auth/login"
                                                                                   class="color-green">
                            <uengine:message code="login.sendpasswd.success3"/> </a> <uengine:message
                                code="login.sendpasswd.success4"/></p>

                        <p>

                        <div id="mailExist" style="font-size: large;"></div>
                        </p>
                        <uengine:message code="registe.confirmation.sended"/>
                    </div>

                    <div class="row" style="margin-top: 30px;">
                        <button class="btn-u col-centered" id="refresh_timer"><uengine:message
                                code="registe.confirmation.retry"/></button>
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
        var refreshCount = 0;
        var refreshBtn = $('#refresh_timer');
        var animateBtn;
        $('#register_form').submit(function (e) {
            e.preventDefault();
            if (refreshCount < 1) {
                //ajax로 메일재전송을 요청한 후 30초 대기
                var data = {email: '${responseEmail}'};
                $.ajax({
                    type: "POST",
                    url: "/registe/remail",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "text",
                    success: function (response) {
                    },
                    error: function (request, status, errorThrown) {
                    }
                });

                refreshCount = 30;
                refreshBtn.text(message.msg('registe.confirmation.retry') + ' (' + msssage.msg('registe.confirmation.retry.timeout') + ' ' + refreshCount + ')');
                animateBtn = setInterval(function () {
                    refreshCount = refreshCount - 1;
                    if (refreshCount < 1) {
                        refreshBtn.text(message.msg('registe.confirmation.retry'));
                        clearInterval(animateBtn);
                        animateBtn = null;
                    } else {
                        refreshBtn.text(message.msg('registe.confirmation.retry') + ' (' + msssage.msg('registe.confirmation.retry.timeout') + ' ' + refreshCount + ')');
                    }
                }, 1000);
            }
        });
        $('#mailExist').text('${responseEmail}');

    })
</script>
</html>

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
                        <h2><uengine:message code="registe.complete.title"/> </h2>

                        <p>

                        <div id="mailExist"></div>
                        <uengine:message code="registe.complete.desc"/>
                        </p>
                    </div>

                    <div class="row" style="margin-top: 30px;">
                        <button type="submit" class="btn-u col-centered"><uengine:message code="registe.gotologin"/> </button>
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
        $('#register_form').submit(function (e) {
            e.preventDefault();
            location.href = "/auth/login";
        });
    })
</script>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>OCE IAM | HOME</title>

    <!-- Meta -->
    <%@include file="../template/header_js.jsp" %>

    <!-- CSS Page Style -->
    <link rel="stylesheet" href="/resources/assets/css/pages/profile.css">
    <link rel="stylesheet" href="/resources/assets/css/pages/page_faq1.css">

</head>


<div class="wrapper">
    <%@include file="../template/header.jsp" %>

    <!--=== Breadcrumbs ===-->
    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left"><uengine:message code="menu.memberinfo"/></h1>
            <ul class="pull-right breadcrumb">
                <li><a href="index.html"><uengine:message code="menu.home"/></a></li>
                <li class="active"><uengine:message code="menu.memberinfo"/></li>
            </ul>
        </div>
    </div>
    <!--/breadcrumbs-->

    <%--<%@include file="./banner.jsp" %>--%>

    <!--=== Profile ===-->
    <div class="container content profile">
        <div class="row">
            <!--Left Sidebar-->
            <div class="col-md-3 md-margin-bottom-40">
                <%@include file="./menu.jsp" %>
                <script type="text/javascript">$('[name=list-menu-download]').addClass('active');</script>
            </div>
            <!--End Left Sidebar-->

            <!-- Profile Content -->
            <div class="col-md-9">
                <!-- Heading Examples -->
                <div class="headline-center margin-bottom-30"><h2><uengine:message code="download.link"></uengine:message></h2></div>

                <div class="service-block service-block-default">
                    <i class="icon-custom icon-color-dark rounded-x fa fa-lightbulb-o"></i>

                    <p><uengine:message code="download.compatibility.text"></uengine:message></p>
                </div>

                <%@include file="../flamingo/flamingo-download-list-2.0.0.jsp" %>
            </div>
            <!-- End Profile Content -->
        </div>
        <!--/end row-->
    </div>
    <!--=== End Profile ===-->

    <%@include file="../template/footer.jsp" %>
</div>
<!--/wrapper-->

<%@include file="../template/footer_js.jsp" %>

</html>
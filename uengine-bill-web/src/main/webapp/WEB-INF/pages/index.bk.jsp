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

    <%@include file="template/header_js.jsp" %>

</head>

<div class="wrapper">
    <%@include file="template/header.jsp" %>

    <%@include file="template/purchase.jsp" %>

    <!--=== Content Part ===-->
    <div class="container content-sm">
        <!-- Service Blocks -->
        <div class="row margin-bottom-30">
            <div class="col-md-4">
                <div class="service">
                    <i class="fa fa-compress service-icon"></i>

                    <div class="desc">
                        <h4>Proven </h4>

                        <p>OCE Products are being used and proven to be effective by many enterprises and government offices such as Ministry of National Defense, Ministry of Land, Infrastructure, and Transport, National Information Society Agency, Electronics and Telecommunications Research Institute, Korea Institute of Industrial Technology and Korea Institute of Industrial Technology and Samsung Electronics </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="service">
                    <i class="fa fa-cogs service-icon"></i>

                    <div class="desc">
                        <h4>Integrated </h4>

                        <p>OCE IAM accommodates a web-based remote terminal, numerous analytic algorithm modules, and a management tool for system administrators. Flamingo satisfies needs for data analysts, software engineers, and system administrators. </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="service">
                    <i class="fa fa-rocket service-icon"></i>

                    <div class="desc">
                        <h4>Powerful </h4>

                        <p>One quick installation of OCE IAM takes care of setting up a Oauth2.0 EcoSystem based integrated authentication and api gateway platform for engineers, data analysts, and system administrators. </p>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Service Blokcs -->


        <!-- Owl Clients v1 -->
        <div class="headline"><h2>OCE Products Customers</h2></div>
        <div class="owl-clients-v1">
            <div class="item">
                <img src="/resources/images/customers/1.png" alt="Client 1">
            </div>
            <div class="item">
                <img src="/resources/images/customers/2.png" alt="Client 2">
            </div>
            <div class="item">
                <img src="/resources/images/customers/3.png" alt="Client 3">
            </div>
            <div class="item">
                <img src="/resources/images/customers/4.png" alt="Client 4">
            </div>
            <div class="item">
                <img src="/resources/images/customers/5.png" alt="Client 5">
            </div>
            <div class="item">
                <img src="/resources/images/customers/6.png" alt="Client 6">
            </div>
        </div>
        <!-- End Owl Clients v1 -->
    </div>
    <!--/container-->
    <!-- End Content Part -->


    <%@include file="template/footer.jsp" %>


</div>
<!--/wrapper-->

<%@include file="template/footer_js.jsp" %>
</html>

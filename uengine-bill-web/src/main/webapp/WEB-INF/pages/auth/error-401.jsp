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

<div class="middle-box text-center animated fadeInDown">
    <h1>401</h1>
    <h3 class="font-bold">Deny access</h3>

    <div class="error-desc">
        Sorry, you don't have permission about this page. We apologize.<br/>
        You can go back to main page: <br/><a href="/index" class="btn btn-primary m-t">Dashboard</a>
    </div>
</div>

<%@include file="../template/footer_js.jsp" %>

</body>


<script>
    $(function(){

    })
</script>
</body>
</html>

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
        <h3>Register Confirmation</h3>
        <p>Already Signed Up? Click <a href="/auth/login">Sign In</a> to login your account.</p>

        <br>
        <p id="mailExist"></p>

        <p>위의 E-mail 주소로 가입 확인 메일을 발송하였습니다. 발송된 메일의 링크를 누르시면 서비스를 이용하실 수 있습니다.</p>

        <form id="register_form" class="m-t" role="form">
            <button type="submit" id="refresh_timer" class="btn btn-primary block full-width m-b">재발송</button>
        </form>
        <p class="m-t"> <small>uEngine subscription billing app &copy; 2016</small> </p>
    </div>
</div>

<%@include file="../template/footer_js.jsp" %>

</body>


<script>
    $(function () {
        var refreshCount = 0;
        var refreshBtn = $('#refresh_timer');
        var animateBtn;
        $('#register_form').submit(function (e) {
            e.preventDefault();
            if (refreshCount < 1) {
                //ajax로 메일재전송을 요청한 후 30초 대기
                var data = {userName: '${responseUserName}'};
                $.ajax({
                    type: "POST",
                    url: "/registe/remail",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "text",
                    success: function (response) {
                    },
                    error: function (request, status, errorThrown) {
                    },
                    complete: function(){
                        blockStop();
                    }
                });

                refreshCount = 30;
                refreshBtn.text('재발송 (대기시간 ' + refreshCount + ')');
                animateBtn = setInterval(function () {
                    refreshCount = refreshCount - 1;
                    if (refreshCount < 1) {
                        refreshBtn.text('재발송');
                        clearInterval(animateBtn);
                        animateBtn = null;
                    } else {
                        refreshBtn.text('재발송 (대기시간 ' + refreshCount + ')');
                    }
                }, 1000);
            }
        });
        $('#mailExist').text('${responseEmail}');

    })
</script>
</body>
</html>

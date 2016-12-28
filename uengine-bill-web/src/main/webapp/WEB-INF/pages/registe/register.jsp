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
    <h3>Register a new account</h3>
    <p>Already Signed Up? Click <a href="/auth/login">Sign In</a> to login your account.</p>

    <form action="/registe/request" method="post" id="register_form" class="m-t" role="form">
      <div class="form-group">
        <input type="text" name="userName" class="form-control" placeholder="Username" required="">
      </div>
      <div class="form-group">
        <input type="email" name="email" class="form-control" placeholder="Email" required="">
      </div>
      <div class="form-group">
        <input type="password" name="password" class="form-control" placeholder="Password" required="">
      </div>
      <div class="form-group">
        <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password" required="">
      </div>
      <button type="submit" class="btn btn-primary block full-width m-b">Sign up</button>

    </form>
    <p class="m-t"> <small>uEngine subscription billing app &copy; 2016</small> </p>
  </div>
</div>

<%@include file="../template/footer_js.jsp" %>

</body>


<script>
  $(function(){
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
        userName: {
          required: true
        },
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
      invalidHandler: function() {
        blockStop();
      },
      errorPlacement: function (error, element) {
        element.parent().after(error);
      }
    });
  })
</script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
    <script type="text/javascript" src="/resources/plugins/cookie/js.cookie.js"></script>
</head>

<script type="text/javascript">

    $.extend(
            {
                redirectPost: function (location, args) {
                    var form = '';
                    $.each(args, function (key, value) {
                        form += '<input type="hidden" name="' + key + '" value="' + value + '">';
                    });
                    $('<form action="' + location + '" method="POST">' + form + '</form>').appendTo('body').submit();
                }
            });

    $(function () {
        var authorizeResponse = ${jsonAuthorizeResponse};
        var managementKey = authorizeResponse.management.managementKey;
        var clientKey = authorizeResponse.clientId;
        var userName = undefined;
        var scopes = authorizeResponse.scope;
        var responseType = authorizeResponse.responseType;
        var redirectUri = authorizeResponse.redirectUri;
        var state = authorizeResponse.state;
        var tokenType = authorizeResponse.tokenType;
        var claim = authorizeResponse.claim;
        var redirectData = {
            managementKey: managementKey,
            clientKey: clientKey,
            userName: userName,
            scopes: scopes,
            responseType: responseType,
            redirectUri: redirectUri,
            state: state,
            tokenType: tokenType ? tokenType : '',
            claim: claim ? encodeURIComponent(claim) : ''
        };

        if(redirectData.tokenType){
            console.log(redirectData.tokenType);
        }
        console.log(redirectData);

        var checkSession = function () {
            var session_token = Cookies.get(managementKey);
            var data = {
                managementKey: managementKey ? managementKey : '',
                token: session_token ? session_token : ''
            };
            $.ajax({
                type: "POST",
                url: "/oauth/check_session",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "text",
                async: false,
                success: function (response) {
                    var res = JSON.parse(response);

                    //로그인 세션 확인시 어세스 토큰을 서버로 보냄
                    if (res.success && res.map.validated) {
                        userName = res.map.userName;
                        checkScopeToken();
                    }
                    //로그인 세션 만료시 로그인 URL 노출
                    else {
                        viewLogin();
                    }
                },
                error: function (request, status, errorThrown) {

                }
            });
        };

        var saveSessionToken = function (sessionToken) {
            Cookies.set(managementKey, sessionToken, {expires: 7});
        };

        var saveScopeToken = function (scopeToken) {
            Cookies.set(clientKey, scopeToken, {expires: 7});
        };

        var checkScopeToken = function () {
            var scope_token = Cookies.get(clientKey);
            var data = {
                clientKey: clientKey ? clientKey : '',
                token: scope_token ? scope_token : ''
            };
            $.ajax({
                type: "POST",
                url: "/oauth/check_scope",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "text",
                async: false,
                success: function (response) {
                    var res = JSON.parse(response);

                    //스코프 만족시 서버에 스코프 수락 보내기
                    if (res.success && res.map.validated) {
                        redirectScopeAuthorize();
                    }
                    //스코프 화면 보이기
                    else {
                        viewScope();
                    }
                },
                error: function (request, status, errorThrown) {

                }
            });
        };

        var createScopeToken = function () {
            var data = {
                managementKey: managementKey ? managementKey : '',
                clientKey: clientKey ? clientKey : '',
                userName: userName ? userName : '',
                scopes: scopes ? scopes : ''
            };
            $.ajax({
                type: "POST",
                url: "/oauth/create_scope_token",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "text",
                async: false,
                success: function (response) {

                    blockStop();
                    var res = JSON.parse(response);
                    if (res.success) {
                        saveScopeToken(res.map.token);
                        redirectScopeAuthorize(true);
                    }
                    else {
                        msgBox('Unable allow permission.');
                    }
                },
                error: function (request, status, errorThrown) {

                }
            });
        };

        var redirectScopeAuthorize = function (allow) {

            var redirect = '/oauth/redirect';
            redirectData.userName = userName;
            $.redirectPost(redirect, redirectData);
        };

        var viewLogin = function () {
            $('#scope_form').hide();
            $('#login_form').show();
            $('#wrapper').show();
        };

        var viewScope = function () {
            $('#scope_form').show();
            $('#login_form').hide();
            $('#wrapper').show();
        };

        $('#scope_allow').click(function () {
            createScopeToken();
        });

        $('#scope_cancel').click(function () {
            redirectScopeAuthorize(false);
        });

        $('#login_form').validate({
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                userName: {
                    required: true
                },
                userPassword: {
                    required: true
                }
            },
            messages: {
                userName: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                userPassword: {
                    required: "<span style='color: red;'>Required filed</span>"
                }
            },
            invalidHandler: function () {
                blockStop();
            },
            errorPlacement: function (error, element) {
                element.parent().after(error);
            },
            submitHandler: function (form, event) {
                event.preventDefault();
                form = $('#login_form');
                var data = {
                    userName: form.find('[name=userName]').val(),
                    userPassword: form.find('[name=userPassword]').val(),
                    managementKey: managementKey
                };
                blockStart('Please wait a moment...');

                $.ajax({
                    type: "POST",
                    url: "/oauth/login",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "text",
                    success: function (response) {
                        blockStop();
                        var res = JSON.parse(response);
                        if (res.success) {
                            saveSessionToken(res.map.token);
                            userName = res.map.userName;
                            checkScopeToken();
                        }
                        else {
                            msgBox('Unable login. Check Username and Password.');
                        }
                    },
                    error: function (request, status, errorThrown) {
                        blockStop();
                        msgBox('Unable login. Check Username and Password.');
                    }
                });
            }
        });

        checkSession();
    });

</script>

<div class="wrapper" id="wrapper" style="display: none">
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
            <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">

                <form id="scope_form" class="reg-page">

                    <div class="reg-header">
                        <h2>Scope check </h2>
                    </div>

                    <h4>${authorizeResponse.oauthClient.name} request the following permissions.</h4>

                    <c:forEach items="${authorizeResponse.oauthScopes}" var="oauthScope" varStatus="status">
                        <div class="alert alert-success fade in margin-bottom-40">
                            <h4>${oauthScope.name}</h4>
                                ${oauthScope.description}
                        </div>
                    </c:forEach>

                    <div class="row" style="margin-top: 30px;">
                        <div class="col-md-6 col-md-offset-6">
                            <a class="btn-u pull-right" style="margin-left: 20px;" id="scope_allow">Allow</a>
                            <a class="btn-u pull-right" id="scope_cancel">Cancel</a>
                        </div>
                    </div>
                </form>

                <form id="login_form" class="reg-page">

                    <div class="reg-header">
                        <h2>Login to your account </h2>
                    </div>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                        <input name="userName" type="text" placeholder="User Name" class="form-control">
                    </div>
                    <div class="input-group margin-bottom-20"></div>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                        <input name="userPassword" type="password" placeholder="Password" class="form-control">
                    </div>
                    <div class="input-group margin-bottom-20"></div>

                    <div class="row" style="margin-top: 30px;">
                        <div class="col-md-6 checkbox">
                            <label><input type="checkbox"> <uengine:message code="login.stay"></uengine:message>
                            </label>
                        </div>
                        <div class="col-md-6">
                            <button class="btn-u pull-right" type="submit"><uengine:message
                                    code="login.btn"></uengine:message></button>
                        </div>
                    </div>

                    <br>

                    <p><a class="color-green" href="/registe/register">
                        <uengine:message code="login.singup1"></uengine:message> </a>
                        <uengine:message code="login.singup2"></uengine:message></p>
                    <hr>

                    <h4><uengine:message code="login.forget1"></uengine:message></h4>

                    <p><uengine:message code="login.forget2"></uengine:message>
                        <a class="color-green" href="/auth/forgetPasswd">
                            <uengine:message code="login.forget3"></uengine:message> </a>
                        <uengine:message code="login.forget4"></uengine:message></p>

                </form>
            </div>
        </div>
        <!--/row-->
    </div>
    <!--/container-->
    <!--/container-->
    <!-- End Content Part -->


    <%@include file="../template/footer.jsp" %>
</div>
<!--/wrapper-->

<%@include file="../template/footer_js.jsp" %>

</html>

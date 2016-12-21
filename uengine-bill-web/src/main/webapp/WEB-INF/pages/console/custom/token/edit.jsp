<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
    <%@include file="../../../template/header_js.jsp" %>

    <link rel="stylesheet" href="/resources/plugins/codemirror/codemirror.css">
    <script type="text/javascript" src="/resources/plugins/codemirror/codemirror.js"></script>
    <script type="text/javascript" src="/resources/plugins/codemirror/javascript.js"></script>

    <!-- CSS Page Style -->
    <link rel="stylesheet" href="/resources/assets/css/pages/profile.css">

    <link rel="stylesheet" href="/resources/plugins/select2/select2.css">
    <script type="text/javascript" src="/resources/plugins/select2/select2.js"/>


</head>


<div class="wrapper">
    <%@include file="../../../template/header.jsp" %>

    <!--=== Breadcrumbs ===-->
    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left">Management Console - ${management.managementName}</h1>
            <ul class="pull-right breadcrumb">
                <li><a href="index.html">HOME</a></li>
                <li class="active">Management Console</li>
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
                <%@include file="../../menu.jsp" %>
                <script type="text/javascript">$('[name=list-menu-custom-token]').addClass('active');</script>
            </div>
            <!--End Left Sidebar-->

            <!-- Profile Content -->
            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-12">
                        <form action="/console/custom/token/update" class="form-horizontal"
                              role="form"
                              id="CustomTokenIssuanceForm" method="post">
                            <h4>Edit Custom Token Issuance </h4>

                            <br>

                            <p>Embedded Objects:</p>

                            <p>management, client, user, scope ,token_type, claim, type</p>

                            <c:choose>
                                <c:when test="${failed}">
                                    <h4 style="color: #ff0000">Custom token issuance create failed. </h4>
                                </c:when>
                            </c:choose>

                            <div class="form-group">

                                <input type="hidden" name="useCustomTokenIssuance"
                                       value="${management.useCustomTokenIssuance}">

                                <label class="col-md-2 control-label">Use Case </label>

                                <div class="col-md-6">
                                    <label class="checkbox"><input name="useCustomToken" type="checkbox"
                                                                   value="code">Authorization Code</label>
                                    <label class="checkbox"><input name="useCustomToken" type="checkbox"
                                                                   value="implicit">Implicit Grant</label>
                                    <label class="checkbox"><input name="useCustomToken" type="checkbox"
                                                                   value="password">Resource Owner Password Credentials</label>
                                    <label class="checkbox"><input name="useCustomToken" type="checkbox"
                                                                   value="credentials">Client Credentials Grant</label>
                                    <label class="checkbox"><input name="useCustomToken" type="checkbox"
                                                                   value="refreshToken">Refresh Token</label>
                                    <label class="checkbox"><input name="useCustomToken" type="checkbox"
                                                                   value="validateToken">Validate Token</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Script </label>

                                <div class="col-md-6">
                                    <textarea id="customTokenIssuance" name="customTokenIssuance" rows="12"
                                              class="form-control">${management.customTokenIssuance}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <button id="submitBtn" type="submit" class="btn-u btn-u-primary">Edit
                                    </button>
                                </div>
                            </div>
                        </form>

                        <form action="#" class="form-horizontal"
                              role="form"
                              id="TestTokenIssuanceForm" method="post">
                            <h4>Edit Custom Token Issuance </h4>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Test User </label>

                                <div class="col-md-6">
                                    <select name="userId" class="form-control">
                                        <option value="" selected>None</option>
                                        <c:forEach items="${oauthUsers}" var="oauthUser" varStatus="status">
                                            <option value="${oauthUser._id}">${oauthUser.userName}</option>
                                        </c:forEach>
                                    </select>

                                    <p>For test Client Credentials Grant, select none.</p>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Test Client <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <select name="clientId" class="form-control">
                                        <c:forEach items="${oauthClients}" var="oauthClient" varStatus="status">
                                            <option value="${oauthClient._id}">${oauthClient.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Test Scopes <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <select name="scopes" class="form-control" multiple="multiple">
                                        <c:forEach items="${oauthScopes}" var="oauthScope" varStatus="status">
                                            <option value="${oauthScope.name}">${oauthScope.name}</option>
                                        </c:forEach>
                                    </select>

                                    <p>All scopes are enable during test.</p>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Test Token Type <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <select name="tokenType" class="form-control">
                                        <option value="Bearer">Bearer</option>
                                        <option value="JWT">JWT</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Test Claim </label>

                                <div class="col-md-6">
                                    <textarea name="claim" rows="8"
                                              class="form-control"></textarea>

                                    <p>For Bearer Token test, stay empty value</p>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <button id="testBtn" type="submit" class="btn-u btn-u-primary">Test
                                    </button>
                                </div>
                            </div>
                        </form>

                        <form action="#" class="form-horizontal"
                              role="form"
                              id="TestResult" method="post">
                            <h4>Test Result </h4>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Test Log </label>

                                <div class="col-md-6">
                                    <textarea name="log" rows="8"
                                              class="form-control"></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Test result</label>

                                <div class="col-md-6">
                                    <input name="result" type="text" class="form-control">

                                    <p id="result"></p>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- End Profile Content -->

        </div>
        <!--/end row-->
    </div>
    <!--=== End Profile ===-->

    <%@include file="../../../template/footer.jsp" %>
</div>
<!--/wrapper-->

<%@include file="../../../template/footer_js.jsp" %>

<script type="text/javascript">

    $(function () {

        var useCustomTokenIssuance = $("[name=useCustomTokenIssuance]").val();
        var split = useCustomTokenIssuance.split(",");
        for (var i = 0; i < split.length; i++) {
            $("[name=useCustomToken]").each(function () {
                if (split[i] === $(this).val()) {
                    $(this).prop("checked", true);
                }
            })
        }

        var postForm = $('#CustomTokenIssuanceForm');
        postForm.validate({
            rules: {

            },
            submitHandler: function (form, event) {
                var useCustomTokenIssuance = [];
                $("[name=useCustomToken]").each(function () {
                    if($(this).prop("checked")){
                        useCustomTokenIssuance.push($(this).val());
                    }
                });
                var join = useCustomTokenIssuance.join();
                $("[name=useCustomTokenIssuance]").val(join);
                form.submit();
            }
        });


        var editor = new CodeMirror.fromTextArea(document.getElementById("customTokenIssuance"), {
            mode: "javascript",
            styleActiveLine: true,
            lineNumbers: true
        });

        var form = $('#TestTokenIssuanceForm');

        form.find('[name=userId]').select2();
        form.find('[name=clientId]').select2();
        form.find('[name=scopes]').select2();

        //폼 발리데이션
        $.validator.addMethod('claimCheck', function (value, element, param) {
            if (value.length < 1) {
                return true;
            }
            try {
                JSON.parse(value);
            } catch (e) {
                return false;
            }
            return true;
        });
        form.validate({

            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                clientId: {
                    required: true
                },
                scopes: {
                    required: true
                },
                claim: {
                    claimCheck: true
                }
            },
            messages: {
                clientId: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                scopes: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                claim: {
                    claimCheck: "<span style='color: red;'>Invalid schema</span>"
                }
            },
            invalidHandler: function () {
                blockStop();
            },
            submitHandler: function (form, event) {
                blockStop();
                event.preventDefault();
                form = $('#TestTokenIssuanceForm');
                var data = {
                    userId: form.find('[name=userId]').val(),
                    clientId: form.find('[name=clientId]').val(),
                    scopes: form.find('[name=scopes]').val(),
                    tokenType: form.find('[name=tokenType]').val(),
                    claim: form.find('[name=claim]').val(),
                    script: editor.getDoc().getValue()
                };
                blockStart('Please wait a moment...');

                $.ajax({
                    type: "POST",
                    url: "/console/custom/token/test",
                    data: JSON.stringify(data),
                    contentType: "application/json; charset=utf-8",
                    dataType: "text",
                    success: function (response) {
                        blockStop();
                        var res = JSON.parse(response);
                        if (res.success) {
                            $('[name=log]').val(res.map.log);
                            $('[name=result]').val(res.map.value);

                            if (typeof res.map.value !== 'boolean') {
                                $('#result').html('Return value must be a boolean type');
                            } else {
                                if (res.map.value) {
                                    $('#result').html('This token will be issued .');
                                } else {
                                    $('#result').html('This token will not be issued .');
                                }
                            }
//                            if(res.map.result){
//                                $('[name=result]').val('Token');
//                            }
                        }
                        else {
                            msgBox('Unable test.');
                        }
                    },
                    error: function (request, status, errorThrown) {
                        blockStop();
                        msgBox('Unable test.');
                    }
                });
            }
        });
    });
</script>
</html>
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
    <%@include file="../../template/header_js.jsp" %>

    <!-- CSS Page Style -->
    <link rel="stylesheet" href="/resources/assets/css/pages/profile.css">

    <link rel="stylesheet" href="/resources/plugins/select2/select2.css">
    <script type="text/javascript" src="/resources/plugins/select2/select2.js"/>
</head>


<div class="wrapper">
    <%@include file="../../template/header.jsp" %>

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
                <%@include file="../menu.jsp" %>
                <script type="text/javascript">$('[name=list-menu-client]').addClass('active');</script>
            </div>
            <!--End Left Sidebar-->

            <!-- Profile Content -->
            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-12">
                        <form action="/console/client/create" class="form-horizontal"
                              role="form"
                              id="oauthClientForm" method="post">
                            <h4>Create New Oauth Client </h4>

                            <c:choose>
                                <c:when test="${duplicate}">
                                    <h4 style="color: #ff0000">Oauth scope already exist. </h4>
                                </c:when>
                                <c:when test="${failed}">
                                    <h4 style="color: #ff0000">Oauth client create failed. </h4>
                                </c:when>
                            </c:choose>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Name <span class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="name" type="text" class="form-control" value="">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Description <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="description" type="text" class="form-control" value="">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Client Trust<span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <label class="radio"><input type="radio" name="clientTrust" value="trust" checked>Trust
                                        application</label>
                                    <label class="radio"><input type="radio" name="clientTrust" value="3th_party">3Th
                                        party
                                        application</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Client Type <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <label class="radio"><input type="radio" name="clientType" value="confidential">Confidential</label>
                                    <label class="radio"><input type="radio" name="clientType" value="public" checked>Public</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Active Client </label>

                                <div class="col-md-6">
                                    <label class="checkbox"><input type="checkbox" name="activeClient" value="Y"
                                                                   checked>active</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Enable GrantTypes </label>

                                <div class="col-md-6">
                                    <label class="checkbox"><input type="checkbox" name="grantType" value="code"
                                                                   checked>Authorization
                                        Code</label>
                                    <label class="checkbox"><input type="checkbox" name="grantType" value="implicit"
                                                                   checked>Implicit Grant</label>
                                    <label class="checkbox"><input type="checkbox" name="grantType" value="password"
                                                                   checked>Resource Owner
                                        Password Credentials</label>
                                    <label class="checkbox"><input type="checkbox" name="grantType" value="credentials"
                                                                   checked>Client
                                        Credentials Grant</label>
                                </div>

                                <input type="hidden" name="authorizedGrantTypes" value="">
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Web Server Redirect Uri </label>

                                <div class="col-md-6">
                                    <input name="webServerRedirectUri" type="text" class="form-control" value="">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Refresh Token </label>

                                <div class="col-md-6">
                                    <label class="checkbox"><input type="checkbox" name="refreshTokenValidity" value="Y"
                                                                   checked>Enable refreshToken</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Code Lifetime <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="codeLifetime" type="number" class="form-control" value="3600">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">RefreshToken Lifetime <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="refreshTokenLifetime" type="number" class="form-control" value="3600">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">AccessToken Lifetime <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="accessTokenLifetime" type="number" class="form-control" value="3600">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">JwtToken Lifetime <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="jwtTokenLifetime" type="number" class="form-control" value="3600">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Scopes <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <select name="scopes" class="form-control" multiple="multiple">
                                        <c:forEach items="${oauthScopes}" var="oauthScope" varStatus="status">
                                            <option value="${oauthScope._id}">${oauthScope.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <button id="submitBtn" type="submit" class="btn-u btn-u-primary">Create Client
                                    </button>
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

    <%@include file="../../template/footer.jsp" %>
</div>
<!--/wrapper-->

<%@include file="../../template/footer_js.jsp" %>

<script type="text/javascript">
    $(function () {

        var form = $('#oauthClientForm');

        form.find('[name=scopes]').select2();

        setGrantTypes();

        form.find('[name=grantType]').click(function () {
            setGrantTypes();
        });

        function setGrantTypes() {
            var authorizedGrantTypes = '';
            var grantTypes = [];
            form.find('[name=grantType]').each(function () {
                if ($(this).is(":checked")) {
                    grantTypes.push($(this).val());
                }
            });
            $.each(grantTypes, function (index, grantType) {
                if (index == 0) {
                    authorizedGrantTypes = grantType;
                } else {
                    authorizedGrantTypes = authorizedGrantTypes + ',' + grantType;
                }
            })
            form.find('[name=authorizedGrantTypes]').val(authorizedGrantTypes);
        }

        //폼 발리데이션
        form.validate({

            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                name: {
                    required: true
                },
                description: {
                    required: true
                },
                codeLifetime: {
                    required: true,
                    number: true
                },
                refreshTokenLifetime: {
                    required: true,
                    number: true
                },
                accessTokenLifetime: {
                    required: true,
                    number: true
                },
                jwtTokenLifetime: {
                    required: true,
                    number: true
                },
                scopes: {
                    required: true
                }
            },
            messages: {
                name: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                description: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                codeLifetime: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                refreshTokenLifetime: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                accessTokenLifetime: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                jwtTokenLifetime: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                scopes: {
                    required: "<span style='color: red;'>Required filed</span>"
                }
            },
            invalidHandler: function () {
                blockStop();
            }
        });
    })
</script>
</html>
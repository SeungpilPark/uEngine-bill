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
                        <form action="/console/client/update" class="form-horizontal"
                              role="form"
                              id="oauthClientForm" method="post">
                            <h4>Edit Oauth Client </h4>

                            <c:choose>
                                <c:when test="${duplicate}">
                                    <h4 style="color: #ff0000">Oauth client name already exist. </h4>
                                </c:when>
                                <c:when test="${failed}">
                                    <h4 style="color: #ff0000">Oauth client create failed. </h4>
                                </c:when>
                            </c:choose>

                            <input type="hidden" id="_id" name="_id" value="${oauthClient._id}">

                            <div class="form-group">
                                <label class="col-md-2 control-label">Client ID <span class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input type="text" name="clientKey" class="form-control" value="${oauthClient.clientKey}" readonly>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Client Secret <span class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input type="text" name="clientSecret" class="form-control" value="${oauthClient.clientSecret}" readonly>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Client Jwt Secret <span class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input type="text" name="clientJwtSecret" class="form-control" value="${oauthClient.clientJwtSecret}" readonly>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Name <span class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="name" type="text" class="form-control" value="${oauthClient.name}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Description <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="description" type="text" class="form-control"
                                           value="${oauthClient.description}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Client Trust<span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <c:choose>
                                        <c:when test="${oauthClient.clientTrust == 'trust'}">
                                            <label class="radio">
                                                <input type="radio" name="clientTrust" value="trust" checked>Trust
                                                application</label>
                                            <label class="radio"><input type="radio" name="clientTrust"
                                                                        value="3th_party">3Th
                                                party
                                                application</label>
                                        </c:when>
                                        <c:otherwise>
                                            <label class="radio">
                                                <input type="radio" name="clientTrust" value="trust">Trust
                                                application</label>
                                            <label class="radio"><input type="radio" name="clientTrust"
                                                                        value="3th_party" checked>3Th
                                                party
                                                application</label>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Client Type <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <c:choose>
                                        <c:when test="${oauthClient.clientType == 'public'}">
                                            <label class="radio"><input type="radio" name="clientType"
                                                                        value="confidential">Confidential</label>
                                            <label class="radio"><input type="radio" name="clientType" value="public"
                                                                        checked>Public</label>
                                        </c:when>
                                        <c:otherwise>
                                            <label class="radio"><input type="radio" name="clientType"
                                                                        value="confidential"
                                                                        checked>Confidential</label>
                                            <label class="radio"><input type="radio" name="clientType" value="public">Public</label>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Active Client </label>

                                <div class="col-md-6">
                                    <label class="checkbox"><input type="checkbox" name="activeClient" value="Y"
                                                                   <c:if test="${oauthClient.activeClient == 'Y'}">checked</c:if>>active</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Enable GrantTypes </label>

                                <div class="col-md-6">
                                    <label class="checkbox"><input type="checkbox" name="grantType" value="code"
                                            >Authorization Code</label>
                                    <label class="checkbox"><input type="checkbox" name="grantType" value="implicit"
                                            >Implicit Grant</label>
                                    <label class="checkbox"><input type="checkbox" name="grantType" value="password"
                                            >Resource Owner
                                        Password Credentials</label>
                                    <label class="checkbox"><input type="checkbox" name="grantType" value="credentials"
                                            >Client Credentials Grant</label>
                                </div>

                                <input type="hidden" name="authorizedGrantTypes"
                                       value="${oauthClient.authorizedGrantTypes}">
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Web Server Redirect Uri </label>

                                <div class="col-md-6">
                                    <input name="webServerRedirectUri" type="text" class="form-control"
                                           value="${oauthClient.webServerRedirectUri}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Refresh Token </label>

                                <div class="col-md-6">
                                    <label class="checkbox"><input type="checkbox" name="refreshTokenValidity" value="Y"
                                                                   <c:if test="${oauthClient.refreshTokenValidity == 'Y'}">checked</c:if>>Enable
                                        refreshToken</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Code Lifetime <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="codeLifetime" type="number" class="form-control"
                                           value="${oauthClient.codeLifetime}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">RefreshToken Lifetime <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="refreshTokenLifetime" type="number" class="form-control"
                                           value="${oauthClient.refreshTokenLifetime}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">AccessToken Lifetime <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="accessTokenLifetime" type="number" class="form-control"
                                           value="${oauthClient.accessTokenLifetime}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">JwtToken Lifetime <span
                                        class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <input name="jwtTokenLifetime" type="number" class="form-control"
                                           value="${oauthClient.jwtTokenLifetime}">
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

                                    <c:forEach items="${clientScopes}" var="clientScope" varStatus="status">
                                        <input type="hidden" name="clientScope"
                                               value="${clientScope._id}">
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <button id="submitBtn" type="submit" class="btn-u btn-u-primary">Edit
                                    </button>

                                    <a class="btn-u btn-u-primary" id="deleteBtn">Delete </a>
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

<div class="modal fade" id="deleteConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h4 class="modal-title">Caution</h4>
            </div>
            <div class="modal-body">
                <p style="text-align: center" name="content">Are you sure delete oauth client?</p>
            </div>
            <div class="modal-footer">
                <button class="btn-u" type="button" name="delete">Delete</button>
                <button class="btn-u" type="button" name="close">Cancle</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $('#deleteBtn').click(function () {
            $('#deleteConfirm').modal({
                show: true
            });
        });

        $('#deleteConfirm').find('[name=close]').click(function () {
            $('#deleteConfirm').find('.close').click();
        });

        $('#deleteConfirm').find('[name=delete]').click(function () {
            window.location.href = '/console/client/delete?_id=' + $('#_id').val();
        });

        var form = $('#oauthClientForm');

        //스코프 처리
        var scopeOptions = form.find('[name=scopes]').find('option');
        var clientScopes = [];
        form.find('[name=clientScope]').each(function () {
            clientScopes.push($(this).val());
        });

        scopeOptions.each(function () {
            for (var i = 0; i < clientScopes.length; i++) {
                if ($(this).val() === clientScopes[i]) {
                    $(this).prop('selected', true);
                }
            }
        });
        form.find('[name=scopes]').select2();

        //그런트 처리
        var selectedGrantTypes = form.find('[name=authorizedGrantTypes]').val();
        selectedGrantTypes = selectedGrantTypes.split(',');
        $.each(selectedGrantTypes, function (index, selectedGrantType) {
            form.find('[name=grantType]').each(function () {
                if ($(this).val() == selectedGrantType) {
                    $(this).prop('checked', true);
                }
            });
        });

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
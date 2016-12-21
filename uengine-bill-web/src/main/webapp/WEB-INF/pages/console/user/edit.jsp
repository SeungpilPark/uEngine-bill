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
                <script type="text/javascript">$('[name=list-menu-user]').addClass('active');</script>
            </div>
            <!--End Left Sidebar-->

            <!-- Profile Content -->
            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-12">
                        <form action="/console/user/update" class="form-horizontal"
                              role="form"
                              id="oauthUserForm" method="post">
                            <h4>Edit Oauth User </h4>

                            <c:choose>
                                <c:when test="${duplicate}">
                                    <h4 style="color: #ff0000">Oauth user name already exist. </h4>
                                </c:when>
                                <c:when test="${failed}">
                                    <h4 style="color: #ff0000">Oauth user create failed. </h4>
                                </c:when>
                            </c:choose>

                            <input type="hidden" id="_id" name="_id" value="${oauthUser._id}">

                            <br>
                            <h4>Require fields (If there is no require field value, it will be stored as a field value in the
                                database.) </h4>

                            <p>userName: string</p>

                            <p>userPassword: string</p>

                            <p>level: number 0 ~ 5 </p>

                            <div class="form-group">
                                <label class="col-md-2 control-label">Body <span class="color-red">*</span></label>

                                <div class="col-md-6">
                                    <textarea name="body" rows="12" class="form-control"></textarea>
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
                <p style="text-align: center" name="content">Are you sure delete oauth user?</p>
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
            window.location.href = '/console/user/delete?_id=' + $('#_id').val();
        });

        var form = $('#oauthUserForm');

        var userJson = '${oauthUserJson}'
        var obj = JSON.parse(userJson);

        var str = JSON.stringify(obj, null, 2);
        form.find('[name=body]').val(str);

        //폼 발리데이션
        $.validator.addMethod('userCheck', function (value, element, param) {
            var user;
            try {
                user = JSON.parse(value);
            } catch (e) {
                return false;
            }
            if (user['userName']) {
                if (user['userName'] && typeof user['userName'] !== 'string') {
                    return false;
                }
                if (user.userName.length < 1) {
                    return false;
                }
            }
            if (user['userPassword']) {
                if (typeof user['userPassword'] !== 'string') {
                    return false;
                }
                if (user.userPassword.length < 1) {
                    return false;
                }
            }
            if (user['level']) {
                if (typeof user['level'] !== 'number') {
                    return false;
                }
                if (user.level > 5 || user.level < 0) {
                    return false;
                }
            }
            return true;
        });
        form.validate({

            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                body: {
                    required: true,
                    userCheck: true
                }
            },
            messages: {
                body: {
                    required: "<span style='color: red;'>Required filed</span>",
                    userCheck: "<span style='color: red;'>Invalid schema</span>"
                }
            },
            invalidHandler: function () {
                blockStop();
            }
        });
    })
</script>
</html>
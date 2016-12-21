<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html xmlns="http://www.w3.org/1999/xhtml"
      lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>OCE IAM | HOME</title>

    <%@include file="../template/header_js.jsp" %>

    <link rel="stylesheet" href="/resources/assets/plugins/sky-forms-pro/skyforms/css/sky-forms.css">
    <link rel="stylesheet" href="/resources/assets/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css">
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="/resources/assets/plugins/sky-forms-pro/skyforms/css/sky-forms-ie8.css"><![endif]-->

    <!-- CSS Page Style -->
    <link rel="stylesheet" href="/resources/assets/css/pages/page_faq1.css">
    <link rel="stylesheet" href="/resources/assets/css/pages/page_search_inner.css">
</head>


<div class="wrapper">
    <%@include file="../template/header.jsp" %>

    <!--=== Breadcrumbs ===-->
    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left">Management Group</h1>
            <ul class="pull-right breadcrumb">
                <li><a href="index.html">HOME</a></li>
                <li class="active">Management Group</li>
            </ul>
        </div>
    </div>
    <!--/breadcrumbs-->

    <!--=== Content Part ===-->
    <div class="container content profile">
        <div class="row">
            <div class="col-md-12">
                <form action="/management/create" class="form-horizontal"
                      role="form"
                      id="managementForm" method="post">
                    <h4>Create New Management Group </h4>

                    <c:choose>
                        <c:when test="${failed}">
                            <h4 style="color: #ff0000">Management create failed. </h4>
                        </c:when>
                    </c:choose>

                    <div class="form-group">
                        <label class="col-md-2 control-label">Name <span class="color-red">*</span></label>

                        <div class="col-md-6">
                            <input name="managementName" type="text" class="form-control" value="">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label">Description <span class="color-red">*</span></label>

                        <div class="col-md-6">
                            <textarea rows="8" name="description" class="form-control"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label">Login Check Lifetime <span
                                class="color-red">*</span></label>

                        <div class="col-md-6">
                            <input name="sessionTokenLifetime" type="number" class="form-control" value="3600">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label">Scope Check Lifetime <span
                                class="color-red">*</span></label>

                        <div class="col-md-6">
                            <input name="scopeCheckLifetime" type="number" class="form-control" value="3600">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <button id="submitBtn" type="submit" class="btn-u btn-u-primary">Create Management Group
                            </button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <!--=== End Content Part ===-->

    <%@include file="../template/footer.jsp" %>
</div>
<!--/wrapper-->
<%@include file="../template/footer_js.jsp" %>

<script type="text/javascript">
    $(function () {
        var form = $('#managementForm');

        //폼 발리데이션
        form.validate({

            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                managementName: {
                    required: true
                },
                description: {
                    required: true
                },
                sessionTokenLifetime: {
                    required: true
                },
                scopeCheckLifetime: {
                    required: true
                }
            },
            messages: {
                managementName: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                description: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                sessionTokenLifetime: {
                    required: "<span style='color: red;'>Required filed</span>"
                },
                scopeCheckLifetime: {
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

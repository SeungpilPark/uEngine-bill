<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <%@include file="../template/header_js.jsp" %>

    <!-- CSS Page Style -->
    <link rel="stylesheet" href="/resources/assets/css/pages/profile.css">

</head>


<div class="wrapper">
    <%@include file="../template/header.jsp" %>

    <!--=== Breadcrumbs ===-->
    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left"><uengine:message code="menu.memberinfo"/></h1>
            <ul class="pull-right breadcrumb">
                <li><a href="index.html"><uengine:message code="menu.home"/></a></li>
                <li class="active"><uengine:message code="menu.memberinfo"/></li>
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
                <%@include file="./menu.jsp" %>
                <script type="text/javascript">$('[name=list-menu-contact]').addClass('active');</script>
            </div>
            <!--End Left Sidebar-->

            <!-- Profile Content -->
            <div class="col-md-9">
                <form action="/my/contact/submit?${_csrf.parameterName}=${_csrf.token}" class="form-horizontal" role="form" id="contactForm" method="post" enctype="multipart/form-data">
                    <h4><uengine:message code="mypage.contact.title"/> </h4>

                    <c:choose>
                        <c:when test="${zendeskAdmin}">
                            <h4 style="color: #ff0000"><uengine:message code="mypage.contact.admin.not"/> </h4>
                        </c:when>
                        <c:when test="${failed}">
                            <h4 style="color: #ff0000"><uengine:message code="mypage.contact.fail"/> </h4>
                        </c:when>
                    </c:choose>

                    <input type="hidden" name="identifier" value="${identifier}">
                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.identifier"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <select name="contact" class="form-control">
                                <option value="GENERAL">None</option>
                                <c:forEach items="${contactPoints}" var="contactPoint" varStatus="status">
                                    <c:choose>
                                        <c:when test="${identifier == contactPoint.identifier}">
                                            <option selected
                                                    value="${contactPoint.contact},${contactPoint.identifier}">
                                                ${contactPoint.productName}
                                                license ${contactPoint.identifier}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option
                                                    value="${contactPoint.contact},${contactPoint.identifier}">
                                                ${contactPoint.productName}
                                                license ${contactPoint.identifier}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.email"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <input name="userEmail" type="email" class="form-control" value="${user.email}" readonly>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.tel"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <input name="userPhone" type="tel" class="form-control" value="${user.phone}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.service"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <select name="serviceType" class="form-control">
                                <option value="flamingo2" selected>Flamingo 2</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.contact"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <select name="contactType" class="form-control">

                                <option data-channel="GENERAL" value="about_product"><uengine:message code="mypage.contact.field.contact.about_product"/> </option>
                                <option data-channel="GENERAL" value="about_purchase"><uengine:message code="mypage.contact.field.contact.about_purchase"/> </option>
                                <option data-channel="GENERAL" value="about_price"><uengine:message code="mypage.contact.field.contact.about_price"/> </option>
                                <option data-channel="GENERAL" value="about_features"><uengine:message code="mypage.contact.field.contact.about_features"/> </option>
                                <option value="" disabled></option>
                                <option data-channel="BILL" value="refund"><uengine:message code="mypage.contact.field.contact.refund"/> </option>
                                <option data-channel="ADMIN" value="reissue"><uengine:message code="mypage.contact.field.contact.reissue"/> </option>
                                <option data-channel="TECH" value="install_hadoop"><uengine:message code="mypage.contact.field.contact.install_hadoop"/> </option>
                                <option data-channel="TECH" value="install_flamingo2"><uengine:message code="mypage.contact.field.contact.install_flamingo2"/> </option>
                                <option data-channel="TECH" value="issue_monitoring"><uengine:message code="mypage.contact.field.contact.issue_monitoring"/> </option>
                                <option data-channel="TECH" value="issue_workflow"><uengine:message code="mypage.contact.field.contact.issue_workflow"/> </option>
                                <option data-channel="TECH" value="issue_hive"><uengine:message code="mypage.contact.field.contact.issue_hive"/> </option>
                                <option data-channel="TECH" value="issue_pig"><uengine:message code="mypage.contact.field.contact.issue_pig"/> </option>
                                <option data-channel="TECH" value="issue_hdfsbrowser"><uengine:message code="mypage.contact.field.contact.issue_hdfsbrowser"/> </option>
                                <option data-channel="TECH" value="issue_algorithm"><uengine:message code="mypage.contact.field.contact.issue_algorithm"/> </option>
                                <option data-channel="TECH" value="issue_hawq"><uengine:message code="mypage.contact.field.contact.issue_hawq"/> </option>
                                <option data-channel="TECH" value="issue_batch"><uengine:message code="mypage.contact.field.contact.issue_batch"/> </option>
                                <option data-channel="TECH" value="issue_rstudio"><uengine:message code="mypage.contact.field.contact.issue_rstudio"/> </option>
                                <option data-channel="TECH" value="issue_visualization"><uengine:message code="mypage.contact.field.contact.issue_visualization"/> </option>
                                <option data-channel="TECH" value="issue_archive"><uengine:message code="mypage.contact.field.contact.issue_archive"/> </option>
                                <option data-channel="TECH" value="issue_terminal"><uengine:message code="mypage.contact.field.contact.issue_terminal"/> </option>
                                <option data-channel="TECH" value="issue_management"><uengine:message code="mypage.contact.field.contact.issue_management"/> </option>
                                <option data-channel="TECH" value="issue_else"><uengine:message code="mypage.contact.field.contact.issue_else"/> </option>
                                <option value="" disabled></option>
                                <option data-channel="GENERAL" value="business_reseller"><uengine:message code="mypage.contact.field.contact.business_reseller"/> </option>
                                <option data-channel="GENERAL" value="business_affiliates"><uengine:message code="mypage.contact.field.contact.business_affiliates"/> </option>
                                <option data-channel="GENERAL" value="business_promotional"><uengine:message code="mypage.contact.field.contact.business_promotional"/> </option>
                                <option data-channel="GENERAL" value="business_else"><uengine:message code="mypage.contact.field.contact.business_else"/> </option>

                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.priority"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <select name="priority" class="form-control">
                                <option value="LOW"><uengine:message code="mypage.contact.field.priority.low"/> </option>
                                <option value="NORMAL"><uengine:message code="mypage.contact.field.priority.normal"/> </option>
                                <option value="HIGH"><uengine:message code="mypage.contact.field.priority.high"/> </option>
                                <option value="URGENT"><uengine:message code="mypage.contact.field.priority.urgent"/> </option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.subject"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <input name="subject" type="text" class="form-control" value="">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.contents"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <textarea rows="8" name="contents" class="form-control"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.contact.field.attachments"/> <span class="color-red">*</span></label>

                        <div class="col-lg-7" id="addfileTarget">
                            <input name="file0" type="file" class="form-control">
                            <input name="file1" type="file" class="form-control" style="display: none">
                            <input name="file2" type="file" class="form-control" style="display: none">
                            <input name="file3" type="file" class="form-control" style="display: none">
                            <input name="file4" type="file" class="form-control" style="display: none">
                            <input name="file5" type="file" class="form-control" style="display: none">
                            <input name="file6" type="file" class="form-control" style="display: none">
                            <input name="file7" type="file" class="form-control" style="display: none">
                            <input name="file8" type="file" class="form-control" style="display: none">
                            <input name="file9" type="file" class="form-control" style="display: none">

                            <p><uengine:message code="mypage.contact.field.attachment.kind"/> </p>
                            <p><uengine:message code="mypage.contact.field.attachment.limit"/> </p>
                        </div>
                        <div class="col-lg-2">
                            <a class="btn-u btn-u-primary" id="addfile"><uengine:message code="mypage.contact.field.attachment.add"/> </a>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-lg-offset-2 col-lg-10">
                            <button id="submitBtn" type="submit" class="btn-u btn-u-primary"><uengine:message code="mypage.contact.create"/> </button>
                        </div>
                    </div>

                </form>

            </div>
            <!-- End Profile Content -->

        </div>
        <!--/end row-->
    </div>
    <!--=== End Profile ===-->

    <%@include file="../template/footer.jsp" %>
</div>
<!--/wrapper-->

<%@include file="../template/footer_js.jsp" %>

<script type="text/javascript">
    $(function () {
        $('#addfile').click(function(){
            var disableList = [];
            var inputs = $('#addfileTarget').find('input');
            for(var i = 0 ; i < inputs.length ; i++){
                if(inputs.eq(i).css('display') == 'none')
                    disableList.push(inputs.eq(i));
            }
            if(disableList.length > 0){
                disableList[0].show();
            }
        })
        var form = $('#contactForm');

        //문의 유형 설정.
        var updateContactType = function (contact) {
            var contactType = form.find('[name=contactType]');
            contactType.find('option').each(function () {
                var channel = $(this).data('channel');
                if (contact == 'GENERAL') {
                    if (channel == 'ADMIN' || channel == 'TECH' || channel == 'BILL')
                        $(this).attr('disabled', 'disabled');
                }
                if (contact == 'ADMIN') {
                    if (channel == 'ADMIN' || channel == 'TECH' || channel == 'BILL')
                        $(this).removeAttr('disabled');
                }
                if (contact == 'TECH') {
                    if (channel == 'ADMIN' || channel == 'BILL')
                        $(this).attr('disabled', 'disabled');
                    if (channel == 'TECH')
                        $(this).removeAttr('disabled');
                }
                if (contact == 'BILL') {
                    if (channel == 'ADMIN' || channel == 'TECH')
                        $(this).attr('disabled', 'disabled');
                    if (channel == 'BILL')
                        $(this).removeAttr('disabled');
                }
            });
        }

        var onLicenseChange = function(){
            var contact = form.find('[name=contact]').val();
            if (contact == 'GENERAL') {
                form.find('[name=identifier]').val('');
                updateContactType('GENERAL');
            } else {
                var split = contact.split(',');
                contact = split[0];
                var identifier = split[1];
                form.find('[name=identifier]').val(identifier);
                updateContactType(contact);
            }
        }

        //라이선스 변경시
        $('[name=contact]').change(function(){
            onLicenseChange();
        });

        //페이지 시작시에 설정
        onLicenseChange();

        //폼 발리데이션
        $.validator.addMethod('qnafile', function (value, element, param) {
            if(element.files[0]){
                if(element.files[0].size > (5000 * 1000))
                    return false;

                var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp' , 'xml' , 'doc' , 'pdf' , 'xls' , 'xlsx'];
                if ($.inArray(value.split('.').pop().toLowerCase(), fileExtension) == -1) {
                    return false;
                }
                return true;
            }else{
                return true;
            }
        });
        form.validate({

            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                userEmail: {
                    required: true,
                    email: true
                },
                userPhone: {
                    required: true
                },
                serviceType: {
                    required: true
                },
                contactType: {
                    required: true
                },
                subject: {
                    required: true
                },
                contents: {
                    required: true
                },
                file0 : { qnafile: true },
                file1 : { qnafile: true },
                file2 : { qnafile: true },
                file3 : { qnafile: true },
                file4 : { qnafile: true },
                file5 : { qnafile: true },
                file6 : { qnafile: true },
                file7 : { qnafile: true },
                file8 : { qnafile: true },
                file9 : { qnafile: true }
            },
            messages: {
                userEmail: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>",
                    email: "<span style='color: red;'>"+message.msg('form.invalid.email')+"</span>"
                },
                userPhone: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>"
                },
                serviceType: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>"
                },
                contactType: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>"
                },
                subject: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>"
                },
                contents: {
                    required: "<span style='color: red;'>"+message.msg('form.invalid.common')+"</span>"
                },
                file0 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file1 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file2 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file3 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file4 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file5 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file6 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file7 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file8 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" },
                file9 : { qnafile: "<span style='color: red;'>"+message.msg('form.invalid.file')+"</span>" }
            },
            invalidHandler: function() {
                blockStop();
            }
        });
    })
</script>

</html>
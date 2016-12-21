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
    <link rel="stylesheet" href="/resources/assets/css/pages/page_faq1.css">

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
                <script type="text/javascript">$('[name=list-menu-license]').addClass('active');</script>
            </div>
            <!--End Left Sidebar-->

            <!-- Profile Content -->
            <div class="col-md-9">

                <div class="tag-box tag-box-v2">
                    <p><uengine:message code="mypage.license.title.1"/> ${user.email} <uengine:message code="mypage.license.title.2"/> </p>
                </div>
                <div class="headline margin-bottom-10"><h4><uengine:message code="mypage.license.list.title"/> </h4></div>

                <div class="col-sm-3"><p><uengine:message code="mypage.license.list.product"/> </p></div>
                <div class="col-sm-5"><p><uengine:message code="mypage.license.list.holder"/></p></div>
                <div class="col-sm-2"><p><uengine:message code="mypage.license.list.expire"/></p></div>
                <div class="col-sm-2"><p><uengine:message code="mypage.license.list.support"/></p></div>
                <div style="clear: both"></div>

                <div id="noneLicense" class="tag-box tag-box-v2" style="display: none; margin-bottom: 100px;">
                    <p><uengine:message code="mypage.license.list.none"/> </p>
                </div>

                <!-- Accordion v1 -->
                <div class="panel-group acc-v1" id="accordion-1">

                    <div class="panel panel-default" style="display: none;" id="license_sample">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-1"
                                     href="#collapse-One" name="collapseHandle">
                                    <div class="row">
                                        <div class="col-sm-3"><a style="cursor: pointer" name="productName"></a></div>
                                        <div class="col-sm-5"><a style="cursor: pointer" name="holder"></a></div>
                                        <div class="col-sm-2"><a style="cursor: pointer" name="expireDate"></a></div>
                                        <div class="col-sm-2"><a style="cursor: pointer" name="request"><uengine:message code="mypage.license.list.request"/> </a></div>
                                    </div>
                                </div>
                            </h4>
                        </div>
                        <div id="collapse-One" class="panel-collapse collapse" name="collapseTarget">
                            <div class="panel-body licenseBody">
                                <div class="row">
                                    <div class="col-md-6">
                                        <table class="licenseTable">
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.holder"/> </td>
                                                <td class="val_col" name="holder"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.identifier"/> </td>
                                                <td class="val_col" name="identifier"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.serverid"/> </td>
                                                <td class="val_col" name="serverId"></td>
                                            </tr>
                                            <tr name="haslicenseKey" style="display: none">
                                                <td colspan="2">
                                                    <div class="tag-box tag-box-v3 margin-bottom-40">
                                                        <h5 style="color: darkred"><uengine:message code="mypage.license.item.licensekey"/> </h5>
                                                        <div class="licenseKeyDiv" name="licenseKey"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr name="noneServerId" style="display: none">
                                                <td colspan="2">
                                                    <div class="tag-box tag-box-v3 margin-bottom-40">
                                                        <h5 style="color: darkred"><uengine:message code="mypage.license.item.licensekey.missing.1"/> </h5>
                                                        <p> <uengine:message code="mypage.license.item.licensekey.missing.2"/> </p>
                                                        <div class="btn-container-right" style="margin-top: 10px;">
                                                            <button class="btn-u btn-u-sm btn-u-blue" name="serverIdTag"><uengine:message code="mypage.license.item.licensekey.missing.btn"/> </button>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.issue"/> </td>
                                                <td class="val_col" name="issueDate"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.expire"/> </td>
                                                <td class="val_col" name="expireDate"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.tech"/> <span
                                                        class="glyphicon glyphicon-question-sign"></span></td>
                                                <td class="val_col" name="techEmail"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.bill"/> <span
                                                        class="glyphicon glyphicon-question-sign"></span></td>
                                                <td class="val_col" name="billEmail"></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-6">
                                        <table class="licenseTable">
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.status"/> </td>
                                                <td class="val_col" name="status"></td>
                                            </tr>
                                            <tr name="expiredStatus" style="display: none;">
                                                <td colspan="2">
                                                    <div class="tag-box tag-box-v3 margin-bottom-40">
                                                        <h5 style="color: darkred"><uengine:message code="mypage.license.item.status.invaild.1"/> </h5>
                                                        <p><uengine:message code="mypage.license.item.status.invaild.2"/> <a href="#"> <uengine:message code="mypage.license.item.status.invaild.3"/> </a> </p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.product"/> </td>
                                                <td class="val_col" name="productName"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.version"/> </td>
                                                <td class="val_col" name="productVersion"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.type"/> </td>
                                                <td class="val_col" name="licenseType"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.country"/> </td>
                                                <td class="val_col" name="enduserCompCountry"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.maxnode"/> </td>
                                                <td class="val_col" name="maxNode"></td>
                                            </tr>
                                            <tr>
                                                <td class="key_col"><uengine:message code="mypage.license.item.days"/> </td>
                                                <td class="val_col" name="days"></td>
                                            </tr>
                                        </table>
                                        <div class="btn-container-right" style="margin-top: 10px; display: none">
                                            <button class="btn-u btn-u-blue pull-right" name="invoiceBtn"><uengine:message code="mypage.license.invoice.send"/> </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- End Accordion v1 -->

                <div class="headline margin-bottom-10"><h4>문의 채널</h4></div>

                <c:forEach items="${contactPoints}" var="contactPoint" varStatus="status">
                    <div class="row blog blog-medium margin-bottom-40" style="padding-left: 20px; padding-right: 20px;">
                        <h4>
                            <a>
                                <c:choose>
                                    <c:when test="${contactPoint.contact == 'ADMIN'}">
                                        <uengine:message code="mypage.license.channel.admin"/>
                                    </c:when>
                                    <c:when test="${contactPoint.contact == 'TECH'}">
                                        <uengine:message code="mypage.license.channel.tech"/>
                                    </c:when>
                                    <c:when test="${contactPoint.contact == 'BILL'}">
                                        <uengine:message code="mypage.license.channel.bill"/>
                                    </c:when>
                                </c:choose>
                                <br>
                                ${contactPoint.productName} ${contactPoint.identifier}
                            </a>
                        </h4>
                        <ul class="list-unstyled list-inline blog-info">
                            <c:choose>
                                <c:when test="${contactPoint.status == 'ACTIVE'}">
                                    <li><i class="fa fa-calendar"></i> <uengine:message code="mypage.license.channel.expire.1"/> : ${contactPoint.expireDate}</li>
                                    <span> <uengine:message code="mypage.license.channel.expire.2"/> : ${contactPoint.restDate} <uengine:message code="mypage.license.channel.expire.3"/> </span>
                                </c:when>
                                <c:when test="${contactPoint.status == 'EXPIRED'}">
                                    <li><i class="fa fa-calendar"></i> <uengine:message code="mypage.license.channel.expire.1"/> : ${contactPoint.expireDate}</li>
                                    <span style="color: red"> <uengine:message code="mypage.license.channel.expired"/> </span>
                                </c:when>
                            </c:choose>
                        </ul>
                        <c:choose>
                            <c:when test="${contactPoint.contact == 'ADMIN'}">
                                <p>
                                    <uengine:message code="mypage.license.channel.product"/> : ${contactPoint.productName} &nbsp; ${contactPoint.productVersion}<br>
                                    <uengine:message code="mypage.license.channel.holder"/> : ${contactPoint.holder}<br>
                                    <uengine:message code="mypage.license.channel.buyer"/> : ${contactPoint.userEmail}<br>
                                    <uengine:message code="mypage.license.channel.admin.desc"/>
                                </p>

                                <div class="row">
                                    <div class="col-sm-3">
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.license.channel.reissue.server"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.reissue"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.license.channel.reissue.channel"/> </li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-3">
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.install_hadoop"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.install_flamingo2"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.license.channel.report.feature"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.license.channel.report.tracking"/> </li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-3">
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.refund"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_reseller"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_affiliates"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_promotional"/> </li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-3">
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_product"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_purchase"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_price"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_features"/> </li>
                                        </ul>
                                    </div>
                                </div>
                                <p><a class="btn-u btn-u-sm"
                                      href="/my/contact?identifier=${contactPoint.identifier}"><uengine:message code="mypage.contact.create"/> <i
                                            class="fa fa-angle-double-right margin-left-5"></i></a></p>
                            </c:when>
                            <c:when test="${contactPoint.contact == 'TECH'}">
                                <p>
                                    <uengine:message code="mypage.license.channel.product"/> : ${contactPoint.productName} &nbsp; ${contactPoint.productVersion}<br>
                                    <uengine:message code="mypage.license.channel.holder"/> : ${contactPoint.holder}<br>
                                    <uengine:message code="mypage.license.channel.buyer"/> : ${contactPoint.userEmail}<br>
                                    <uengine:message code="mypage.license.channel.tech.desc"/>
                                </p>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.install_hadoop"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.install_flamingo2"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.license.channel.report.feature"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.license.channel.report.tracking"/> </li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-4">
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_product"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_purchase"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_price"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_features"/> </li>
                                        </ul>
                                    </div>
                                </div>
                                <p><a class="btn-u btn-u-sm"
                                      href="/my/contact?identifier=${contactPoint.identifier}"><uengine:message code="mypage.contact.create"/> <i
                                            class="fa fa-angle-double-right margin-left-5"></i></a></p>
                            </c:when>
                            <c:when test="${contactPoint.contact == 'BILL'}">
                                <p>
                                    <uengine:message code="mypage.license.channel.product"/> : ${contactPoint.productName} &nbsp; ${contactPoint.productVersion}<br>
                                    <uengine:message code="mypage.license.channel.holder"/> : ${contactPoint.holder}<br>
                                    <uengine:message code="mypage.license.channel.buyer"/> : ${contactPoint.userEmail}<br>
                                    <uengine:message code="mypage.license.channel.bill.desc"/>
                                </p>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.refund"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_reseller"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_affiliates"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_promotional"/> </li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-4">
                                        <ul class="list-unstyled">
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_product"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_purchase"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_price"/> </li>
                                            <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_features"/> </li>
                                        </ul>
                                    </div>
                                </div>
                                <p><a class="btn-u btn-u-sm"
                                      href="/my/contact?identifier=${contactPoint.identifier}"><uengine:message code="mypage.contact.create"/> <i
                                            class="fa fa-angle-double-right margin-left-5"></i></a></p>
                            </c:when>
                        </c:choose>
                    </div>
                </c:forEach>

                <div class="row blog blog-medium margin-bottom-40" style="padding-left: 20px; padding-right: 20px;">
                    <h4>
                        <a>
                            <uengine:message code="mypage.license.channel.general"/>
                        </a>
                    </h4>
                    <p>
                        <uengine:message code="mypage.license.channel.general.desc"/>
                    </p>
                    <div class="row">
                        <div class="col-sm-4">
                            <ul class="list-unstyled">
                                <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_reseller"/> </li>
                                <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_affiliates"/> </li>
                                <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.business_promotional"/> </li>
                            </ul>
                        </div>
                        <div class="col-sm-4">
                            <ul class="list-unstyled">
                                <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_product"/> </li>
                                <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_purchase"/> </li>
                                <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_price"/> </li>
                                <li><i class="fa fa-check color-green"></i> <uengine:message code="mypage.contact.field.contact.about_features"/> </li>
                            </ul>
                        </div>
                    </div>
                    <p><a class="btn-u btn-u-sm" href="/my/contact"> <uengine:message code="mypage.contact.create"/> <i
                            class="fa fa-angle-double-right margin-left-5"></i></a></p>
                </div>
            </div>
            <!-- End Profile Content -->

            <%--인보이스 다운로드 폼--%>
            <form method="post" action="/license/invoice" id="invoiceForm" style="display: none">
                <input type="hidden" name="identifier"/>
            </form>
            <%--서버아이디 등록 이동 폼--%>
            <form method="post" action="/license/server" id="serverForm" style="display: none">
                <input type="hidden" name="identifier"/>
            </form>
        </div>
        <!--/end row-->
    </div>
    <!--=== End Profile ===-->

    <%@include file="../template/footer.jsp" %>
</div>
<!--/wrapper-->

<%@include file="../template/footer_js.jsp" %>
<script type="text/javascript" src="/resources/js/license.js"></script>

</html>
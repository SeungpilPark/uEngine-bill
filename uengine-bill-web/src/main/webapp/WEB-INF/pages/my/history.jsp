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
                <script type="text/javascript">$('[name=list-menu-history]').addClass('active');</script>
            </div>
            <!--End Left Sidebar-->

            <!-- Profile Content -->
            <div class="col-md-9">
                <h2><uengine:message code="mypage.history.title"/> </h2>

                <form action="/my/history" method="get" class="sky-form" id="historyForm">
                    <div>
                        <div class="col-md-2" style="padding-left: 0px;padding-right: 0px;">
                            <select name="status" class="form-control">
                                <option value="all" <c:if test="${status == 'all'}">selected="selected" </c:if>><uengine:message code="mypage.history.status.all"/> </option>
                                <option value="open" <c:if test="${status == 'open'}">selected="selected" </c:if>><uengine:message code="mypage.history.status.open"/> </option>
                                <option value="solved" <c:if test="${status == 'solved'}">selected="selected" </c:if>><uengine:message code="mypage.history.status.solved"/> </option>
                            </select>
                        </div>
                        <div class="col-md-2" style="padding-left: 0px;padding-right: 0px;">
                            <select name="order" class="form-control">
                                <option value="updated" <c:if test="${order == 'updated'}">selected="selected" </c:if>><uengine:message code="mypage.history.order.updated"/> </option>
                                <option value="created" <c:if test="${order == 'created'}">selected="selected" </c:if>><uengine:message code="mypage.history.order.created"/> </option>
                            </select>
                        </div>
                        <div class="col-md-4" style="padding-left: 0px;padding-right: 0px;">
                            <div class="row">
                                <section class="col-md-6" style="padding-right: 0px;">
                                    <label class="input">
                                        <i class="icon-append fa fa-calendar"></i>
                                        <input type="text" name="start" id="start" value="${start}" placeholder="<uengine:message code="mypage.history.start"/>">
                                    </label>
                                </section>
                                <section class="col-md-6" style="padding-left: 0px;">
                                    <label class="input">
                                        <i class="icon-append fa fa-calendar"></i>
                                        <input type="text" name="finish" id="finish" value="${finish}" placeholder="<uengine:message code="mypage.history.finish"/>">
                                    </label>
                                </section>
                            </div>
                        </div>
                        <div class="col-md-4" style="padding-left: 0px;padding-right: 0px;">
                            <div class="input-group">
                                <input type="hidden" name="subject" value="${subject}">
                                <input name="_subject" type="text" class="form-control" value="${subject}"
                                       placeholder="<uengine:message code="mypage.history.subject"/>">
                                <span class="input-group-btn">
                                    <button class="btn-u" type="button" id="submitBtn"><i class="fa fa-search"> <uengine:message code="mypage.history.search"/></i>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="per_page" value=${per_page}>
                    <input type="hidden" name="page" value=${page}>
                </form>

                <!-- Contact Type Value 를 텍스트로 바꾸기 위한 셀렉트 창 -->
                <select name="contactType" class="form-control" style="display: none">
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


                <!-- Begin Table Search v1 -->
                <div class="margin-bottom-10">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th><uengine:message code="mypage.history.tb.priority"/> </th>
                                <th><uengine:message code="mypage.history.tb.type"/></th>
                                <th><uengine:message code="mypage.history.tb.subject"/></th>
                                <th><uengine:message code="mypage.history.tb.created"/></th>
                                <th><uengine:message code="mypage.history.tb.updated"/></th>
                                <th><uengine:message code="mypage.history.tb.opend"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${ticketHistories}" var="ticketHistory" varStatus="status">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ticketHistory.priority == 0}">
                                                <ul class="list-inline star-vote">
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star-o"></i></li>
                                                    <li><i class="color-green fa fa-star-o"></i></li>
                                                    <li><i class="color-green fa fa-star-o"></i></li>
                                                </ul>
                                            </c:when>
                                            <c:when test="${ticketHistory.priority == 1}">
                                                <ul class="list-inline star-vote">
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star-o"></i></li>
                                                    <li><i class="color-green fa fa-star-o"></i></li>
                                                </ul>
                                            </c:when>
                                            <c:when test="${ticketHistory.priority == 2}">
                                                <ul class="list-inline star-vote">
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star-o"></i></li>
                                                </ul>
                                            </c:when>
                                            <c:when test="${ticketHistory.priority == 3}">
                                                <ul class="list-inline star-vote">
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                    <li><i class="color-green fa fa-star"></i></li>
                                                </ul>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td name="contactTypetd">${ticketHistory.contactType}</td>
                                    <td class="td-width">
                                        <form action="/my/history/ticket" method="get">
                                            <input type="hidden" name="ticketId" value="${ticketHistory.ticketId}">
                                            <a style="cursor:pointer;" name="ticketIdTag">${ticketHistory.subject}</a>
                                        </form>
                                    </td>
                                    <td>
                                            ${ticketHistory.createdAt}
                                    </td>
                                    <td>
                                            ${ticketHistory.updatedAt}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ticketHistory.status == 'open'}">
                                                <div style="color: darkred">NO</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div style="color:darkblue">YES</div>
                                            </c:otherwise>
                                        </c:choose>

                                    </td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- End Table Search v1 -->

                <ul id="pagination"></ul>

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
<script type="text/javascript" src="/resources/plugins/paging/jquery.twbsPagination.min.js"></script>
<script type="text/javascript">
    $(function () {
        var form = $('#historyForm');

        function cal(t1, t2) {
            var s1 = parseInt(t1 / t2);
            var s2 = parseInt(t1 % t2);
            return [s1 , s2];
        }
        var pages = cal(${count}, 10)[0];
        var lastRows = cal(${count}, 10)[1];
        if(lastRows > 0) pages = pages + 1;

        $('#pagination').twbsPagination({
            totalPages: pages,
            visiblePages: 7,
            startPage: ${page},
            onPageClick: function (event, page) {
                form.find('[name=page]').val(page);
                var subject = form.find('[name=_subject]').val();
                form.find('[name=subject]').val(encodeURIComponent(subject));
                blockSubmitStart();
                form.submit();
            }
        });


        Datepicker.initDatepicker();
        var contactSelect = $('[name=contactType]');

        $('[name=contactTypetd]').each(function(){
            var td = $(this);
            if(td.text().length > 0){
                td.text(contactSelect.find('option[value='+td.text()+']').text());
            }
        });

        $('#submitBtn').click(function(){
            var subject = form.find('[name=_subject]').val();
            form.find('[name=subject]').val(encodeURIComponent(subject));
            blockSubmitStart();
            form.submit();
        });

        $('[name=ticketIdTag]').click(function(){
            $(this).parent().submit();
        });
    })
</script>

</html>
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
                <h2>${ticketSubject}</h2>

                <c:choose>
                    <c:when test="${zendeskAdmin}">
                        <h4 style="color: #ff0000"><uengine:message code="mypage.ticket.invalid.admin"/> </h4>
                    </c:when>
                    <c:when test="${failed}">
                        <h4 style="color: #ff0000"><uengine:message code="mypage.ticket.invalid.error"/> </h4>
                    </c:when>
                </c:choose>

                <form action="/my/history/comment?${_csrf.parameterName}=${_csrf.token}" class="form-horizontal" role="form" id="commentForm" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="ticketId" value="${ticketId}">
                    <input type="hidden" name="ticketSubject" value="${ticketSubject}">
                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.ticket.form.contents"/> <span class="color-red">*</span></label>

                        <div class="col-lg-9">
                            <textarea rows="8" name="contents" class="form-control"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-2 control-label"><uengine:message code="mypage.ticket.form.attachments"/> <span class="color-red">*</span></label>

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
                            <button id="submitBtn" type="submit" class="btn-u btn-u-primary"><uengine:message code="mypage.ticket.form.send"/> </button>
                        </div>
                    </div>

                </form>

                <hr>

                <c:forEach items="${comments}" var="comment" varStatus="status">
                    <div class="inner-results">
                        <c:choose>
                            <c:when test="${comment.authorType == 'REQUESTER'}">
                                <div class="btn-u btn-u-default"><uengine:message code="mypage.ticket.list.request"/> </div>
                            </c:when>
                            <c:when test="${comment.authorType == 'ADMIN'}">
                                <div class="btn-u btn-u-dark-blue"><uengine:message code="mypage.ticket.list.answer"/> </div>
                            </c:when>
                        </c:choose>
                        <ul class="list-inline up-ul">
                            <li>${comment.authorEmail}</li>
                            <li>${comment.createAtFormat}</li>
                            <li class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                    <uengine:message code="mypage.ticket.list.more"/> <i class="fa fa-caret-down margin-left-5"></i>
                                    <span class="sr-only">Toggle Dropdown</span>
                                </button>
                                <ul role="menu" class="dropdown-menu">
                                    <li><a href="#"><uengine:message code="mypage.ticket.list.share"/> </a></li>
                                    <li><a href="#"><uengine:message code="mypage.ticket.list.search"/> </a></li>
                                </ul>
                            </li>
                        </ul>
                        <p>${comment.body}</p>

                        <c:forEach items="${comment.attachments}" var="attachment" varStatus="status">
                            <ul class="list-inline down-ul">
                                <li><i class="fa fa-cloud-download"></i> <a style="color: darkblue" target="_blank" href="${attachment.contentUrl}">${attachment.fileName}</a></li>
                                <li name="sizeTag">${attachment.size}</li>
                            </ul>
                        </c:forEach>
                    </div>

                    <hr>

                </c:forEach>

                <button id="goBack" class="btn-u btn-u-primary pull-right"><uengine:message code="mypage.ticket.list.back"/> </button>
            </div>
            <!-- End Profile Content -->

        </div>
        <!--/end row-->
    </div>
    <!--=== End Profile ===-->

    <%@include file="../template/footer.jsp" %>
</div>
<script type="text/javascript">
    $(function () {
        $('[name=sizeTag]').each(function(){
            var size = parseInt($(this).text());
            $(this).text(parseInt(size / 1000) + ' KB');
        })

        $('#goBack').click(function(){
            window.history.back();
        });

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
        var form = $('#commentForm');

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
                contents: {
                    required: "<span style='color: red;'>필수 항목입니다.</span>"
                },
                file0 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file1 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file2 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file3 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file4 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file5 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file6 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file7 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file8 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" },
                file9 : { qnafile: "<span style='color: red;'>첨부할 수 없는 파일입니다.</span>" }
            },
            invalidHandler: function() {
                blockStop();
            }
        });
    })
</script>
<!--/wrapper-->

<%@include file="../template/footer_js.jsp" %>


</html>
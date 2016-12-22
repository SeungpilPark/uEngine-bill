<%@ page import="org.uengine.garuda.util.ApplicationContextRegistry" %>
<%@ page import="org.uengine.garuda.util.NetworkUtils" %>
<%@ page import="org.uengine.garuda.model.User" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.context.i18n.LocaleContextHolder" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<!-- Meta -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- 타이틀 -->
<meta name="title" content="uengine Inc"/>
<!-- 주제 -->
<meta name="subject" content="uEngine Billing"/>
<!-- 요약 설명 -->
<meta name="description" content="서브스크립션 빌링 플랫폼">
<!-- 검색 키워드 -->
<meta name="keywords" content="Platform,Billing,Subscription,Payment,addon"/>
<!-- 웹 페이지(사이트) © Copyright 저작권 -->
<meta name="copyright" content="uengine Inc"/>
<!-- 웹 페이지(사이트) 검색사이트 검색로봇의 접근 허용 -->
<meta name="robots" content="ALL"/>
<!-- 웹 페이지(사이트) 내의 링크를 포함한 검색(수집) 허용 -->
<meta name="robots" content="INDEX,FOLLOW"/>
<!-- 웹 페이지(사이트) 캐쉬(Cache) 미저장 -->
<meta http-equiv="cache-control" content="No-Cache"/>
<meta http-equiv="pragma" content="No-Cache"/>
<meta http-equiv="expires" content="MON, 01 apr 2002 00:00:01 GMT">
<meta name="Location" content="South Korea"/>
<meta name="Distribution" content="Global"/>
<meta name="author" content="Seungpil, Park">

<!-- Summer Note -->
<link href="/resources/css/plugins/summernote/summernote.css" rel="stylesheet">
<link href="/resources/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">

<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">

<link href="/resources/css/plugins/iCheck/custom.css" rel="stylesheet">

<link href="/resources/css/plugins/chosen/bootstrap-chosen.css" rel="stylesheet">

<!-- Toastr style -->
<link href="/resources/css/plugins/toastr/toastr.min.css" rel="stylesheet">

<!-- Gritter -->
<link href="/resources/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

<!-- Data Picker -->
<link href="/resources/css/plugins/datapicker/datepicker3.css" rel="stylesheet">

<link href="/resources/css/animate.css" rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<link href="/resources/css/custom.css" rel="stylesheet">

<link href="/resources/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">

<!-- Spring JS -->
<script type="text/javascript" th:src="@{/resources/spring/Spring.js}"></script>
<script type="text/javascript" th:src="@{/resources/spring/Spring-Dojo.js}"></script>

<!-- Jquery -->
<script src="/resources/js/jquery-2.1.1.js"></script>

<!-- _csrf -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- AJAX_csrf 오버라이드 && 더블 submit 방지-->
<script type="text/javascript">
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function (e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
    $(function () {
        $('form').each(function () {
            var form = $(this);
            form.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>');
            if (form.find('[type=submit]').length > 0) {
                form.submit(function () {
                    blockSubmitStart();
                });
            }
        });
    })
</script>

<!-- config && message -->
<script type="text/javascript" src="/config/js.json"></script>
<script type="text/javascript">var lang = "${lang}";
lang = (lang.length > 0) ? lang : config['default.locale'];</script>
<script type="text/javascript" src="/resources/js/bundle.js"></script>

<!-- session -->
<%
    User user = (User) session.getAttribute("user");
    //String ipAddress = NetworkUtils.getIpAddr(request);

    //해당 세션의 첫 접속인경우, ISOCode 와 언어가 일치하지 않을 경우 맞는언어페이지로 리다이렉트.
//    if (session.getAttribute("ISOCode") == null) {
//        String ISOCode = NetworkUtils.getCountryCode(ipAddress);
//        session.setAttribute("ISOCode", ISOCode);
//        String localeByIpaddr = NetworkUtils.getLocaleFromISOCode(ISOCode);
//        Locale locale = LocaleContextHolder.getLocale();
//        if (!localeByIpaddr.equals(locale.toString()))
//            response.sendRedirect("/index?lang=" + localeByIpaddr);
//    }

%>
<script type="text/javascript">
    function isEmpty(str) {
        if (typeof str == 'string' && str.length > 0)return false;
        return true;
    }
    var SESSION = {};
    SESSION.ISOCode = !isEmpty('${ISOCode}') ? '${ISOCode}' : undefined;
    SESSION.ID = !isEmpty('${user._id}') ? '${user._id}' : undefined;
    SESSION.NAME = !isEmpty('${user.name}') ? '${user.name}' : undefined;
    SESSION.EMAIL = !isEmpty('${user.email}') ? '${user.email}' : undefined;
    SESSION.DESCRIPTION = !isEmpty('${user.description}') ? '${user.description}' : undefined;
    SESSION.LEVEL = !isEmpty('${user.level}') ? '${user.level}' : undefined;

</script>

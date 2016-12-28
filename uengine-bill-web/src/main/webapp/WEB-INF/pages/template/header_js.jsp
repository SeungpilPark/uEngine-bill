<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<!-- Meta -->

<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<!-- ajax 호출 UI 블락커 && 커스터마이징 -->
<script type="text/javascript" src="/resources/js/plugins/blockUI/blockUI.js"></script>
<script type="text/javascript" src="/resources/js/blockUIcustom.js"></script>

<!-- config && message -->
<script type="text/javascript" src="/config/js.json"></script>
<script type="text/javascript">
    var lang = config['default.locale'];
</script>
<script type="text/javascript" src="/resources/js/bundle.js"></script>

<!-- 더블 서브밋 방지 -->
<script type="text/javascript">
    $(function () {
        $('form').each(function () {
            var form = $(this);
            if (form.find('[type=submit]').length > 0) {
                form.submit(function () {
                    blockSubmitStart();
                });
            }
        });
    });
</script>
<!-- billing Api -->
<script type="text/javascript" src="/resources/js/billing-api.js"></script>
<script type="text/javascript">
    var uBilling = new uBilling('localhost', 8080);

    //로그인,회원가입 관련 페이지가 아닌 경우 토큰 밸리데이팅을 수행한다.
    var pathname = window.location.pathname;
    if (pathname.indexOf('/auth') != 0 && pathname.indexOf('/registe') != 0) {
        uBilling.validateToken()
                .fail(function () {
                    uBilling.logout();
                    window.location.href = '/auth/login';
                });
    }
</script>

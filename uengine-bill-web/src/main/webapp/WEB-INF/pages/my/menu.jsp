<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="headline margin-bottom-30"><h4><uengine:message code="mypage.menu.title"/> </h4></div>

<ul class="list-group sidebar-nav-v1 margin-bottom-40" id="sidebar-nav-1">
    <li class="list-group-item" name="list-menu-overview">
        <a href="/my/overview"><i class="fa fa-bar-chart-o"></i> <uengine:message code="mypage.menu.overview"/> </a>
    </li>
    <li class="list-group-item" name="list-menu-contact">
        <a href="/my/contact"><i class="fa fa-group"></i> <uengine:message code="mypage.menu.contact"/> </a>
    </li>
    <li class="list-group-item" name="list-menu-history">
        <a href="/my/history"><i class="fa fa-group"></i> <uengine:message code="mypage.menu.history"/> </a>
    </li>
    <li class="list-group-item" name="list-menu-download">
        <a href="/my/download"><i class="fa fa-cubes"></i> <uengine:message code="mypage.menu.download"/> </a>
    </li>
    <li class="list-group-item" name="list-menu-license">
        <a href="/my/license"><i class="fa fa-cubes"></i> <uengine:message code="mypage.menu.license"/> </a>
    </li>
    <li class="list-group-item" name="list-menu-setting">
        <a href="/my/setting"><i class="fa fa-cog"></i> <uengine:message code="mypage.menu.setting"/> </a>
    </li>
</ul>

<!--Notification-->
<div class="panel-heading-v2 overflow-h">
    <h2 class="heading-xs pull-left"><i class="fa fa-bell-o"></i> <uengine:message code="mypage.menu.tracking.title"/> </h2>
    <a href="#"><i class="fa fa-cog pull-right"></i></a>
</div>
<ul class="list-unstyled mCustomScrollbar margin-bottom-20" data-mcs-theme="minimal-dark">
    <li class="notification">
        <div class="overflow-h">
            <span><strong><uengine:message code="mypage.menu.tracking.upgrade"/> </strong></span>
            <span><a style="font-size: smaller" target="_blank" href="http://wiki.opencloudengine.org/dashboard.action">HDFS 브라우저 디렉토리 및 파일 속성 정보에 소유자 및 그룹 정보 추가</a></span>
            <small>Two minutes ago</small>
        </div>
    </li>
    <li class="notification">
        <div class="overflow-h">
            <span><strong><uengine:message code="mypage.menu.tracking.new"/> </strong></span>
            <span><a style="font-size: smaller" target="_blank" href="http://wiki.opencloudengine.org/dashboard.action">노드 장애 알람</a></span>
            <small>Today 18:25 pm</small>
        </div>
    </li>
    <li class="notification">
        <div class="overflow-h">
            <span><strong><uengine:message code="mypage.menu.tracking.bugfix"/> </strong></span>
            <span><a style="font-size: smaller" target="_blank" href="http://wiki.opencloudengine.org/dashboard.action">Audit Log 통계 조건 조회 버그</a></span>
            <small>Yesterday 1:07 pm</small>
        </div>
    </li>
    <li class="notification">
        <div class="overflow-h">
            <span><strong><uengine:message code="mypage.menu.tracking.bugfix"/> </strong></span>
            <span><a style="font-size: smaller" target="_blank" href="http://wiki.opencloudengine.org/dashboard.action">Audit Log Grid 조회조건 및 페이징 툴바 버그</a></span>
            <small>23/12 11:01 am</small>
        </div>
    </li>
    <li class="notification">
        <div class="overflow-h">
            <span><strong><uengine:message code="mypage.menu.tracking.new"/> </strong></span>
            <span><a style="font-size: smaller" target="_blank" href="http://wiki.opencloudengine.org/dashboard.action">라이센스 적용</a></span>
            <small>Yesterday 1:07 pm</small>
        </div>
    </li>
    <li class="notification">
        <div class="overflow-h">
            <span><strong><uengine:message code="mypage.menu.tracking.upgrade"/> </strong></span>
            <span><a style="font-size: smaller" target="_blank" href="http://wiki.opencloudengine.org/dashboard.action">로그인한 사용자 계정에 해당하는 Audit Log 정보가 나오지 않고 모든 계정의 정보가 나옴</a></span>
            <small>23/12 15:15 pm</small>
        </div>
    </li>
</ul>
<button type="button" class="btn-u btn-u-default btn-u-sm btn-block"><uengine:message code="mypage.menu.tracking.viewmore"/> </button>
<!--End Notification-->
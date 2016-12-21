<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="headline margin-bottom-30"><h4>Management Console </h4></div>

<ul class="list-group sidebar-nav-v1 margin-bottom-40" id="sidebar-nav-1">
    <li class="list-group-item" name="list-menu-overview">
        <a href="/console/overview"><i class="fa fa-bar-chart-o"></i> Overview </a>
    </li>
    <li class="list-group-item" name="list-menu-user">
        <a href="/console/user"><i class="fa fa-group"></i> Users </a>
    </li>
    <li class="list-group-item" name="list-menu-client">
        <a href="/console/client"><i class="fa fa-group"></i> Clients </a>
    </li>
    <li class="list-group-item" name="list-menu-scope">
        <a href="/console/scope"><i class="fa fa-cubes"></i> Scopes </a>
    </li>
    <li class="list-group-item" name="list-menu-custom-token">
        <a href="/console/custom/token/edit"><i class="fa fa-cubes"></i> Custom token issuance </a>
    </li>
</ul>
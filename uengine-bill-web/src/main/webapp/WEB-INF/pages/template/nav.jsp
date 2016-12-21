<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav metismenu" id="side-menu">
            <li class="nav-header">
                <div class="profile-element">
                    <span><img alt="image" class="img-circle" src="/resources/images/oce-logo.png"/></span>
                    <a href="/index"><span class="block m-t-xs"> <strong class="font-bold">uEngine
                        Billing</strong>
                             </span></a>
                </div>
            </li>
            <li name="list-menu-index">
                <a href="/index"><i class="fa fa-th-large"></i> <span class="nav-label">Dashboards</span></a>
            </li>
            <li name="list-menu-product">
                <a href="/product"><i class="fa fa-shopping-cart"></i> <span class="nav-label">Products</span></a>
            </li>
            <li name="list-menu-customer">
                <a href="/customer"><i class="fa fa-user"></i> <span class="nav-label">Customers</span></a>
            </li>
            <li name="list-menu-subscription">
                <a href="/subscription"><i class="fa fa-clock-o"></i> <span
                        class="nav-label">Subscriptions</span></a>
            </li>
            <li name="list-menu-invoice">
                <a href="/invoice"><i class="fa fa-file-text-o"></i> <span class="nav-label">Invoices</span></a>
            </li>
            <li name="list-menu-events">
                <a href="/events"><i class="fa fa-calendar-o"></i> <span class="nav-label">Events</span></a>
            </li>
            <li name="list-menu-report">
                <a href="/report"><i class="fa fa-line-chart"></i> <span class="nav-label">Reports</span></a>
            </li>
            <li name="list-menu-setting">
                <a href="#"><i class="fa fa-gear"></i> <span class="nav-label">Settings</span><span
                        class="fa arrow"></span></a>
                <ul class="nav nav-second-level collapse">
                    <li name="list-menu-setting-organization"><a href="/setting/organization">Organization Profile</a></li>
                    <li name="list-menu-setting-user"><a href="/setting/user">Users</a></li>
                    <li name="list-menu-setting-preference"><a href="/setting/preference">Preferences</a></li>
                    <li name="list-menu-setting-retry"><a href="/setting/retry">Retry Settings</a></li>
                    <li name="list-menu-setting-currencie"><a href="/setting/currencie">Currencies</a></li>
                    <li name="list-menu-setting-template"><a href="/setting/template">Templates</a></li>
                    <li name="list-menu-setting-hosted"><a href="/setting/hosted">Hosted Pages</a></li>
                    <li name="list-menu-setting-notification"><a href="/setting/notification">Email Notifications</a></li>
                    <li name="list-menu-setting-reminder"><a href="/setting/reminder">Reminders</a></li>
                    <li name="list-menu-setting-integration"><a href="/setting/integration">Integrations</a></li>
                    <li name="list-menu-setting-webhook"><a href="/setting/webhook">Webhooks</a></li>
                </ul>
            </li>
            <li name="list-menu-apidoc">
                <a href="/apidoc"><i class="fa fa-gears"></i> <span class="nav-label">Api Docs</span></a>
            </li>
        </ul>

    </div>
</nav>
<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org"
      lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>uEngine Billing | HOME</title>

    <%@include file="../template/header_js.jsp" %>
</head>

<body>
<div id="wrapper">
    <%@include file="../template/nav.jsp" %>
    <script type="text/javascript">$('[name=list-menu-product]').addClass('active');</script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>
        <div class="row">
            <div class="col-md-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>All Products</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">All Products</a>
                                </li>
                                <li><a href="#">Active Products</a>
                                </li>
                                <li><a href="#">Inactive Products</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Import Plans</a>
                                </li>
                                <li><a href="#">Import Addons</a>
                                </li>
                                <li><a href="#">Import Coupons</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Export Plans</a>
                                </li>
                                <li><a href="#">Export Addons</a>
                                </li>
                                <li><a href="#">Export Coupons</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">

                                <div class="feed-element">
                                    <div class="media-body ">
                                        <small class="pull-right text-navy">14 active</small>
                                        <strong>FORCS BASIC</strong><br>
                                        <small class="text-muted">Created 4:21 pm - 12.06.2016</small>
                                        <div class="actions">
                                            <button type="button" class="btn btn-default btn-xs">3 Plans</button>
                                            <button type="button" class="btn btn-default btn-xs">6 Addons</button>
                                            <button type="button" class="btn btn-default btn-xs">1 Coupons</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="feed-element">
                                    <div class="media-body ">
                                        <small class="pull-right text-navy">14 active</small>
                                        <strong>FORCS PRO</strong><br>
                                        <small class="text-muted">Created 4:21 pm - 12.06.2016</small>
                                        <div class="actions">
                                            <button type="button" class="btn btn-default btn-xs">3 Plans</button>
                                            <button type="button" class="btn btn-default btn-xs">6 Addons</button>
                                            <button type="button" class="btn btn-default btn-xs">1 Coupons</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="feed-element">
                                    <div class="media-body ">
                                        <small class="pull-right text-navy">14 active</small>
                                        <strong>FORCS ENTERPRISE</strong><br>
                                        <small class="text-muted">Created 4:21 pm - 12.06.2016</small>
                                        <div class="actions">
                                            <button type="button" class="btn btn-default btn-xs">3 Plans</button>
                                            <button type="button" class="btn btn-default btn-xs">6 Addons</button>
                                            <button type="button" class="btn btn-default btn-xs">1 Coupons</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="feed-element">
                                    <div class="media-body ">
                                        <small class="pull-right text-navy">14 active</small>
                                        <strong>FORCS ENTERPRISE</strong><br>
                                        <small class="text-muted">Created 4:21 pm - 12.06.2016</small>
                                        <div class="actions">
                                            <button type="button" class="btn btn-default btn-xs">3 Plans</button>
                                            <button type="button" class="btn btn-default btn-xs">6 Addons</button>
                                            <button type="button" class="btn btn-default btn-xs">1 Coupons</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="feed-element">
                                    <div class="media-body ">
                                        <small class="pull-right text-navy">14 active</small>
                                        <strong>FORCS ENTERPRISE</strong><br>
                                        <small class="text-muted">Created 4:21 pm - 12.06.2016</small>
                                        <div class="actions">
                                            <button type="button" class="btn btn-default btn-xs">3 Plans</button>
                                            <button type="button" class="btn btn-default btn-xs">6 Addons</button>
                                            <button type="button" class="btn btn-default btn-xs">1 Coupons</button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <button class="btn btn-primary btn-block m"><i class="fa fa-arrow-down"></i> Show More</button>

                        </div>

                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>FORCS BASIC</h5>
                        <div class="ibox-tools">
                            <button type="button" class="btn btn-default btn-sm">Edit</button>
                            <button type="button" class="btn btn-default btn-sm">Add plan</button>
                            <button type="button" class="btn btn-default btn-sm">Add Addon</button>
                            <button type="button" class="btn btn-default btn-sm">Add Coupon</button>
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown" href="#">MORE</button>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">Associate Templates</a>
                                </li>
                                <li><a href="#">Mark as Inactive</a>
                                </li>
                                <li><a href="#">Delete</a>
                                </li>
                            </ul>

                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">

                                <div class="feed-element">
                                    <div class="media-body ">
                                        <div class="actions">
                                            <button type="button" class="btn btn-default btn-xs">3 Plans</button>
                                            <button type="button" class="btn btn-default btn-xs">6 Addons</button>
                                            <button type="button" class="btn btn-default btn-xs">1 Coupons</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Plans</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">
                                <div class="feed-element">
                                    <div class="media-body ">
                                        <div class="col-md-10">
                                            <small class="pull-right text-navy">3 activate</small>
                                            <strong>basic-monthly</strong><br>
                                            <p class="text-muted">Plan Code: basic-monthly</p>
                                            <br>
                                            <span>Associated Addons : <span class="text-navy">account-usage , storage-usage</span></span>
                                            <div class="actions">
                                                <button type="button" class="btn btn-default btn-xs">Edit</button>
                                                <button type="button" class="btn btn-default btn-xs">Mark as Inactive</button>
                                                <button type="button" class="btn btn-default btn-xs">Delete</button>
                                                <button type="button" class="btn btn-default btn-xs">View Plan URL</button>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <strong class="pull-right">$16.00</strong>
                                            <br>
                                            <p class="pull-right">per month</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="feed-element">
                                    <div class="media-body ">
                                        <div class="col-md-10">
                                            <small class="pull-right text-navy">3 activate</small>
                                            <strong>basic-monthly</strong><br>
                                            <p class="text-muted">Plan Code: basic-monthly</p>
                                            <br>
                                            <span>Associated Addons : <span class="text-navy">account-usage , storage-usage</span></span>
                                            <div class="actions">
                                                <button type="button" class="btn btn-default btn-xs">Edit</button>
                                                <button type="button" class="btn btn-default btn-xs">Mark as Inactive</button>
                                                <button type="button" class="btn btn-default btn-xs">Delete</button>
                                                <button type="button" class="btn btn-default btn-xs">View Plan URL</button>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <strong class="pull-right">$16.00</strong>
                                            <br>
                                            <p class="pull-right">per month</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>ADDONS</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">
                                <div class="feed-element">
                                    <div class="media-body ">
                                        <div class="col-md-9">
                                            <strong>account-usage</strong><br>
                                            <p class="text-muted">Addon Code: account-usage</p>
                                            <br>
                                            <span>Associated Plans : <span class="text-navy">basic-monthly</span></span>
                                            <div class="actions">
                                                <button type="button" class="btn btn-default btn-xs">Edit</button>
                                                <button type="button" class="btn btn-default btn-xs">Mark as Inactive</button>
                                                <button type="button" class="btn btn-default btn-xs">Delete</button>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <strong class="pull-right">Price varies by <a class="text-navy">tier</a></strong>
                                            <br>
                                            <p class="pull-right">per month</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="feed-element">
                                    <div class="media-body ">
                                        <div class="col-md-9">
                                            <strong>account-usage</strong><br>
                                            <p class="text-muted">Addon Code: account-usage</p>
                                            <br>
                                            <span>Associated Plans : <span class="text-navy">basic-monthly</span></span>
                                            <div class="actions">
                                                <button type="button" class="btn btn-default btn-xs">Edit</button>
                                                <button type="button" class="btn btn-default btn-xs">Mark as Inactive</button>
                                                <button type="button" class="btn btn-default btn-xs">Delete</button>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <strong class="pull-right">Price varies by <a class="text-navy">tier</a></strong>
                                            <br>
                                            <p class="pull-right">per month</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>COUPONS</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">
                                <div class="feed-element">
                                    <div class="media-body ">
                                        <div class="col-md-9">
                                            <strong>basic-discount-coupon</strong><br>
                                            <p class="text-muted">Code: basic-discount-coupon</p>
                                            <br>
                                            <span>Valid Upto : <span class="text-navy">07 Jan 2017</span></span>
                                            <p>5 redemptions</p>
                                            <div class="actions">
                                                <button type="button" class="btn btn-default btn-xs">Show details</button>
                                                <button type="button" class="btn btn-default btn-xs">Mark as Inactive</button>
                                                <button type="button" class="btn btn-default btn-xs">Delete</button>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <strong class="pull-right">30%</strong>
                                            <br>
                                            <p class="pull-right">One Time</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>


        <%@include file="../template/footer.jsp" %>

    </div>
</div>
<%@include file="../template/footer_js.jsp" %>


<script>
    $(document).ready(function () {

    });
</script>
</body>
</html>

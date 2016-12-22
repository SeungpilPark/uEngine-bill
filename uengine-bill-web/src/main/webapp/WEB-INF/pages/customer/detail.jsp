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
    <script type="text/javascript">$('[name=list-menu-customer]').addClass('active');</script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-md-4 padding-1">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Customers</h5>

                        <div class="ibox-tools">
                            <a href="./customer/new" type="button" class="btn btn-primary btn-sm">New +</a>
                            <a class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown" href="#"><i
                                    class="fa fa-bars"></i></a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">All</a>
                                </li>
                                <li><a href="#">Active</a>
                                </li>
                                <li><a href="#">Inactive</a>
                                </li>
                                <li><a href="#">None subscribers</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Import Customers</a>
                                </li>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Export Customers</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="fa fa-refresh"> Refresh list</i></a>
                                </li>
                            </ul>
                            <br>
                            <button type="button" class="btn btn-default btn-sm">Mark as Inactive</button>
                            <button type="button" class="btn btn-default btn-sm">Delete</button>
                            <button type="button" class="btn btn-default btn-sm">Enable Portal</button>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover dataTables-example">
                                <thead>
                                <tr>
                                    <th>NAME</th>
                                    <th>COMPANY NAME</th>
                                    <th>EMAIL</th>
                                    <th>WORK PHONE</th>
                                    <th>RECEIVABLES</th>
                                    <th>UNUSED CREDITS</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><input name="detail-check" type="checkbox"><a name="detail-click" href="#">
                                        darkgodarkgo</a></td>
                                    <td>uEngine</td>
                                    <td>darkgodarkgo@gmail.com</td>
                                    <td>+8201040341807</td>
                                    <td>$0.0</td>
                                    <td>$0.0</td>
                                </tr>
                                <tr>
                                    <td><input name="detail-check" type="checkbox"><a name="detail-click" href="#">
                                        China Customer</a></td>
                                    <td>China xx</td>
                                    <td>chyxxx@gmail.com</td>
                                    <td>+8201040341807</td>
                                    <td>CNY0.0</td>
                                    <td>CNY0.0</td>
                                </tr>
                                <tr>
                                    <td><input name="detail-check" type="checkbox"><a name="detail-click" href="#">
                                        darkgodarkgo</a></td>
                                    <td>uEngine</td>
                                    <td>darkgodarkgo@gmail.com</td>
                                    <td>+8201040341807</td>
                                    <td>$0.0</td>
                                    <td>$0.0</td>
                                </tr>
                                <tr>
                                    <td><input name="detail-check" type="checkbox"><a name="detail-click" href="#">
                                        China Customer</a></td>
                                    <td>China xx</td>
                                    <td>chyxxx@gmail.com</td>
                                    <td>+8201040341807</td>
                                    <td>CNY0.0</td>
                                    <td>CNY0.0</td>
                                </tr>
                                <tr>
                                    <td><input name="detail-check" type="checkbox"><a name="detail-click" href="#">
                                        darkgodarkgo</a></td>
                                    <td>uEngine</td>
                                    <td>darkgodarkgo@gmail.com</td>
                                    <td>+8201040341807</td>
                                    <td>$0.0</td>
                                    <td>$0.0</td>
                                </tr>
                                <tr>
                                    <td><input name="detail-check" type="checkbox"><a name="detail-click" href="#">
                                        China Customer</a></td>
                                    <td>China xx</td>
                                    <td>chyxxx@gmail.com</td>
                                    <td>+8201040341807</td>
                                    <td>CNY0.0</td>
                                    <td>CNY0.0</td>
                                </tr>
                                <tr>
                                    <td><input name="detail-check" type="checkbox"><a name="detail-click" href="#">
                                        darkgodarkgo</a></td>
                                    <td>uEngine</td>
                                    <td>darkgodarkgo@gmail.com</td>
                                    <td>+8201040341807</td>
                                    <td>$0.0</td>
                                    <td>$0.0</td>
                                </tr>
                                <tr>
                                    <td><input name="detail-check" type="checkbox"><a name="detail-click" href="#">
                                        China Customer</a></td>
                                    <td>China xx</td>
                                    <td>chyxxx@gmail.com</td>
                                    <td>+8201040341807</td>
                                    <td>CNY0.0</td>
                                    <td>CNY0.0</td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>NAME</th>
                                    <th>COMPANY NAME</th>
                                    <th>EMAIL</th>
                                    <th>WORK PHONE</th>
                                    <th>RECEIVABLES</th>
                                    <th>UNUSED CREDITS</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8 padding-1 detailPage" name="refundDetail">
                <%@include file="../subpages/refundDetail.jsp" %>
            </div>
            <div class="col-md-8 padding-1 detailPage" name="creditDetail">
                <%@include file="../subpages/creditDetail.jsp" %>
            </div>
            <div class="col-md-8 padding-1 detailPage" name="paymentDetail">
                <%@include file="../subpages/paymentDetail.jsp" %>
            </div>
            <div class="col-md-8 padding-1 detailPage" name="invoiceDetail">
                <%@include file="../subpages/invoiceDetail.jsp" %>
            </div>
            <div class="col-md-8 padding-1 detailPage" name="customerDetail">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span><h5>darkgodarkgo</h5> <span class="label label-success">USD</span></span>

                        <div class="ibox-tools">
                            <button type="button" class="btn btn-default btn-sm">Edit</button>
                            <a href="../subscription/new" type="button" class="btn btn-success btn-sm">New Subscription</a>
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown"
                                    href="#">MORE
                            </button>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">Add Credit</a>
                                </li>
                                <li><a href="#">Reduce Credit</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Add New Card</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Configure Client Portal</a>
                                </li>
                                <li><a href="#">Associate Templates</a>
                                </li>
                                <li><a href="#">Stop all Reminders</a>
                                </li>
                                <li><a href="#">Mark as Inactive</a>
                                </li>
                                <li><a href="#">Request Payment Method</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="tabs-container">
                            <ul class="nav nav-tabs">
                                <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">Overview</a>
                                </li>
                                <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">Transactions</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active">
                                    <div class="panel-body">
                                        <div class="col-md-4">
                                            <div class="feed-activity-list">
                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <span><i class="fa fa-user"></i> darkgodarkgo</span><br>
                                                        <a><i class="fa fa-envelope-o"></i>
                                                            sppark@uengine.org</a><br><br>

                                                        <h4>$-20.00</h4>
                                                        <strong class="text-warning">OUTSTANDING</strong>
                                                        <br>
                                                    </div>
                                                </div>

                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-1">
                                                            <i style="font-size: 20px;" class="fa fa-map-marker"></i>
                                                        </div>
                                                        <div class="col-md-10">
                                                            <strong>Billing Address</strong>
                                                            <br>
                                                            <span>inovally C dong</span><br>
                                                            <span>sungnam</span><br>
                                                            <span>AL 000-000</span><br>
                                                            <span>South Korea</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-1">
                                                            <i style="font-size: 20px;" class="fa fa-map-marker"></i>
                                                        </div>
                                                        <div class="col-md-10">
                                                            <strong>Shipping Address</strong>
                                                            <br>
                                                            <span>inovally C dong</span><br>
                                                            <span>sungnam</span><br>
                                                            <span>AL 000-000</span><br>
                                                            <span>South Korea</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-1">
                                                            <i style="font-size: 20px;" class="fa fa-user"></i>
                                                        </div>
                                                        <div class="col-md-10">
                                                            <strong>Contact Persons</strong>
                                                            <br>
                                                            <span>There are no additional contact persons found.</span><br>
                                                            <a>+ Add Contact Person</a>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-1">
                                                            <i style="font-size: 20px;" class="fa fa-credit-card"></i>
                                                        </div>
                                                        <div class="col-md-10">
                                                            <strong>PayPal Account Details</strong>
                                                            <br>
                                                            <span>darkgodarkgo-buyer@gmail.com</span><br>
                                                            <span class="text-muted">Gateway : Payments Pro</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="panel panel-info">
                                                    <div class="panel-heading">
                                                        <i class="fa fa-info-circle"></i> Info Panel
                                                    </div>
                                                    <div class="panel-body">
                                                        <span>Client Portal allows your customers to keep track of all the transactions between them and your business.<a
                                                                href="#">Learn More</a></span>
                                                        <button type="button" class="btn btn-default btn-sm">Enable
                                                            Portal
                                                        </button>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <h3>Subscriptions</h3>

                                            <div class="feed-activity-list">
                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-6">
                                                            <a>basic-monthly</a><br>
                                                            <span class="text-muted">FORCS BASIC</span><br><br>
                                                            <span class="text-muted">Subscription ID : 188677000000108037</span><br>
                                                            <span class="text-muted">Status : </span><span
                                                                class="text-success">live</span><br>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <h4>$16.80</h4>
                                                            <span class="text-muted">Last Billing Date : 20 Dec 2016</span>
                                                            <span class="text-muted">Next Billing Date : 20 Jan 2017</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-6">
                                                            <a>basic-monthly</a><br>
                                                            <span class="text-muted">FORCS BASIC</span><br><br>
                                                            <span class="text-muted">Subscription ID : 188677000000108037</span><br>
                                                            <span class="text-muted">Status : </span><span
                                                                class="text-success">live</span><br>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <h4>$16.80</h4>
                                                            <span class="text-muted">Last Billing Date : 20 Dec 2016</span>
                                                            <span class="text-muted">Next Billing Date : 20 Jan 2017</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <br><br>

                                            <div id="vertical-timeline"
                                                 class="vertical-container light-timeline no-margins">
                                                <div class="vertical-timeline-block">
                                                    <div class="vertical-timeline-icon navy-bg">
                                                        <i class="fa fa-bank"></i>
                                                    </div>

                                                    <div class="vertical-timeline-content">
                                                        <span>Automated payment reminder enabled</span><br>
                                                        <span class="text-muted">by Seungpil Park</span><br>
                                                        <span class="text-muted">20 Dec 2016 07:37 PM</span>
                                                    </div>
                                                </div>
                                                <div class="vertical-timeline-block">
                                                    <div class="vertical-timeline-icon navy-bg">
                                                        <i class="fa fa-bank"></i>
                                                    </div>

                                                    <div class="vertical-timeline-content">
                                                        <span>Subscription - FORCS BASIC-basic-monthly has been charged</span><br>
                                                        <span class="text-muted">by Seungpil Park</span><br>
                                                        <span class="text-muted">20 Dec 2016 07:37 PM</span>
                                                    </div>
                                                </div>
                                                <div class="vertical-timeline-block">
                                                    <div class="vertical-timeline-icon navy-bg">
                                                        <i class="fa fa-bank"></i>
                                                    </div>

                                                    <div class="vertical-timeline-content">
                                                        <span>Payment of amount $80.00 received and applied for INV-000038</span><br>
                                                        <span class="text-muted">by Seungpil Park</span><br>
                                                        <span class="text-muted">20 Dec 2016 07:37 PM</span>
                                                    </div>
                                                </div>
                                                <div class="vertical-timeline-block">
                                                    <div class="vertical-timeline-icon navy-bg">
                                                        <i class="fa fa-bank"></i>
                                                    </div>

                                                    <div class="vertical-timeline-content">
                                                        <span>Invoice INV-000038 created from Subscription - FORCS BASIC-basic-monthly</span><br>
                                                        <span class="text-muted">by Seungpil Park</span><br>
                                                        <span class="text-muted">20 Dec 2016 07:37 PM</span>
                                                    </div>
                                                </div>
                                                <div class="vertical-timeline-block">
                                                    <div class="vertical-timeline-icon navy-bg">
                                                        <i class="fa fa-bank"></i>
                                                    </div>

                                                    <div class="vertical-timeline-content">
                                                        <span>Payment of amount $16.80 received and applied for INV-000037</span><br>
                                                        <span class="text-muted">by Seungpil Park</span><br>
                                                        <span class="text-muted">20 Dec 2016 07:37 PM</span>
                                                    </div>
                                                </div>
                                                <div class="vertical-timeline-block">
                                                    <div class="vertical-timeline-icon navy-bg">
                                                        <i class="fa fa-bank"></i>
                                                    </div>

                                                    <div class="vertical-timeline-content">
                                                        <span>Subscription has been created for the Plan - FORCS BASIC-basic-monthly</span><br>
                                                        <span class="text-muted">by Seungpil Park</span><br>
                                                        <span class="text-muted">20 Dec 2016 07:37 PM</span>
                                                    </div>
                                                </div>
                                                <div class="vertical-timeline-block">
                                                    <div class="vertical-timeline-icon navy-bg">
                                                        <i class="fa fa-bank"></i>
                                                    </div>

                                                    <div class="vertical-timeline-content">
                                                        <span>Invoice INV-000037 created from Subscription - FORCS BASIC-basic-monthly</span><br>
                                                        <span class="text-muted">by Seungpil Park</span><br>
                                                        <span class="text-muted">20 Dec 2016 07:37 PM</span>
                                                    </div>
                                                </div>
                                                <div class="vertical-timeline-block">
                                                    <div class="vertical-timeline-icon navy-bg">
                                                        <i class="fa fa-bank"></i>
                                                    </div>

                                                    <div class="vertical-timeline-content">
                                                        <span>Customer created</span><br>
                                                        <span class="text-muted">by Seungpil Park</span><br>
                                                        <span class="text-muted">20 Dec 2016 07:37 PM</span>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div id="tab-2" class="tab-pane">
                                    <div class="panel-body">
                                        <div class="ibox float-e-margins">
                                            <div class="ibox-title">
                                                <div class="ibox-tools">
                                                    <a class="dropdown-toggle btn btn-default btn-sm"
                                                       style="color: black" data-toggle="dropdown" href="#">Filter By:
                                                        All Transactions</a>
                                                    <ul class="dropdown-menu dropdown-user">
                                                        <li><a href="#">All Transactions</a>
                                                        </li>
                                                        <li><a href="#">Invoices</a>
                                                        </li>
                                                        <li><a href="#">Payment</a>
                                                        </li>
                                                        <li><a href="#">Credit</a>
                                                        </li>
                                                        <li><a href="#">Refund</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="ibox-content">

                                                <div class="table-responsive">
                                                    <table class="table table-striped table-bordered table-hover dataTables-example">
                                                        <thead>
                                                        <tr>
                                                            <th>DATE</th>
                                                            <th>TYPE</th>
                                                            <th>REF-ID</th>
                                                            <th>AMOUNT</th>
                                                            <th>STATUS</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr name="transactionItem" data-type="refund">
                                                            <td>20 Dec 2016</td>
                                                            <td>Refund</td>
                                                            <td>CN-00007</td>
                                                            <td>$29.40</td>
                                                            <td class="text-info">Success</td>
                                                        </tr>
                                                        <tr name="transactionItem" data-type="credit">
                                                            <td>20 Dec 2016</td>
                                                            <td>Credit</td>
                                                            <td>CN-00007</td>
                                                            <td>$29.40</td>
                                                            <td class="text-info">Closed</td>
                                                        </tr>
                                                        <tr name="transactionItem" data-type="payment">
                                                            <td>20 Dec 2016</td>
                                                            <td>Payment</td>
                                                            <td>INV-000043</td>
                                                            <td>$203.40</td>
                                                            <td class="text-info">Success</td>
                                                        </tr>
                                                        <tr name="transactionItem" data-type="invoice">
                                                            <td>20 Dec 2016</td>
                                                            <td>Invoice</td>
                                                            <td>INV-000043</td>
                                                            <td>$203.40</td>
                                                            <td class="text-info">Paid</td>
                                                        </tr>
                                                        </tbody>
                                                        <tfoot>
                                                        <tr>
                                                            <th>DATE</th>
                                                            <th>TYPE</th>
                                                            <th>REF-ID</th>
                                                            <th>AMOUNT</th>
                                                            <th>STATUS</th>
                                                        </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </div>
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

<%@include file="../subpages/credit-email.jsp" %>
<%@include file="../subpages/invoice-email.jsp" %>

<script>
    $(document).ready(function () {
        var detailPages = $('.detailPage');
        var refundDetail = $('[name=refundDetail]');
        var creditDetail = $('[name=creditDetail]');
        var paymentDetail = $('[name=paymentDetail]');
        var invoiceDetail = $('[name=invoiceDetail]');
        var customerDetail = $('[name=customerDetail]');
        var goBack = $('[name=goBack]');
        detailPages.hide();
        customerDetail.show();

        $('.dataTables-example').DataTable({
            pageLength: 25,
            responsive: true,
            dom: '<"html5buttons"B>lTfgitp',
            buttons: []
        });

        $('[name=detail-check]').click(function (event) {
            event.stopPropagation();
        });
        $('[name=detail-click]').click(function (event) {
            event.stopPropagation();
        });

        $('[name=transactionItem]').click(function () {
            var item = $(this);
            var type = item.data('type');
            detailPages.hide();
            $('[name=' + type + 'Detail]').show();
        });

        goBack.click(function () {
            detailPages.hide();
            customerDetail.show();
        });

        $('[name=print-btn]').click(function () {
            var target = $(this).data('target-id');
            $('#' + target).print();
            //url:https://github.com/DoersGuild/jQuery.print
        });

        $('[name=email-btn]').click(function () {
            var target = $(this).data('target-id');
            $('#' + target).modal({
                show: true
            });
        });
    });

</script>
</body>
</html>

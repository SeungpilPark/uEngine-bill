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
    <script type="text/javascript">$('[name=list-menu-subscription]').addClass('active');</script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-md-4 padding-1">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Subscriptions</h5>

                        <div class="ibox-tools">
                            <a href="./customer/new" type="button" class="btn btn-primary btn-sm">New +</a>
                            <a class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown" href="#"><i
                                    class="fa fa-bars"></i></a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">All</a>
                                </li>
                                <li><a href="#">Active</a>
                                </li>
                                <li><a href="#">Trial</a>
                                </li>
                                <li><a href="#">Canceled This Month</a>
                                </li>
                                <li><a href="#">Canceled Last Month</a>
                                </li>
                                <li><a href="#">Dunning</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Export Subscriptions</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="fa fa-refresh"> Refresh list</i></a>
                                </li>
                            </ul>
                            <br>
                            <button type="button" class="btn btn-default btn-sm">Cancel Subscriptions</button>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover dataTables-example">
                                <thead>
                                <tr>
                                    <th>CUSTOMER NAME</th>
                                    <th>AMOUNT</th>
                                    <th>STATUS</th>
                                    <th>DATE</th>
                                    <th>EMAIL</th>
                                    <th>PLAN NAME</th>
                                    <th>ACTIVATED ON</th>
                                    <th>LAST BILLED ON</th>
                                    <th>NEXT BILLING ON</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><a>darkgodarkgo</a></td>
                                    <td>$33.92</td>
                                    <td class="text-success">LIVE</td>
                                    <td>20 Dec 2016</td>
                                    <td>sppark@uengine.org</td>
                                    <td>basic-monthly</td>
                                    <td>20 Dec 2016</td>
                                    <td>21 Dec 2016</td>
                                    <td>20 Jan 2017</td>
                                </tr>
                                <tr>
                                    <td><a>darkgodarkgo</a></td>
                                    <td>$33.92</td>
                                    <td class="text-success">LIVE</td>
                                    <td>20 Dec 2016</td>
                                    <td>sppark@uengine.org</td>
                                    <td>basic-monthly</td>
                                    <td>20 Dec 2016</td>
                                    <td>21 Dec 2016</td>
                                    <td>20 Jan 2017</td>
                                </tr>
                                <tr>
                                    <td><a>darkgodarkgo</a></td>
                                    <td>$33.92</td>
                                    <td class="text-success">LIVE</td>
                                    <td>20 Dec 2016</td>
                                    <td>sppark@uengine.org</td>
                                    <td>basic-monthly</td>
                                    <td>20 Dec 2016</td>
                                    <td>21 Dec 2016</td>
                                    <td>20 Jan 2017</td>
                                </tr>
                                <tr>
                                    <td><a>darkgodarkgo</a></td>
                                    <td>$33.92</td>
                                    <td class="text-success">LIVE</td>
                                    <td>20 Dec 2016</td>
                                    <td>sppark@uengine.org</td>
                                    <td>basic-monthly</td>
                                    <td>20 Dec 2016</td>
                                    <td>21 Dec 2016</td>
                                    <td>20 Jan 2017</td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>CUSTOMER NAME</th>
                                    <th>AMOUNT</th>
                                    <th>STATUS</th>
                                    <th>DATE</th>
                                    <th>EMAIL</th>
                                    <th>PLAN NAME</th>
                                    <th>ACTIVATED ON</th>
                                    <th>LAST BILLED ON</th>
                                    <th>NEXT BILLING ON</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8 padding-1">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">

                        <div class="text-muted">FORCS BASIC-basic-monthly (basic-monthly)</div>
                        <div>
                            <h5>unionnec2</h5> <span class="label label-success">LIVE</span>
                        </div>

                        <div class="ibox-tools">
                            <button type="button" class="btn btn-default btn-sm">Edit</button>
                            <button type="button" class="btn btn-default btn-sm">Update Paypal Account</button>
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown"
                                    href="#">MORE
                            </button>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">Add Coupon</a>
                                </li>
                                <li><a href="#">Add One Time Addon</a>
                                </li>
                                <li><a href="#">Add Charge</a>
                                </li>
                                <li><a href="#">Update Custom Fields</a>
                                </li>
                                <li><a href="#">Cancel Subscription</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Delete Subscription</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row" style="text-align: center">
                                    <div class="col-md-3 border-right">
                                        <h3>$33.92</h3>
                                        <span>1 month(s)</span>
                                    </div>
                                    <div class="col-md-3 border-right">
                                        <h3>20 Jan 2017</h3>
                                        <span>Next Billing Date</span><br>
                                        <a class="text-success">Change</a>
                                    </div>
                                    <div class="col-md-3 border-right">
                                        <h3>21 Dec 2016</h3>
                                        <span>Last Billing Date</span>
                                    </div>
                                    <div class="col-md-3">
                                        <h3>∞</h3>
                                        <span>renews forever</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h4>Emailed To</h4>
                        <span>sppark@uengine.org</span><br>
                        <a>Manage Contacts</a><br><br>

                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                <tr>
                                    <th>Plan & Addon Details</th>
                                    <th>Qty</th>
                                    <th>Discount</th>
                                    <th>Tax</th>
                                    <th>Rate</th>
                                    <th>Amount</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>basic-monthly</td>
                                    <td>2</td>
                                    <td>-</td>
                                    <td>US TAX (5%)</td>
                                    <td>$16.00</td>
                                    <td>$32.00</td>
                                </tr>
                                <tr>
                                    <td>account-usage</td>
                                    <td>1</td>
                                    <td>-</td>
                                    <td>US TAX (5%)</td>
                                    <td>$0.10</td>
                                    <td>$0.10</td>
                                </tr>
                                <tr>
                                    <td>storage-usage</td>
                                    <td>1</td>
                                    <td>-</td>
                                    <td>US TAX (5%)</td>
                                    <td>$0.20</td>
                                    <td>$0.20</td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th>TOTAL</th>
                                    <th>$33.92</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div class="hr-line-dashed"></div>

                        <div class="row">
                            <div class="col-md-4">
                                <h4>Payment Information</h4>
                                <div class="hr-line-solid"></div>

                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td class="text-muted">PayPal Account Associated</td>
                                        <td>darkgodarkgo-buyer@gmail.com</td>
                                    </tr>
                                    </tbody>
                                </table>

                                <a>Change to Offline Mode</a> | <a>Update Paypal Account</a>
                            </div>
                            <div class="col-md-8">
                                <h4>Subscription Options</h4>
                                <div class="hr-line-solid"></div>

                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td class="text-muted">Reference # </td>
                                        <td><a>Update</a></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Sales Person</td>
                                        <td><a>Update</a></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="hr-line-dashed"></div>

                        <h3>Recent Activities</h3>

                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th class="text-info">DATE</th>
                                    <th class="text-info">DESCRIPTION</th>
                                    <th class="text-info">BY</th>
                                </tr>
                                </thead>
                                <tr>
                                    <th class="tg-yw4l">21 Dec 2016 10:33 PM</th>
                                    <th class="tg-yw4l">Next billing date of the Subscription - FORCS BASIC-basic-monthly has been changed to - 20 Jan 2017</th>
                                    <th class="tg-yw4l">Seungpil Park</th>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 10:32 PM</td>
                                    <td class="tg-yw4l">Next billing date of the Subscription - FORCS BASIC-basic-monthly has been changed to - 22 Jan 2017</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 10:32 PM</td>
                                    <td class="tg-yw4l">Next billing date of the Subscription - FORCS BASIC-basic-monthly has been changed to - 20 Jan 2017</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 07:38 AM</td>
                                    <td class="tg-yw4l">Item description has been updated for the subscription - FORCS BASIC-basic-monthly</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 07:38 AM</td>
                                    <td class="tg-yw4l">Item description has been updated for the subscription - FORCS BASIC-basic-monthly</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 12:13 AM</td>
                                    <td class="tg-yw4l">Subscription has been updated</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 12:13 AM</td>
                                    <td class="tg-yw4l">Invoice created - INV-000046</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 12:13 AM</td>
                                    <td class="tg-yw4l">Subscription has been updated</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 12:13 AM</td>
                                    <td class="tg-yw4l">Invoice created - INV-000045</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 12:12 AM</td>
                                    <td class="tg-yw4l">Subscription has been updated</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 12:12 AM</td>
                                    <td class="tg-yw4l">Invoice created - INV-000044</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 12:11 AM</td>
                                    <td class="tg-yw4l">Subscription has been updated</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">21 Dec 2016 12:11 AM</td>
                                    <td class="tg-yw4l">Invoice created - INV-000043</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">20 Dec 2016 10:53 PM</td>
                                    <td class="tg-yw4l">Subscription has been updated</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">20 Dec 2016 10:53 PM</td>
                                    <td class="tg-yw4l">Invoice created - INV-000042</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">20 Dec 2016 10:47 PM</td>
                                    <td class="tg-yw4l">Subscription has been updated</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">20 Dec 2016 10:47 PM</td>
                                    <td class="tg-yw4l">Invoice created - INV-000041</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">20 Dec 2016 10:46 PM</td>
                                    <td class="tg-yw4l">Subscription has been updated</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">20 Dec 2016 10:46 PM</td>
                                    <td class="tg-yw4l">Invoice created - INV-000040</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">20 Dec 2016 09:47 PM</td>
                                    <td class="tg-yw4l">Subscription has been created for the Plan - basic-monthly</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                                <tr>
                                    <td class="tg-yw4l">20 Dec 2016 09:47 PM</td>
                                    <td class="tg-yw4l">Invoice created - INV-000039</td>
                                    <td class="tg-yw4l">Seungpil Park</td>
                                </tr>
                            </table>
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

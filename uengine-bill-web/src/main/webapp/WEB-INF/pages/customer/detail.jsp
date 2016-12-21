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
            <div class="col-md-4">
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
            <div class="col-md-8">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span><h5>darkgodarkgo</h5> <span class="label label-success">USD</span></span>

                        <div class="ibox-tools">
                            <button type="button" class="btn btn-default btn-sm">Edit</button>
                            <button type="button" class="btn btn-success btn-sm">New Subscription</button>
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
                                <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">Overview</a></li>
                                <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">Transactions</a></li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active">
                                    <div class="panel-body">
                                        <div class="col-md-4">
                                            <div class="feed-activity-list">
                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <span><i class="fa fa-user"></i> darkgodarkgo</span><br>
                                                        <a><i class="fa fa-envelope-o"></i> sppark@uengine.org</a><br><br>

                                                        <p class="text-muted">Addon Code: account-usage</p>
                                                        <br>
                                                        <span>Associated Plans : <span class="text-navy">basic-monthly</span></span>
                                                        <div class="actions">
                                                            <button type="button" class="btn btn-default btn-xs">Edit</button>
                                                            <button type="button" class="btn btn-default btn-xs">Mark as Inactive</button>
                                                            <button type="button" class="btn btn-default btn-xs">Delete</button>
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
                                        <div class="col-md-8">

                                        </div>
                                        <div class="form-group"><label class="col-sm-2 control-label">Currency</label>
                                            <div class="col-md-5">
                                                <select class="chosen-select">
                                                    <option value=""></option>
                                                    <option value="">AUD - Australian Dollar</option>
                                                    <option value="">CAD - Canadian Dollar</option>
                                                    <option value="">USD - US Dollar</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group"><label class="col-sm-2 control-label">Payment Terms</label>
                                            <div class="col-sm-5">
                                                <select class="chosen-select">
                                                    <option value="">NET 15</option>
                                                    <option value="">NET 30</option>
                                                    <option value="">NET 45</option>
                                                    <option value="">NET 60</option>
                                                    <option value="">Due end of next month</option>
                                                    <option value="">Due end of the month</option>
                                                    <option value="">Due on Receipt</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group"><label class="col-sm-2 control-label">Enable Portal</label>
                                            <div class="col-md-10">
                                                <div><label> <input type="checkbox" value=""> Allow portal access for this customer </label></div>
                                            </div>
                                        </div>

                                        <div class="form-group"><label class="col-sm-2 control-label">Bank Account</label>
                                            <div class="col-sm-10">
                                                <label> <input type="checkbox" value=""> Allow this customer to pay via his/her bank account. </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-2" class="tab-pane">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-sm-6 b-r">
                                                <h3 class="m-t-none m-b">BILLING ADDRESS</h3>
                                                <div class="form-group"><label class="col-sm-4 control-label">Street</label>

                                                    <div class="col-sm-8"><textarea rows="3" class="form-control" name=""></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">City</label>

                                                    <div class="col-sm-8"><input type="text" class="form-control" name="">
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">State</label>

                                                    <div class="col-sm-8"><input type="text" class="form-control" name="">
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">ZIP Code</label>

                                                    <div class="col-sm-8"><input type="text" class="form-control" name="">
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">Country</label>

                                                    <div class="col-sm-5">
                                                        <select class="chosen-select">
                                                            <option value="">South Korea</option>
                                                            <option value="">Japan</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">Fax</label>

                                                    <div class="col-sm-8"><input type="text" class="form-control" name="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <h3 class="m-t-none m-b">SHIPPING ADDRESS
                                                    <a style="font-size: 12px" class="pull-right"><i class="fa fa-download"> Copy Billing Address</i></a></h3>
                                                <div class="form-group"><label class="col-sm-4 control-label">Street</label>

                                                    <div class="col-sm-8"><textarea rows="3" class="form-control" name=""></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">City</label>

                                                    <div class="col-sm-8"><input type="text" class="form-control" name="">
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">State</label>

                                                    <div class="col-sm-8"><input type="text" class="form-control" name="">
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">ZIP Code</label>

                                                    <div class="col-sm-8"><input type="text" class="form-control" name="">
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">Country</label>

                                                    <div class="col-sm-5">
                                                        <select class="chosen-select">
                                                            <option value="">South Korea</option>
                                                            <option value="">Japan</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group"><label class="col-sm-4 control-label">Fax</label>

                                                    <div class="col-sm-8"><input type="text" class="form-control" name="">
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
        </div>

        <%@include file="../template/footer.jsp" %>

    </div>
</div>
<%@include file="../template/footer_js.jsp" %>


<script>
    $(document).ready(function () {
        $('.dataTables-example').DataTable({
            pageLength: 25,
            responsive: true,
            dom: '<"html5buttons"B>lTfgitp',
            buttons: []
        });
    });

    $('[name=detail-check]').click(function (event) {
        event.stopPropagation();
    });
    $('[name=detail-click]').click(function (event) {
        event.stopPropagation();
    });

</script>
</body>
</html>

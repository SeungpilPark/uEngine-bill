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
    <script type="text/javascript">$('[name=list-menu-index]').addClass('active');</script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New Customer</h5>
                    </div>
                    <div class="ibox-content">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-2 control-label">Primary Contact</label>

                                <div class="col-sm-3">
                                    <select class="chosen-select"
                                            tabindex="2">
                                        <option value="">Select</option>
                                        <option value="mr">Mr.</option>
                                        <option value="mrs">Mrs.</option>
                                        <option value="ms">Ms.</option>
                                        <option value="miss">Miss.</option>
                                        <option value="dr">Dr.</option>
                                    </select>
                                </div>
                                <div class="col-sm-3"><input type="text" class="form-control"
                                                             placeholder="First Name"></div>
                                <div class="col-sm-3"><input type="text" class="form-control"
                                                             placeholder="Last Name"></div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label">Company Name</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="">
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label">Cutomer Email</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="">
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label">Customer Display Name</label>

                                <div class="col-sm-10">
                                    <select data-placeholder="Salutation" class="chosen-select"
                                            tabindex="2">
                                        <option value=""></option>
                                        <option value="">Seungpil Park</option>
                                        <option value="">Park, Seungpil</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label">Customer Phone</label>

                                <div class="col-sm-5"><input type="text" class="form-control" name="" placeholder="Mobile">
                                </div>
                                <div class="col-sm-5"><input type="text" class="form-control" name="" placeholder="Work Phone">
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label">Website</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="">
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>

                            <div class="tabs-container">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">Other Details</a></li>
                                    <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">Address</a></li>
                                    <li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false">Custom Fields</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="panel-body">
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
                                    <div id="tab-3" class="tab-pane">
                                        <div class="panel-body">
                                            <div class="form-group"><label class="col-sm-2 control-label">Custom Field 1</label>

                                                <div class="col-sm-10"><input type="text" class="form-control" name="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <button class="btn btn-white" type="submit">Cancel</button>
                                    <button class="btn btn-primary" type="submit">Save changes</button>
                                </div>
                            </div>
                        </form>
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

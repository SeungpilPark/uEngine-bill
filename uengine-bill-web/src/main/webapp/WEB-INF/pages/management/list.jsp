<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html xmlns="http://www.w3.org/1999/xhtml"
      lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>OCE IAM | HOME</title>

    <%@include file="../template/header_js.jsp" %>

    <link rel="stylesheet" href="/resources/assets/plugins/sky-forms-pro/skyforms/css/sky-forms.css">
    <link rel="stylesheet" href="/resources/assets/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css">
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="/resources/assets/plugins/sky-forms-pro/skyforms/css/sky-forms-ie8.css"><![endif]-->

    <!-- CSS Page Style -->
    <link rel="stylesheet" href="/resources/assets/css/pages/page_faq1.css">
    <link rel="stylesheet" href="/resources/assets/css/pages/page_search_inner.css">

    <script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function search(table, searchValue) {
            if(event.keyCode == 13) {
                reload(table, searchValue);
            }
        };

        function reload(table, searchValue) {
            // limit and skip setting
            var tableAPI = table.api();
            var limit = tableAPI.settings()[0]._iDisplayLength
            var skip = tableAPI.settings()[0]._iDisplayStart;

            tableAPI.ajax.url('/management/list?limit=' + limit + '&skip=' + skip + '&userName=' + searchValue);
            tableAPI.ajax.reload();
        };

        $(document).ready(function() {
            var table = $('#managements').DataTable({
                serverSide: true,
                searching: false,
                ajax: {
                    url: '/management/list',
                    dataSrc: function(managements) {
                        // change init page setting (_iDisplayStart )
                        table.settings()[0]._iDisplayStart = managements.displayStart;

                        // make id edit href
                        for(var i = 0; i < managements.data.length; i++) {
                            managements.data[i].managementName = '<a href=/management/session?_id=' + managements.data[i]._id + '>' + managements.data[i].managementName + '</a>';
                            managements.data[i]._id = '<a href=/management/edit?_id=' + managements.data[i]._id + '>Edit</a>';
                        }
                        return managements.data;
                    }
                },
                columns: [
                    { data: 'managementName' },
                    { data: 'description' },
                    { data: '_id' }
                ]
            });

            // page event
            $('#managements').on('page.dt', function() {
                reload($('#managements').dataTable(), $('#customSearch').val().trim());

                // page length event
            }).on('length.dt', function() {
                reload($('#managements').dataTable(), $('#customSearch').val().trim());

            });
        });
    </script>
</head>


<div class="wrapper">
    <%@include file="../template/header.jsp" %>

    <!--=== Breadcrumbs ===-->
    <div class="breadcrumbs">
        <div class="container">
            <h1 class="pull-left">Management Group</h1>
            <ul class="pull-right breadcrumb">
                <li><a href="index.html">HOME</a></li>
                <li class="active">Management Group</li>
            </ul>
        </div>
    </div>
    <!--/breadcrumbs-->

    <!--=== Content Part ===-->

    <!-- Begin Table Search v1 -->
    <div class="container content profile">
        <div class="row">
            <div class="col-md-12">
                <a class="btn-u btn-u-primary" href="/management/new">Create Management</a>

                <br>
                <br>

                <div class="margin-bottom-10">
                    <div class="table-responsive">
                        <div style="float: right"> Search : <input type="text" id="customSearch" onKeyDown="javascript: search($('#managements').dataTable(), this.value)" /> </div>
                        <table id="managements" class="display table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>Management Group Name</th>
                                <th>Description</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--=== End Content Part ===-->

    <%@include file="../template/footer.jsp" %>
</div>
<!--/wrapper-->
<%@include file="../template/footer_js.jsp" %>

</html>

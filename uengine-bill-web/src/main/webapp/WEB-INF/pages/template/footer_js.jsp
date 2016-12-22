<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- ajax 호출 UI 블락커 && 커스터마이징 -->
<script type="text/javascript" src="/resources/js/plugins/blockUI/blockUI.js"></script>
<script type="text/javascript" src="/resources/js/blockUIcustom.js"></script>

<!-- Mainly scripts -->
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="/resources/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="/resources/js/plugins/dataTables/datatables.min.js"></script>

<!-- Chosen -->
<script src="/resources/js/plugins/chosen/chosen.jquery.js"></script>

<!-- Flot -->
<script src="/resources/js/plugins/flot/jquery.flot.js"></script>
<script src="/resources/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
<script src="/resources/js/plugins/flot/jquery.flot.spline.js"></script>
<script src="/resources/js/plugins/flot/jquery.flot.resize.js"></script>
<script src="/resources/js/plugins/flot/jquery.flot.pie.js"></script>
<script src="/resources/js/plugins/flot/jquery.flot.symbol.js"></script>
<script src="/resources/js/plugins/flot/jquery.flot.time.js"></script>


<!-- Peity -->
<script src="/resources/js/plugins/peity/jquery.peity.min.js"></script>
<script src="/resources/js/demo/peity-demo.js"></script>

<!-- Custom and plugin javascript -->
<script src="/resources/js/inspinia.js"></script>
<script src="/resources/js/plugins/pace/pace.min.js"></script>

<!-- jQuery UI -->
<script src="/resources/js/plugins/jquery-ui/jquery-ui.min.js"></script>

<!-- GITTER -->
<script src="/resources/js/plugins/gritter/jquery.gritter.min.js"></script>

<!-- Sparkline -->
<script src="/resources/js/plugins/sparkline/jquery.sparkline.min.js"></script>

<!-- Sparkline demo data  -->
<script src="/resources/js/demo/sparkline-demo.js"></script>

<!-- ChartJS-->
<script src="/resources/js/plugins/chartJs/Chart.min.js"></script>

<!-- Toastr -->
<script src="/resources/js/plugins/toastr/toastr.min.js"></script>

<!-- iCheck -->
<script src="/resources/js/plugins/iCheck/icheck.min.js"></script>

<!-- Print -->
<script src="/resources/js/plugins/print/print.js"></script>

<!-- SUMMERNOTE -->
<script src="/resources/js/plugins/summernote/summernote.min.js"></script>

<!-- Data picker -->
<script src="/resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>

<script>
    $(document).ready(function () {
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green'
        });

        $('.chosen-select').chosen({width: "100%"});

        $('.summernote').summernote();
    });
</script>
<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Forrest G. Choi
  Date: 15. 6. 15.
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>

<div id="passwordTab" class="profile-edit tab-pane fade">
    <h2 class="heading-md"><uengine:message code="mypage.password.msg"/></h2>

    <br>

    <form class="sky-form" id="editPassword" action="#" method="post">
        <dl class="dl-horizontal">
            <dt><uengine:message code="mypage.password.email"/></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-envelope"></i>
                        <input type="email"
                               placeholder="<uengine:message code="mypage.password.email"/>"
                               value="${profile.email}" style="background-color: lightgrey;"
                               disabled>
                        <input type="hidden" name="email" value="${profile.email}">
                        <b class="tooltip tooltip-bottom-right"><uengine:message
                                code="mypage.password.email.tooltip"/></b>
                    </label>
                </section>
            </dd>
            <dt><uengine:message code="mypage.password.password"/></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-lock"></i>
                        <input type="password" id="password" name="password"
                               placeholder="<uengine:message code="mypage.password.password.placeholder"/>">
                        <b class="tooltip tooltip-bottom-right"><uengine:message
                                code="mypage.password.password.tooltip"/></b>
                    </label>
                </section>
            </dd>
            <dt><uengine:message code="mypage.password.password.confirm"/></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-lock"></i>
                        <input type="password" name="confirmPassword"
                               placeholder="<uengine:message code="mypage.password.password.confirm"/>">
                        <b class="tooltip tooltip-bottom-right"><uengine:message
                                code="mypage.password.password.tooltip"/></b>
                    </label>
                </section>
            </dd>
        </dl>
        <br>
        <section>
            <label class="checkbox">
                <input type="checkbox" id="terms" name="checkRead"><i></i>
                <a href="#"><uengine:message code="mypage.password.confirm.check"/></a>
            </label>
        </section>
        <dd style="text-align: center;">
            <button id="changePasswdBtn" class="btn-u"><uengine:message code="mypage.save"/></button>
        </dd>
    </form>
</div>
<script type="text/javascript">
    $(function () {
        $.validator.addMethod('passwdConfirm', function (value, element, param) {
            var passinput = $('#editPassword').find('[name=password]');
            if (passinput.val() == value)
                return true;

            return false;
        });

        jQuery.validator.addMethod("alphanumeric", function (value, element) {
            return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
        });

        $('#editPassword').validate({

            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                password: {
                    required: true,
                    minlength: 8,
                    alphanumeric: true
                },
                confirmPassword: {
                    required: true,
                    passwdConfirm: true
                },
                checkRead: {
                    required: true
                }
            },
            messages: {
                password: {
                    required: message.msg('form.invalid.common'),
                    minlength: message.msg('form.invalid.passwd'),
                    alphanumeric: message.msg('form.invalid.passwd')
                },
                confirmPassword: {
                    required: message.msg('form.invalid.common'),
                    passwdConfirm: message.msg('form.invalid.confirm')
                },
                checkRead: {
                    required: message.msg('form.invalid.common')
                }
            },
            invalidHandler: function() {
                blockStop();
            },
            errorPlacement: function (error, element) {
                element.parent().after(error);
            },
            submitHandler: function (e) {
                var url = "/my/updatePasswd";

                $.ajax({
                    type: "post",
                    dataType: "json",
                    url: url,
                    data: $("#editPassword").serialize(),
                    success: function (result) {
                        resultFnc(result);
                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }
                });
            }
        });
    });
</script>
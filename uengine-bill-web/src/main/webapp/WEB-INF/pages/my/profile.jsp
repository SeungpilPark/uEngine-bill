<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<div id="profile" class="profile-edit tab-pane fade in active">
    <h2 class="heading-md"><uengine:message code="mypage.profile.msg"/></h2>

    <br>

    <form class="sky-form" id="editProfile" action="#" method="post">
        <dl class="dl-horizontal">
            <dt><strong><uengine:message code="mypage.profile.firstname"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.firstname"/>"
                               name="firstName" value="${profile.firstName}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.lastname"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.lastname"/>"
                               name="lastName" value="${profile.lastName}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.organization"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.organization"/>"
                               name="organization" value="${profile.organization}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.email"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="email"
                               placeholder="<uengine:message code="mypage.profile.email"/>"
                               name="email" value="${profile.email}" style="background-color: lightgrey;" disabled>
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.phone"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.phone"/>"
                               name="phone" value="${profile.phone}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.office.phone"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.office.phone"/>"
                               name="officePhone" value="${profile.officePhone}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.country"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <select name="country" class="form-control" disabled="disabled">
                            <%@include file="../template/countryList.jsp" %>
                        </select>
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.address1"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.address1"/>"
                               name="address1" value="${profile.address1}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.address2"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.address2"/>"
                               name="address2" value="${profile.address2}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.city"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.city"/>"
                               name="city" value="${profile.city}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.zip"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.zip"/>"
                               name="zip" value="${profile.zip}">
                    </label>
                </section>
            </dd>

            <dt><strong><uengine:message code="mypage.profile.state"/></strong></dt>
            <dd>
                <section>
                    <label class="input">
                        <i class="icon-append fa fa-pencil"></i>
                        <input type="text"
                               placeholder="<uengine:message code="mypage.profile.state"/>"
                               name="state" value="${profile.state}">
                    </label>
                </section>
            </dd>


        </dl>
        <dd style="text-align: center;">
            <input type="hidden" name="id" value="${profile.id}">
            <button id="submitBTN" class="btn-u"><uengine:message code="mypage.save"/></button>
        </dd>
    </form>
</div>

<!-- Small modal -->
<div id="msg" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">X</button>
                <br>
            </div>
            <div class="modal-body" style="text-align: center;"></div>
            <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {

        $("select[name=country]").val("${profile.country}");

        console.log($("#editProfile").serialize());
        $("#editProfile").validate({
            focusInvalid: false,
            ignore: "",
            rules: {
                firstName: "required",
                lastName: "required",
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                firstName: message.msg('form.invalid.common'),
                lastName: message.msg('form.invalid.common'),
                email: {
                    required: message.msg('form.invalid.common'),
                    email: message.msg('form.invalid.email')
                }
            },
            invalidHandler: function () {
                blockStop();
            },
            errorPlacement: function (error, element) {
                error.insertAfter(element.parent());
            },
            submitHandler: function (e) {
                var url = "/my/updateProfile";
                $.ajax({
                    type: "post",
                    dataType: "json",
                    url: url,
                    data: $("#editProfile").serialize(),
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
    function resultFnc(result) {
        if (result.success == true) {
            $("div.modal-body").text(message.msg('form.save.success'));
            $("#msg").modal();
        } else {
            $("div.modal-body").text(message.msg('form.save.fail'));
            $("#msg").modal();
        }
        $('label').removeClass("state-success");
    }

</script>
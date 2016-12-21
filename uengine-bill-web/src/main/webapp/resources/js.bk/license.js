var licenseController = {
    data: [],
    init: function () {
        for (var i = 0; i < this.data.length; i++) {
            var licenseMix = this.data[i];
            //licenseType "SUBSCRIPTION"
            //licenseType "TRIAL"
            $('#license_sample').parent().append(licenseController.generateLicenseElm(licenseMix , i));
        }
        if(this.data.length == 0){
            $('#noneLicense').show();
        }
    },

    generateLicenseElm: function (licenseMix , index) {
        var licensebar = $('#license_sample').clone();
        licensebar.attr('id', 'license_' + licenseMix.id);
        licensebar.css('display', 'block');

        licensebar.find('[name=collapseHandle]').attr('href', '#collapse-' + licenseMix.id);
        licensebar.find('[name=collapseTarget]').attr('id', 'collapse-' + licenseMix.id);

        for (var key in licenseMix) {
            licensebar.find('[name=' + key + ']').html(licenseMix[key]);
        }

        if (!licenseMix.serverId) {
            licensebar.find('[name=noneServerId]').show();
            licensebar.find('[name=serverIdTag]').data('identifier', licenseMix.identifier);
            licensebar.find('[name=serverIdTag]').click(function(){
                var identifier = $(this).data('identifier');
                $('#serverForm').find('[name=identifier]').val(identifier);
                $('#serverForm').submit();
            });
        }

        if (licenseMix.licenseKey) {
            licensebar.find('[name=haslicenseKey]').show();
        }


        if (licenseMix.status == 'EXPIRED') {

        } else {

        }

        if (licenseMix.identifier) {
            var invoiceBtn = licensebar.find('[name=invoiceBtn]');
            invoiceBtn.parent().show();
            invoiceBtn.data('identifier', licenseMix.identifier);
            invoiceBtn.click(function () {
                    var identifier = $(this).data('identifier');
                    $('#invoiceForm').find('[name=identifier]').val(identifier);
                    $('#invoiceForm').submit();
                }
            );
        }

        if(index == 0){
            licensebar.find('[name=collapseTarget]').addClass('in');
        }

        return licensebar;

    }
};

$(function () {
    var search = location.search;
    console.log(search);
    var data = {
        userId: SESSION.ID
    };
    $.ajax({
        type: "POST",
        url: "/license/getbyuser",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "text",
        async: false,
        success: function (response) {
            var res = JSON.parse(response);
            if (res.success) {
                licenseController.data = res.list;
                licenseController.init();
            }

        },
        error: function (request, status, errorThrown) {

        }
    });
})
var priceController = {
    productMix: [],
    interceptionList: [],
    init: function () {
        //SESSION.ISOCode
        $('[name=country]').val(SESSION.ISOCode);
        $('[name=country]').change(function () {
            priceController.setCurrentPrice();
        })
        $('[name=nodeNum]').change(function(){
            priceController.setCurrentPrice();
        });
        this.setCurrentPrice();

        $('#purchaseSubmit').click(function(){
           $('#pricingForm').submit();
        });

    },
    setCurrentPrice: function () {
        var nodeNum = $('[name=nodeNum]').val();
        var countryCode = $('[name=country]').val();

        $('[name=product_box]').each(function () {
            var box = $(this);
            var familyName = box.data('family');

            if(nodeNum == 0)
                box.find('[name=node_tag]').html('Unlimited ');
            else
                box.find('[name=node_tag]').html(' '+nodeNum);

            var price = priceController.getPrice(familyName, countryCode, nodeNum );
            if(price){
                if(box.data('display') == 'table')
                    box.find('[name=price_tag]').html('<i>$</i>'+price+'');
                else
                    box.find('[name=price_tag]').html('<i>$</i>'+price+'<i>.00</i>');
            }else{
                box.find('[name=price_tag]').html('<i>Not sale</i>');
            }

            //제한 국가 구매문의로 넘김
            var interception = false;
            var interceptionList = priceController.interceptionList;
            for (var i = 0; i < interceptionList.length; i++) {
                if (interceptionList[i].country == countryCode ){
                    interception = true;
                }
            }
            if(interception){
                $('[name=purchase_tag]').hide();$('[name=gotoContact]').show();
            }else{
                $('[name=purchase_tag]').show();$('[name=gotoContact]').hide();
            }
        });

    },
    getPrice: function (familyName, countryCode, nodeNum) {
        var defaultCountryItem = undefined;

        for (var i = 0; i < this.productMix.length; i++) {
            var item = this.productMix[i];
            if (item.familyName == familyName && item.country == countryCode && item.maxNode == nodeNum ){
                return item.price;
            }
            if (item.familyName == familyName && item.country == 'XX' && item.maxNode == nodeNum )
                defaultCountryItem =  item;
        }

        if(defaultCountryItem)return defaultCountryItem.price;

        return undefined;

    }
};
$(function () {
    $.ajax({
        type: "GET",
        url: "/product/getAll",
        contentType: "application/json; charset=utf-8",
        dataType: "text",
        async: false,
        success: function (response) {
            var res = JSON.parse(response);
            if (res.success)
                priceController.productMix = res.list;
        },
        error: function (request, status, errorThrown) {

        }
    });
    $.ajax({
        type: "GET",
        url: "/product/getInterceptionCountry",
        contentType: "application/json; charset=utf-8",
        dataType: "text",
        async: false,
        success: function (response) {
            var res = JSON.parse(response);
            if (res.success)
                priceController.interceptionList = res.list;
        },
        error: function (request, status, errorThrown) {

        }
    });
    priceController.init();

});
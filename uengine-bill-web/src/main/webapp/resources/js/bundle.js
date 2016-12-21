function bundle(message) {

    this.message = message;

    this.msg = function (key, args) {
        if(arguments.length > 1) {
            var value = message[key];
            return value.replace(/\{(\d+)\}/g, function (m, i) {
                return args[i];
            });
        } else {
            return message[key];
        }
    };
}

var message;

$.ajax({

    type: "get",
    url: '/config/bundle.json?lang=' + lang,
    dataType: "json",
    success: function (content) {
        if(content.success){
            message = new bundle(content.map);
        }else{
            console.log(content.error);
        }
    },
    error: function (e) {
        console.log('error!!');
        console.log(e.responseText);
    },
    async: false
});


function run() {
    var stdout = [];
    var log = function (obj) {
        console.log(obj);
        stdout.push(obj);
    };

    var customScript = function () {
        var xh = new XMLHttpRequest();
        var result;
        var url = "http://52.79.164.208:5984/forcs_iam/_design/oauth_user/_view/selectByManagementId?key=%5B%225e3432ad172644ea8041fe67eb8f5cbd%22%5D";
        xh.onreadystatechange = function () {
            if (xh.readyState == 4 && xh.status == 200) {
                var res = xh.responseText;
                var parse = JSON.parse(res);
                var rows = parse['rows'];
                result = rows;
            }
        };
        xh.open("GET", url, false);
        xh.send();
        return JSON.stringify(result);
        try {
            ${script}
        } catch (e) {
            log(e);
            return false;
        }
    };

    var customResult = customScript();
    return {
        log: stdout,
        value: customResult
    };
}
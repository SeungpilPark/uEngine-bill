function run() {
    var stdout = '';
    var log = function (obj) {
        console.log(obj);
        //stdout.push(obj + '');
        stdout = stdout + obj + '\n\n';
    };

    var customScript = function () {
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
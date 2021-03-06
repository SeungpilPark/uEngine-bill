<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Swagger UI</title>
    <link rel="icon" type="image/png" href="/resources/swagger/images/favicon-32x32.png" sizes="32x32"/>
    <link rel="icon" type="image/png" href="/resources/swagger/images/favicon-16x16.png" sizes="16x16"/>
    <link href='/resources/swagger/css/typography.css' media='screen' rel='stylesheet' type='text/css'/>
    <link href='/resources/swagger/css/reset.css' media='screen' rel='stylesheet' type='text/css'/>
    <link href='/resources/swagger/css/screen.css' media='screen' rel='stylesheet' type='text/css'/>
    <link href='/resources/swagger/css/reset.css' media='print' rel='stylesheet' type='text/css'/>
    <link href='/resources/swagger/css/print.css' media='print' rel='stylesheet' type='text/css'/>
    <script src='/resources/swagger/lib/jquery-1.8.0.min.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/jquery.slideto.min.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/jquery.wiggle.min.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/jquery.ba-bbq.min.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/handlebars-2.0.0.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/js-yaml.min.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/lodash.min.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/backbone-min.js' type='text/javascript'></script>
    <script src='/resources/swagger/swagger-ui.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/highlight.9.1.0.pack.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/highlight.9.1.0.pack_extended.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/jsoneditor.min.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/marked.js' type='text/javascript'></script>
    <script src='/resources/swagger/lib/swagger-oauth.js' type='text/javascript'></script>

    <!-- Some basic translations -->
    <!-- <script src='lang/translator.js' type='text/javascript'></script> -->
    <!-- <script src='lang/ru.js' type='text/javascript'></script> -->
    <!-- <script src='lang/en.js' type='text/javascript'></script> -->

    <script type="text/javascript">
        $(function () {
            var url = window.location.search.match(/url=([^&]+)/);
            if (url && url.length > 1) {
                url = decodeURIComponent(url[1]);
            } else {
                //url = "http://petstore.swagger.io/v2/swagger.json";
                url = "/resources/swagger/swagger.json";
            }

            hljs.configure({
                highlightSizeThreshold: 5000
            });

            // Pre load translate...
            if (window.SwaggerTranslator) {
                window.SwaggerTranslator.translate();
            }
            window.swaggerUi = new SwaggerUi({
                url: url,
                dom_id: "swagger-ui-container",
                supportedSubmitMethods: ['get', 'post', 'put', 'delete', 'patch'],
                onComplete: function (swaggerApi, swaggerUi) {
                    if (typeof initOAuth == "function") {
                        initOAuth({
                            clientId: "your-client-id",
                            clientSecret: "your-client-secret-if-required",
                            realm: "your-realms",
                            appName: "your-app-name",
                            scopeSeparator: ",",
                            additionalQueryStringParams: {}
                        });
                    }

                    if (window.SwaggerTranslator) {
                        window.SwaggerTranslator.translate();
                    }
                },
                onFailure: function (data) {
                    log("Unable to Load SwaggerUI");
                },
                docExpansion: "none",
                jsonEditor: false,
                defaultModelRendering: 'schema',
                showRequestHeaders: false
            });

            window.swaggerUi.load();

//            $('#management_key').change(function() {
//                var key = $('#management_key').val();
//                if(key && key.trim() != "") {
//                    swaggerUi.api.clientAuthorizations.add("key1", new SwaggerClient.ApiKeyAuthorization("management-key", key, "header"));
//                    console.log(key);
//                }
//            });
//
//            $('#management_secret').change(function() {
//                var key = $('#management_secret').val();
//                if(key && key.trim() != "") {
//                    swaggerUi.api.clientAuthorizations.add("key2", new SwaggerClient.ApiKeyAuthorization("management-secret", key, "header"));
//                    console.log(key);
//                }
//            });

            function log() {
                if ('console' in window) {
                    console.log.apply(console, arguments);
                }
            }
        });
    </script>
</head>

<body class="swagger-section">
<div id='header'>
    <div class="swagger-ui-wrap">
        <a id="logo" href="http://swagger.io"><img class="logo__img" alt="swagger" height="30" width="30"
                                                   src="/resources/swagger/images/logo_small.png"/><span class="logo__title">swagger</span></a>

        <form id='api_selector'>
            <div class='input'><input placeholder="http://example.com/api" id="input_baseUrl" name="baseUrl"
                                      type="text"/></div>
            <div id='auth_container'></div>
            <div class='input'><a id="explore" class="header__btn" href="#" data-sw-translate>Explore</a></div>
        </form>
    </div>
</div>


<div id="message-bar" class="swagger-ui-wrap" data-sw-translate>&nbsp;</div>

<%--<div class="swagger-ui-wrap">--%>
    <%--<div class="info_description input">management-key <input id="management_key" name="management_key" type="text"/></div>--%>
    <%--<div class="info_description input">management-secret <input id="management_secret" name="management_secret" type="text"/>--%>
    <%--</div>--%>
<%--</div>--%>
<%--<br><br>--%>
<div id="swagger-ui-container" class="swagger-ui-wrap"></div>
</body>
</html>


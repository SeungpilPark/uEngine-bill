/**
 * Copyright (C) 2011  Flamingo Project (http://www.opencloudengine.org).
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.uengine.garuda.web.configuration;

import org.uengine.garuda.common.rest.Response;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.Messages;
import org.uengine.garuda.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

import static org.apache.commons.lang.StringUtils.isEmpty;
import static org.apache.commons.lang.StringUtils.splitPreserveAllTokens;

/**
 * 애플리케이션 설정 파일(<tt>config.properties</tt>)을 JavaScript에서 사용하기 위해서 JSON으로 변환하는 컨트롤러.
 *
 * @author Byoung Gon, Kim
 * @since 0.1
 */
@RestController
@RequestMapping("/config")
public class ConfigurationController implements InitializingBean {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(ConfigurationController.class);

    /**
     * JavaScript Variable Prefix
     */
    private final static String JS_PREFIX = "var config = ";

    /**
     * JavaScript End Postfix
     */
    private final static String JS_POSTFIX = ";";

    /**
     * JavaScript Content Type
     */
    private final static String CONTENT_TYPE = "application/x-javascript; charset=UTF-8";

    @Autowired
    @Qualifier("config")
    private Properties config;

    /**
     * Configuration JSON
     */
    private String configJson;

    /**
     * 환경설정 파일에서 expose. 로 시작하는 환경설정값을 JavaScript에서 사용할 수 있는 포맷으로 변경한다.
     */
    @Override
    public void afterPropertiesSet() throws Exception {
        Map params = new HashMap();
        Set<Object> keys = config.keySet();
        for (Object key : keys) {
            String value = (String) config.get(key);
            // 웹 클라이언트에 노출할 Key를 찾아서 이를 처리한다.
            if (((String) key).equals("web.expose.keys")) {
                String keysToExport = config.getProperty("web.expose.keys");
                String[] keyToExport = splitPreserveAllTokens(keysToExport, ",");
                for (String string : keyToExport) {
                    if (isEmpty(config.getProperty(string.trim()))) {
                        params.put(string.trim(), "");
                    } else {
                        params.put(string.trim(), config.getProperty(string.trim()).trim());
                    }
                }
            } else {
                // web. 로 시작하는 모든 Key를 찾아서 웹에 노출한다.
                if (((String) key).startsWith("web.")) {
                    String removed = StringUtils.replace(((String) key), "web.", "");
                    params.put(removed.trim(), value.trim());
                }
            }
        }

        configJson = JsonUtils.format(params);
    }

    /**
     * 환경설정 파일을 웹 브라우저에서 사용하기 위해서 JavaScript로 변환한다.
     */
    @RequestMapping(value = "js", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<String> getConfiguration(final HttpServletRequest request, final HttpServletResponse response, final Locale locale) throws IOException {
        MultiValueMap headers = new HttpHeaders();
        headers.set("Content-Type", CONTENT_TYPE);
        return new ResponseEntity(JS_PREFIX + configJson + JS_POSTFIX, headers, HttpStatus.OK);
    }

    /**
     * 다국어 지원을 위한 리소스 번들을 처리한다.
     */
    @RequestMapping(value = "bundle", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public Response getBundle(final Locale locale) throws IOException {
        Response response = new Response();
        try{
            Map map = Messages.toMap(locale);
            map.put("browser.language", locale.getLanguage());
            map.put("browser.country", locale.getCountry());
            map.put("browser.locale", locale.toString());

            MultiValueMap headers = new HttpHeaders();
            response.getMap().putAll(map);
            response.setSuccess(true);
        }catch (Exception ex){
            response.getError().setMessage(ex.getMessage());
            if (ex.getCause() != null) response.getError().setCause(ex.getCause().getMessage());
            response.getError().setException(ExceptionUtils.getFullStackTrace(ex));
        }
        return response;
    }
}
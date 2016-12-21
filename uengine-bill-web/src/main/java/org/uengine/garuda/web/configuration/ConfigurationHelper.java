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

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

/**
 * Configuration를 Singleton Instance로 접근하기 위한 Helper.
 *
 * @author Byoung Gon, Kim
 * @since 0.1
 */
@Component
public class ConfigurationHelper implements InitializingBean {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(ConfigurationHelper.class);

    @Autowired
    @Qualifier("app")
    private Properties app;

    @Autowired
    @Qualifier("config")
    private Properties config;

    /**
     * Property Key Value를 담고 있는 map
     */
    private Map<String, String> map = new HashMap();

    /**
     * Property Key Value를 담고 있는 properties.
     */
    private Properties props = new Properties();

    /**
     * ResourceBundleHelper의 Singleton Instance
     */
    private static ConfigurationHelper helper;

    /**
     * Default constructor.
     */
    public ConfigurationHelper() {
    }

    /**
     * ConfigurationHelper의 Singleton Instance를 반환한다.
     *
     * @return ConfigurationHelper의 Singleton Instance
     */
    public static ConfigurationHelper getHelper() {
        return helper;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        this.helper = this;
        inject(app);
        inject(config);
    }

    private void inject(Properties config) {
        Set<Object> configs = config.keySet();
        for (Object obj : configs) {
            String key = (String) obj;
            String value = config.getProperty(key);

            this.map.put(key, value);
            this.props.put(key, value);

            logger.debug("Loaded {}={}", key, value);
        }
    }

    public Properties getProperties() {
        return this.props;
    }

    /**
     * 설정 정보의 크기를 반환한다.
     *
     * @return 크기
     */
    public int size() {
        return map.size();
    }

    /**
     * 지정한 Key의 Value를 평가한다.
     *
     * @param key Key
     * @return Key의 Value에 대해서 평가한 문자열
     */
    public String get(String key) {
        return map.get(key);
    }

    /**
     * 지정한 Key의 Value를 평가한다.
     *
     * @param key          Key
     * @param defaultValue 기본값
     * @return Key의 Value에 대해서 평가한 문자열
     */
    public String get(String key, String defaultValue) {
        String value = map.get(key);
        if (!StringUtils.isEmpty(value)) {
            return value;
        }
        return defaultValue;
    }

    /**
     * 지정한 Key가 존재하는지 확인한다.
     *
     * @param key 존재 여부를 확인할 Key
     * @return 존재하지 않는다면 <tt>false</tt>
     */
    public boolean containsKey(String key) {
        return map.containsKey(key);
    }

    /**
     * 지정한 Key에 대해서 Long Value를 반환한다.
     *
     * @param key Key
     * @return Key에 대한 Long Value
     */
    public long getLong(String key) {
        return Long.parseLong(get(key));
    }

    /**
     * 지정한 Key에 대해서 Boolean Value를 반환한다.
     *
     * @param key Key
     * @return Key에 대한 Boolean Value
     */
    public boolean getBoolean(String key) {
        try {
            return Boolean.parseBoolean(get(key));
        } catch (Exception ex) {
            return false;
        }
    }

    /**
     * 지정한 Key에 대해서 Boolean Value를 반환한다.
     *
     * @param key          Key
     * @param defaultValue 기본값
     * @return Key에 대한 Boolean Value
     */
    public boolean getBoolean(String key, boolean defaultValue) {
        if (containsKey(key)) {
            return Boolean.parseBoolean(get(key));
        } else {
            return defaultValue;
        }
    }

    /**
     * 지정한 Key에 대해서 Long Value를 반환한다. 값이 없다면 기본값을 반환한다.
     *
     * @param key          Key
     * @param defaultValue 기본값
     * @return Key에 대한 Long Value
     */
    public long getLong(String key, long defaultValue) {
        if (containsKey(key)) {
            return Long.parseLong(get(key));
        } else {
            return defaultValue;
        }
    }
}

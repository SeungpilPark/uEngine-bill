/*
 * Copyright 2012-2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.uengine.garuda.common.logging;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.util.ContextInitializer;
import org.slf4j.ILoggerFactory;
import org.slf4j.Logger;
import org.slf4j.bridge.SLF4JBridgeHandler;
import org.slf4j.impl.StaticLoggerBinder;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;
import org.springframework.util.ResourceUtils;
import org.springframework.util.SystemPropertyUtils;

import java.net.URL;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * {@link org.uengine.garuda.common.logging.LoggingSystem} for for <a href="http://logback.qos.ch">logback</a>.
 *
 * @author Phillip Webb
 * @author Dave Syer
 */
public class LogbackLoggingSystem extends AbstractLoggingSystem {

    private static final Map<LogLevel, Level> LEVELS;

    static {
        Map<LogLevel, Level> levels = new HashMap<LogLevel, Level>();
        levels.put(LogLevel.TRACE, Level.TRACE);
        levels.put(LogLevel.DEBUG, Level.DEBUG);
        levels.put(LogLevel.INFO, Level.INFO);
        levels.put(LogLevel.WARN, Level.WARN);
        levels.put(LogLevel.ERROR, Level.ERROR);
        levels.put(LogLevel.FATAL, Level.ERROR);
        LEVELS = Collections.unmodifiableMap(levels);
    }

    public LogbackLoggingSystem(ClassLoader classLoader) {
        super(classLoader, "logback-test.groovy", "logback-test.xml", "logback.groovy", "logback.xml");
    }

    @Override
    public void beforeInitialize() {
        super.beforeInitialize();
        try {
            if (ClassUtils.isPresent("org.slf4j.bridge.SLF4JBridgeHandler",
                getClassLoader())) {
                try {
                    SLF4JBridgeHandler.removeHandlersForRootLogger();
                } catch (NoSuchMethodError ex) {
                    // Method missing in older versions of SLF4J like in JBoss AS 7.1
                    SLF4JBridgeHandler.uninstall();
                }
                SLF4JBridgeHandler.install();
            }
        } catch (Throwable ex) {
            // Ignore. No java.util.logging bridge is installed.
        }
    }

    @Override
    public void initialize(String configLocation) {
        Assert.notNull(configLocation, "ConfigLocation must not be null");
        String resolvedLocation = SystemPropertyUtils.resolvePlaceholders(configLocation);
        ILoggerFactory factory = StaticLoggerBinder.getSingleton().getLoggerFactory();
        Assert.isInstanceOf(LoggerContext.class, factory,
            "LoggerFactory is not a Logback LoggerContext but "
                + "Logback is on the classpath. Either remove Logback "
                + "or the competing implementation (" + factory.getClass() + ")"
        );
        LoggerContext context = (LoggerContext) factory;
        context.stop();
        try {
            URL url = ResourceUtils.getURL(resolvedLocation);
            new ContextInitializer(context).configureByResource(url);
        } catch (Exception ex) {
            throw new IllegalStateException("Could not initialize logging from "
                    + configLocation, ex);
        }
    }

    @Override
    public void setLogLevel(String loggerName, LogLevel level) {
        ILoggerFactory factory = StaticLoggerBinder.getSingleton().getLoggerFactory();
        Logger logger = factory
                .getLogger(StringUtils.isEmpty(loggerName) ? Logger.ROOT_LOGGER_NAME
                        : loggerName);
        ((ch.qos.logback.classic.Logger) logger).setLevel(LEVELS.get(level));
    }

}

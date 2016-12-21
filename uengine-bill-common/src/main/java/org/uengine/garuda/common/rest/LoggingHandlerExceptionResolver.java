/*
 * Copyright (C) 2015 Flamingo Project (http://www.opencloudengine.org).
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
package org.uengine.garuda.common.rest;

import org.uengine.garuda.util.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoggingHandlerExceptionResolver implements HandlerExceptionResolver, Ordered {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(LoggingHandlerExceptionResolver.class);

    public int getOrder() {
        return Integer.MIN_VALUE;
    }

    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception exception) {
        logger.warn("Error caught in {} :\n{}", handler.getClass().getName(), ExceptionUtils.getFullStackTrace(exception));
        return null;
    }
}
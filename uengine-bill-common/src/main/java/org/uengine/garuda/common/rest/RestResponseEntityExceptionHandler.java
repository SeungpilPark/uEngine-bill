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

import com.fasterxml.jackson.databind.JsonMappingException;
import org.uengine.garuda.util.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.convert.ConversionFailedException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

// @ControllerAdvice
public class RestResponseEntityExceptionHandler extends ResponseEntityExceptionHandler {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(RestResponseEntityExceptionHandler.class);

    /**
     * Catch all for any other exceptions...
     */
    @ExceptionHandler({Exception.class})
    @ResponseBody
    public ResponseEntity<?> handleAnyException(Exception e) {
        return errorResponse(e, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * Handle failures commonly thrown from code
     */
    @ExceptionHandler({InvocationTargetException.class, IllegalArgumentException.class, ClassCastException.class,
            ConversionFailedException.class, IOException.class, JsonMappingException.class})
    @ResponseBody
    public ResponseEntity handleMiscFailures(Exception t) {
        return errorResponse(t, HttpStatus.BAD_REQUEST);
    }

    protected ResponseEntity<Response> errorResponse(Exception throwable, HttpStatus status) {
        if (null != throwable) {
            logger.warn("error caught: " + throwable.getMessage(), throwable);
            Response response = new Response();
            response.getError().setMessage(throwable.getMessage());
            if (throwable.getCause() != null) response.getError().setCause(throwable.getCause().getMessage());
            response.getError().setException(ExceptionUtils.getFullStackTrace(throwable));
            response.setSuccess(false);
            return response(response, status);
        } else {
            logger.warn("unknown error caught in REST Controller, {}", status);
            return response(null, status);
        }
    }

    protected <T> ResponseEntity<T> response(T body, HttpStatus status) {
        logger.debug("Responding with a status of {}", status);
        return new ResponseEntity(body, new HttpHeaders(), status);
    }
}
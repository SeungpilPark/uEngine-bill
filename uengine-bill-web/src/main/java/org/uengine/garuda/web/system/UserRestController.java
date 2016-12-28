/**
 * Copyright (C) 2011 Flamingo Project (http://www.opencloudengine.org).
 * <p/>
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * <p/>
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * <p/>
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.uengine.garuda.web.system;

import org.apache.commons.codec.binary.Base64;
import org.opencloudengine.garuda.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.web.configuration.DefaultController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Security Auth Controller
 *
 * @author Seungpil PARK
 * @since 2.0
 */
@Controller
@RequestMapping("/rest/v1")
public class UserRestController extends DefaultController {

    @Autowired
    private UserService userService;

    public static String scope = "uEngineSubscriptions/subscriptionsapi";

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(UserRestController.class);

    @RequestMapping(value = "/access_token", method = RequestMethod.POST, produces = "application/json")
    public ResponseEntity<Map> accessToken(HttpServletRequest request) {

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String scope = request.getParameter("scope");

            if (!this.scope.equals(scope)) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }
            Map map = userService.accessToken(username, password, scope);
            if ((int) map.get("status") != 200) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<>(map, HttpStatus.OK);

        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/token_info", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<Map> tokenInfo(HttpServletRequest request, HttpServletResponse response
    ) throws IOException {

        try {
            String token = request.getParameter("access_token");

            if (StringUtils.isEmpty(token)) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }
            Map map = userService.tokenInfo(token);
            if ((int) map.get("status") != 200) {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<>(map, HttpStatus.OK);

        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}

package org.uengine.garuda.web.rest;


import org.uengine.garuda.web.console.oauthuser.OauthUser;
import org.uengine.garuda.web.console.oauthuser.OauthUserService;
import org.uengine.garuda.web.management.Management;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Properties;

@Controller
@RequestMapping("/rest/v1")
public class OauthUserRestController {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthUserService oauthUserService;

    @Autowired
    private RestAuthService restAuthService;

    @RequestMapping(value = "/user", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<OauthUser>> listAllUsers(HttpServletRequest request) {
        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            List<OauthUser> users = oauthUserService.selectAllByManagementId(management.get_id());
            if (users.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(users, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/user/{_id}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<OauthUser> getUser(HttpServletRequest request, @PathVariable("_id") String _id) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthUser oauthUser = oauthUserService.selectByManagementIdAndId(management.get_id(), _id);
            if (oauthUser == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(oauthUser, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/user", method = RequestMethod.POST)
    public ResponseEntity<Void> createUser(HttpServletRequest request, @RequestBody OauthUser oauthUser, UriComponentsBuilder ucBuilder) {
        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {

            OauthUser existUser = oauthUserService.selectByManagementIdAndUserName(management.get_id(), oauthUser.getUserName());
            if (existUser != null) {
                return new ResponseEntity<>(HttpStatus.CONFLICT);
            }

            OauthUser createdUser = oauthUserService.createUser(management.get_id(), oauthUser);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/user/{_id}").buildAndExpand(createdUser.get_id()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/user/{_id}", method = RequestMethod.PUT)
    public ResponseEntity<OauthUser> updateUser(HttpServletRequest request, @PathVariable("_id") String _id, @RequestBody OauthUser oauthUser) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthUser currentUser = oauthUserService.selectByManagementIdAndId(management.get_id(), _id);

            if (currentUser == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            oauthUser.set_id(currentUser.get_id());
            oauthUserService.updateById(oauthUser);

            currentUser = oauthUserService.selectByManagementIdAndId(management.get_id(), _id);
            return new ResponseEntity<>(currentUser, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/user/{_id}", method = RequestMethod.DELETE)
    public ResponseEntity<OauthUser> deleteUser(HttpServletRequest request, @PathVariable("_id") String _id) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        try {
            OauthUser currentUser = oauthUserService.selectByManagementIdAndId(management.get_id(), _id);

            if (currentUser == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            oauthUserService.deleteById(currentUser.get_id());
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}

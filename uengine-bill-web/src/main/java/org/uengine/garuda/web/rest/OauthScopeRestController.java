package org.uengine.garuda.web.rest;


import org.uengine.garuda.web.console.oauthscope.OauthScope;
import org.uengine.garuda.web.console.oauthscope.OauthScopeService;
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
public class OauthScopeRestController {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthScopeService oauthScopeService;

    @Autowired
    private RestAuthService restAuthService;

    @RequestMapping(value = "/scope", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<OauthScope>> listAllScopes(HttpServletRequest request) {
        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            List<OauthScope> oauthScopes = oauthScopeService.selectAllByManagementId(management.get_id());
            if (oauthScopes.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(oauthScopes, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/scope/{id}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<OauthScope> getScope(HttpServletRequest request, @PathVariable("id") String id) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthScope oauthScope = oauthScopeService.selectByManagementIdAndId(management.get_id(), id);
            if (oauthScope == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(oauthScope, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/scope", method = RequestMethod.POST)
    public ResponseEntity<Void> createScope(HttpServletRequest request, @RequestBody OauthScope oauthScope, UriComponentsBuilder ucBuilder) {
        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {

            OauthScope existScope = oauthScopeService.selectByManagementIdAndName(management.get_id(), oauthScope.getName());
            if (existScope != null) {
                return new ResponseEntity<>(HttpStatus.CONFLICT);
            }

            OauthScope createdScope = oauthScopeService.createScope(management.get_id(), oauthScope.getName(), oauthScope.getDescription());

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/scope/{_id}").buildAndExpand(createdScope.get_id()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/scope/{_id}", method = RequestMethod.PUT)
    public ResponseEntity<OauthScope> updateScope(HttpServletRequest request, @PathVariable("_id") String _id, @RequestBody OauthScope oauthScope) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthScope currentScope = oauthScopeService.selectByManagementIdAndId(management.get_id(), _id);

            if (currentScope == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            oauthScope.set_id(currentScope.get_id());
            oauthScopeService.updateById(oauthScope);

            currentScope = oauthScopeService.selectByManagementIdAndId(management.get_id(), _id);
            return new ResponseEntity<>(currentScope, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/scope/{_id}", method = RequestMethod.DELETE)
    public ResponseEntity<OauthScope> deleteScope(HttpServletRequest request, @PathVariable("_id") String _id) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        try {
            OauthScope currentScope = oauthScopeService.selectByManagementIdAndId(management.get_id(), _id);

            if (currentScope == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            oauthScopeService.deleteById(currentScope.get_id());
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}

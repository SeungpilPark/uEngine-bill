package org.uengine.garuda.web.rest;


import org.uengine.garuda.web.console.oauthclient.OauthClient;
import org.uengine.garuda.web.console.oauthclient.OauthClientService;
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
public class OauthClientRestController {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthClientService oauthClientService;

    @Autowired
    private RestAuthService restAuthService;

    @RequestMapping(value = "/client", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<OauthClient>> listAllClients(HttpServletRequest request) {
        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            List<OauthClient> oauthClients = oauthClientService.selectAllByManagementId(management.get_id());
            if (oauthClients.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(oauthClients, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/client/{_id}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<OauthClient> getClient(HttpServletRequest request, @PathVariable("_id") String _id) {
        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthClient oauthClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);
            if (oauthClient == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(oauthClient, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/client", method = RequestMethod.POST)
    public ResponseEntity<Void> createClient(HttpServletRequest request, @RequestBody OauthClient oauthClient, UriComponentsBuilder ucBuilder) {
        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthClient existClient = oauthClientService.selectByManagementIdAndName(management.get_id(), oauthClient.getName());
            if (existClient != null) {
                return new ResponseEntity<>(HttpStatus.CONFLICT);
            }

            OauthClient createdClient = oauthClientService.createClient(management.get_id(), oauthClient.getName(), oauthClient.getDescription(), oauthClient.getClientTrust()
                    , oauthClient.getClientType(), oauthClient.getActiveClient(), oauthClient.getAuthorizedGrantTypes(), oauthClient.getWebServerRedirectUri()
                    , oauthClient.getRefreshTokenValidity(), oauthClient.getCodeLifetime(), oauthClient.getRefreshTokenLifetime()
                    , oauthClient.getAccessTokenLifetime(), oauthClient.getJwtTokenLifetime(), null);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/client/{_id}").buildAndExpand(createdClient.get_id()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/client/{_id}", method = RequestMethod.PUT)
    public ResponseEntity<OauthClient> updateClient(HttpServletRequest request, @PathVariable("_id") String _id, @RequestBody OauthClient oauthClient) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthClient currentClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);

            if (currentClient == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            oauthClient.set_id(currentClient.get_id());
            oauthClientService.updateById(oauthClient);

            currentClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);
            return new ResponseEntity<>(currentClient, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/client/{_id}", method = RequestMethod.DELETE)
    public ResponseEntity<OauthClient> deleteClient(HttpServletRequest request, @PathVariable("_id") String _id) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        try {
            OauthClient currentClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);

            if (currentClient == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            oauthClientService.deleteById(currentClient.get_id());
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}

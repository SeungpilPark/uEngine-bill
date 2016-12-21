package org.uengine.garuda.web.rest;


import org.uengine.garuda.web.console.oauthclient.OauthClient;
import org.uengine.garuda.web.console.oauthclient.OauthClientService;
import org.uengine.garuda.web.management.Management;
import org.uengine.garuda.web.oauth.OauthAccessToken;
import org.uengine.garuda.web.oauth.OauthTokenService;
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
import java.util.Properties;
import java.util.UUID;

@Controller
@RequestMapping("/rest/v1")
public class AccessToeknRestController {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthTokenService oauthTokenService;

    @Autowired
    private OauthClientService oauthClientService;

    @Autowired
    private RestAuthService restAuthService;

    @RequestMapping(value = "/token/{_id}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<OauthAccessToken> getToken(HttpServletRequest request, @PathVariable("_id") String _id) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthAccessToken accessToken = oauthTokenService.selectTokenByManagementIdAndId(management.get_id(), _id);
            if (accessToken == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(accessToken, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/token/{token}", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<OauthAccessToken> getTokenByToken(HttpServletRequest request, @PathVariable("token") String token) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthAccessToken accessToken = oauthTokenService.selectTokenByToken(token);
            if (accessToken == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(accessToken, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/token", method = RequestMethod.POST)
    public ResponseEntity<Void> createToken(HttpServletRequest request, @RequestBody OauthAccessToken oauthAccessToken, UriComponentsBuilder ucBuilder) {
        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            String clientId = oauthAccessToken.getClientId();
            OauthClient oauthClient = oauthClientService.selectByManagementIdAndId(management.get_id(), clientId);
            if (oauthClient == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            if ("Y".equals(oauthClient.getRefreshTokenValidity())) {
                oauthAccessToken.setRefreshToken(UUID.randomUUID().toString());
            }
            oauthAccessToken.setManagementId(management.get_id());
            oauthAccessToken.setToken(UUID.randomUUID().toString());

            OauthAccessToken createdToken = oauthTokenService.insertToken(oauthAccessToken);

            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(ucBuilder.path("/rest/v1/token/{_id}").buildAndExpand(createdToken.get_id()).toUri());
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/token/{_id}", method = RequestMethod.PUT)
    public ResponseEntity<OauthAccessToken> updateToken(HttpServletRequest request, @PathVariable("_id") String _id, @RequestBody OauthAccessToken oauthAccessToken) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        try {
            OauthAccessToken currentToken = oauthTokenService.selectTokenByManagementIdAndId(management.get_id(), _id);

            if (currentToken == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            currentToken.setScopes(oauthAccessToken.getScopes());

            oauthTokenService.updateTokenById(currentToken);

            currentToken = oauthTokenService.selectTokenByManagementIdAndId(management.get_id(), _id);
            return new ResponseEntity<>(currentToken, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "/token/{_id}", method = RequestMethod.DELETE)
    public ResponseEntity<OauthAccessToken> deleteToken(HttpServletRequest request, @PathVariable("_id") String _id) {

        Management management = restAuthService.managementParser(request);
        if (management == null) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        try {
            OauthAccessToken currentToken = oauthTokenService.selectTokenByManagementIdAndId(management.get_id(), _id);

            if (currentToken == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }

            oauthTokenService.deleteTokenById(currentToken.get_id());

            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}

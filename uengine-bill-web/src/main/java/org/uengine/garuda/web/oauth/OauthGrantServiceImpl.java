package org.uengine.garuda.web.oauth;

import com.nimbusds.jwt.JWTClaimsSet;
import org.uengine.garuda.util.JsonFormatterUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.JwtUtils;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.console.oauthclient.OauthClient;
import org.uengine.garuda.web.console.oauthclient.OauthClientService;
import org.uengine.garuda.web.console.oauthscope.OauthScope;
import org.uengine.garuda.web.console.oauthscope.OauthScopeService;
import org.uengine.garuda.web.console.oauthuser.OauthUser;
import org.uengine.garuda.web.console.oauthuser.OauthUserService;
import org.uengine.garuda.web.management.Management;
import org.uengine.garuda.web.management.ManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Service
public class OauthGrantServiceImpl implements OauthGrantService {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthClientService oauthClientService;

    @Autowired
    private ManagementService managementService;

    @Autowired
    private OauthTokenService oauthTokenService;

    @Autowired
    private OauthUserService oauthUserService;

    @Autowired
    private OauthScopeService oauthScopeService;

    @Autowired
    private CustomService customService;

    @Override
    public void processTokenInfo(AccessTokenResponse accessTokenResponse) throws Exception {

        //수행해야 할 것. UUID 인지 아닌지 확인.
        //JWT 밸리데이트 과정 추가.
        Map map = new HashMap();

        //필요한 값을 검증한다.
        String[] params = new String[]{"access_token"};
        if (!this.checkParameters(params, accessTokenResponse)) {
            return;
        }

        String token = accessTokenResponse.getAccessToken();
        boolean matches = token.matches("[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}");

        //Bearer 토큰일경우
        if (matches) {
            OauthAccessToken accessToken = oauthTokenService.selectTokenByToken(accessTokenResponse.getAccessToken());
            if (accessToken == null) {
                accessTokenResponse.setError(OauthConstant.INVALID_TOKEN);
                accessTokenResponse.setError_description("Requested access_token is not exist.");
                this.processRedirect(accessTokenResponse);
                return;
            }
            Management management = managementService.selectById(accessToken.getManagementId());
            OauthClient oauthClient = oauthClientService.selectById(accessToken.getClientId());
            OauthUser oauthUser = oauthUserService.selectById(accessToken.getOauthUserId());

            //코드의 발급시간을 확인한다.
            Long regDate = accessToken.getRegDate();
            Date currentTime = new Date();
            Date expirationTime = new Date(regDate + oauthClient.getAccessTokenLifetime() * 1000);
            long diff = (long) Math.floor((expirationTime.getTime() - currentTime.getTime()) / 1000);

            if (diff <= 0) {
                accessTokenResponse.setError(OauthConstant.INVALID_TOKEN);
                accessTokenResponse.setError_description("requested access_token has expired.");
                this.processRedirect(accessTokenResponse);
                return;
            } else {
                map.put("expires_in", diff);
            }

            //커스텀 토큰 스크립트를 수행한다.
            if (customService.inCase(management, CustomServiceImpl.VALIDATE_TOKEN)) {
                boolean value = customService.processTokenScript(management, oauthClient, oauthUser, accessToken.getScopes(),
                        "Bearer", null, accessToken.getType());
                if (!value) {
                    accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
                    accessTokenResponse.setError_description("Access denied by custom token issuance rule");
                    this.processRedirect(accessTokenResponse);
                    return;
                }
            }

            map.put("client", oauthClient.getClientKey());
            map.put("clientId", oauthClient.get_id());
            if (oauthUser != null) {
                map.put("username", oauthUser.getUserName());
                map.put("userId", oauthUser.get_id());
            }
            if (!StringUtils.isEmpty(accessToken.getRefreshToken())) {
                map.put("refreshToken", accessToken.getRefreshToken());
            }
            map.put("type", accessToken.getType());
            map.put("scope", accessToken.getScopes());

            String marshal = JsonUtils.marshal(map);
            String prettyPrint = JsonFormatterUtils.prettyPrint(marshal);


            HttpServletResponse response = accessTokenResponse.getResponse();
            response.setStatus(200);
            response.setHeader("Content-Type", "application/json;charset=UTF-8");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.getWriter().write(prettyPrint);
        }

        //JWT 토큰일경우
        else {

            JWTClaimsSet jwtClaimsSet = JwtUtils.parseToken(token);

            //이슈어 확인
            String issuer = jwtClaimsSet.getIssuer();
            if (!config.getProperty("security.jwt.issuer").equals(issuer)) {
                accessTokenResponse.setError(OauthConstant.INVALID_TOKEN);
                accessTokenResponse.setError_description("Invalid issuer.");
                this.processRedirect(accessTokenResponse);
                return;
            }

            String sharedSecret = config.getProperty("security.jwt.secret");

            boolean validated = JwtUtils.validateToken(token, sharedSecret);
            if (!validated) {
                accessTokenResponse.setError(OauthConstant.INVALID_TOKEN);
                accessTokenResponse.setError_description("Invalid token secret.");
                this.processRedirect(accessTokenResponse);
                return;
            }

            //코드의 발급시간을 확인한다.
            Date currentTime = new Date();
            Date expirationTime = jwtClaimsSet.getExpirationTime();
            long diff = (long) Math.floor((expirationTime.getTime() - currentTime.getTime()) / 1000);

            if (diff <= 0) {
                accessTokenResponse.setError(OauthConstant.INVALID_TOKEN);
                accessTokenResponse.setError_description("requested access_token has expired.");
                this.processRedirect(accessTokenResponse);
                return;
            } else {
                map.put("expires_in", diff);
            }

            Map<String, Object> claims = jwtClaimsSet.getClaims();
            map.putAll(claims);

            //커스텀 토큰 스크립트를 수행한다.
            Map context = (Map) claims.get("context");
            String managementId = (String) context.get("managementId");
            String clientKey = (String) context.get("clientKey");
            String userId = context.containsKey("userId") ? (String) context.get("userId") : null;
            String scopes = (String) context.get("scopes");
            String type = (String) context.get("type");
            String claim = JsonUtils.marshal((Map) claims.get("claim"));
            Management management = managementService.selectById(managementId);
            if (customService.inCase(management, CustomServiceImpl.VALIDATE_TOKEN)) {
                OauthClient oauthClient = oauthClientService.selectByClientKey(clientKey);
                OauthUser oauthUser = userId != null ? oauthUserService.selectById(userId) : null;
                boolean value = customService.processTokenScript(management, oauthClient, oauthUser, scopes,
                        "JWT", claim, type);
                if (!value) {
                    accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
                    accessTokenResponse.setError_description("Access denied by custom token issuance rule");
                    this.processRedirect(accessTokenResponse);
                    return;
                }
            }

            String marshal = JsonUtils.marshal(map);
            String prettyPrint = JsonFormatterUtils.prettyPrint(marshal);

            HttpServletResponse response = accessTokenResponse.getResponse();
            response.setStatus(200);
            response.setHeader("Content-Type", "application/json;charset=UTF-8");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.getWriter().write(prettyPrint);
        }
    }

    @Override
    public void processRefreshToken(AccessTokenResponse accessTokenResponse) throws Exception {
        //필요한 값을 검증한다.
        String[] params = new String[]{"client_id", "client_secret", "grant_type", "refresh_token"};
        if (!this.checkParameters(params, accessTokenResponse)) {
            return;
        }

        //클레임을 검증한다.
        if (!this.checkClaim(accessTokenResponse)) {
            return;
        }

        //클라이언트를 검증한다.
        OauthClient oauthClient = oauthClientService.selectByClientKey(accessTokenResponse.getClientId());
        if (!this.checkClient(oauthClient, accessTokenResponse)) {
            return;
        }
        accessTokenResponse.setOauthClient(oauthClient);

        //매니지먼트를 등록한다.
        String managementId = oauthClient.getManagementId();
        Management management = managementService.selectById(managementId);
        accessTokenResponse.setManagement(management);

        //클라이언트가 리프레쉬 토큰을 허용하는지 알아본다.
        if (!"Y".equals(oauthClient.getRefreshTokenValidity())) {
            accessTokenResponse.setError(OauthConstant.UNSUPPORTED_GRANT_TYPE);
            accessTokenResponse.setError_description("Requested client does not support grant_type refresh_token");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //어세스 토큰을 찾는다.
        OauthAccessToken accessToken = oauthTokenService.selectTokenByRefreshToken(accessTokenResponse.getRefreshToken());
        if (accessToken == null) {
            accessTokenResponse.setError(OauthConstant.INVALID_TOKEN);
            accessTokenResponse.setError_description("Requested refresh_token is not exist.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //어세스 토큰의 발급자 확인
        if (!accessToken.getClientId().equals(oauthClient.get_id())) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("client does not have authority to requested refresh_token.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //어세스 토큰의 발급시간을 확인한다.
        Long regDate = accessToken.getRegDate();
        Date expirationTime = new Date(regDate + oauthClient.getRefreshTokenLifetime() * 1000);
        int compareTo = new Date().compareTo(expirationTime);
        if (compareTo > 0) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("requested refresh_token has expired.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //스코프 설정
        accessTokenResponse.setScope(accessToken.getScopes());

        //유저 설정,토큰 타입 설정
        String type;
        if (accessToken.getType().equals("user")) {
            type = "user";
            OauthUser oauthUser = oauthUserService.selectById(accessToken.getOauthUserId());
            accessTokenResponse.setOauthUser(oauthUser);
        } else {
            type = "client";
        }

        //커스텀 토큰 스크립트를 수행한다.
        if (customService.inCase(management, CustomServiceImpl.REFRESH_TOKEN)) {
            boolean value = customService.processTokenScript(management, oauthClient, accessTokenResponse.getOauthUser(), accessTokenResponse.getScope(),
                    accessTokenResponse.getTokenType(), accessTokenResponse.getClaim(), "user");
            if (!value) {
                accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
                accessTokenResponse.setError_description("Access denied by custom token issuance rule");
                this.processRedirect(accessTokenResponse);
                return;
            }
        }

        //어세스 토큰을 만들고 저장한다.
        AccessTokenResponse tokenResponse = this.insertAccessToken(accessTokenResponse, type);

        //리스폰스를 수행한다.
        this.processRedirect(tokenResponse);
    }

    @Override
    public void processCodeGrant(AccessTokenResponse accessTokenResponse) throws Exception {

        //필요한 값을 검증한다.
        String[] params = new String[]{"client_id", "client_secret", "grant_type", "code"};
        if (!this.checkParameters(params, accessTokenResponse)) {
            return;
        }

        //클레임을 검증한다.
        if (!this.checkClaim(accessTokenResponse)) {
            return;
        }

        //클라이언트를 검증한다.
        OauthClient oauthClient = oauthClientService.selectByClientKey(accessTokenResponse.getClientId());
        if (!this.checkClient(oauthClient, accessTokenResponse)) {
            return;
        }
        accessTokenResponse.setOauthClient(oauthClient);

        //매니지먼트를 등록한다.
        String managementId = oauthClient.getManagementId();
        Management management = managementService.selectById(managementId);
        accessTokenResponse.setManagement(management);

        //클라이언트의 그런트 타입 허용 범위를 체크한다.
        List grantTypes = Arrays.asList(oauthClient.getAuthorizedGrantTypes().split(","));
        if (!grantTypes.contains("code")) {
            accessTokenResponse.setError(OauthConstant.UNSUPPORTED_GRANT_TYPE);
            accessTokenResponse.setError_description("Requested client does not support grant_type authorization_code");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //리다이렉트 유알엘을 검증한다.
        //요청된 리다이렉트 유알엘 파라미터가 없으면 미리 등재된 유알엘을 등록한다.
        //미리 등재된 유알엘도 없다면 검증을 실패처리한다.
        if (StringUtils.isEmpty(accessTokenResponse.getRedirectUri())) {
            accessTokenResponse.setRedirectUri(oauthClient.getWebServerRedirectUri());
        }
        params = new String[]{"redirect_uri"};
        if (!this.checkParameters(params, accessTokenResponse)) {
            return;
        }
        //리다이렉트 유알엘이 미리 등재된 유알엘과 같은지 검증한다.
        //리다이렉트 유알엘을 사용자가 파라미터로 등록했을 경우만 해당된다.
        if (!accessTokenResponse.getRedirectUri().equals(oauthClient.getWebServerRedirectUri())) {
            accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
            accessTokenResponse.setError_description("redirect_uri is not match to previously stored redirect_uri.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //코드를 찾는다.
        OauthCode oauthCode = oauthTokenService.selectCodeByCodeAndClientId(accessTokenResponse.getCode(), oauthClient.get_id());
        if (oauthCode == null) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("requested code is not exist.");
            this.processRedirect(accessTokenResponse);
            return;
        }
        //코드의 발급시간을 확인한다.
        Long regDate = oauthCode.getRegDate();
        Date expirationTime = new Date(regDate + oauthClient.getCodeLifetime() * 1000);
        int compareTo = new Date().compareTo(expirationTime);
        if (compareTo > 0) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("requested code has expired.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //유저를 등록한다.
        OauthUser oauthUser = oauthUserService.selectById(oauthCode.getOauthUserId());
        if (oauthUser == null) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("requested user is not exist.");
            this.processRedirect(accessTokenResponse);
            return;
        }
        accessTokenResponse.setOauthUser(oauthUser);

        accessTokenResponse.setScope(oauthCode.getScopes());

        //커스텀 토큰 스크립트를 수행한다.
        if (customService.inCase(management, CustomServiceImpl.CODE)) {
            boolean value = customService.processTokenScript(management, oauthClient, oauthUser, accessTokenResponse.getScope(),
                    accessTokenResponse.getTokenType(), accessTokenResponse.getClaim(), "user");
            if (!value) {
                accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
                accessTokenResponse.setError_description("Access denied by custom token issuance rule");
                this.processRedirect(accessTokenResponse);
                return;
            }
        }

        //어세스 토큰을 만들고 저장한다.
        this.insertAccessToken(accessTokenResponse, "user");

        //리스폰스를 수행한다.
        this.processRedirect(accessTokenResponse);
    }

    @Override
    public void processPasswordGrant(AccessTokenResponse accessTokenResponse) throws Exception {
        //필요한 값을 검증한다.
        String[] params = new String[]{"client_id", "client_secret", "grant_type", "username", "password", "scope"};
        if (!this.checkParameters(params, accessTokenResponse)) {
            return;
        }

        //클레임을 검증한다.
        if (!this.checkClaim(accessTokenResponse)) {
            return;
        }

        //클라이언트를 검증한다.
        OauthClient oauthClient = oauthClientService.selectByClientKey(accessTokenResponse.getClientId());
        if (!this.checkClient(oauthClient, accessTokenResponse)) {
            return;
        }
        accessTokenResponse.setOauthClient(oauthClient);

        //매니지먼트를 등록한다.
        String managementId = oauthClient.getManagementId();
        Management management = managementService.selectById(managementId);
        accessTokenResponse.setManagement(management);

        //클라이언트의 그런트 타입 허용 범위를 체크한다.
        List grantTypes = Arrays.asList(oauthClient.getAuthorizedGrantTypes().split(","));
        if (!grantTypes.contains("password")) {
            accessTokenResponse.setError(OauthConstant.UNSUPPORTED_GRANT_TYPE);
            accessTokenResponse.setError_description("Requested client does not support grant_type password");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //스코프를 검증한다.
        List<OauthScope> clientScopes = oauthScopeService.selectClientScopes(oauthClient.get_id());
        List<OauthScope> requestScopes = new ArrayList<OauthScope>();
        List<String> enabelScopesNames = new ArrayList<>();
        for (int i = 0; i < clientScopes.size(); i++) {
            enabelScopesNames.add(clientScopes.get(i).getName());
        }
        List<String> requestScopesNames = Arrays.asList(accessTokenResponse.getScope().split(","));
        for (int i = 0; i < requestScopesNames.size(); i++) {
            if (!enabelScopesNames.contains(requestScopesNames.get(i))) {
                accessTokenResponse.setError(OauthConstant.INVALID_SCOPE);
                accessTokenResponse.setError_description("Client dost not have requested scope");
                this.processRedirect(accessTokenResponse);
                return;
            } else {
                for (int c = 0; c < clientScopes.size(); c++) {
                    if (clientScopes.get(c).getName().equals(requestScopesNames.get(i))) {
                        requestScopes.add(clientScopes.get(c));
                    }
                }
            }
        }
        accessTokenResponse.setOauthScopes(requestScopes);

        //유저를 찾는다.
        OauthUser oauthUser = oauthUserService.selectByManagementIdAndCredential(management.get_id(), accessTokenResponse.getUsername(), accessTokenResponse.getPassword());
        if (oauthUser == null) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("requested user is not exist.");
            this.processRedirect(accessTokenResponse);
            return;
        }
        accessTokenResponse.setOauthUser(oauthUser);

        //커스텀 토큰 스크립트를 수행한다.
        if (customService.inCase(management, CustomServiceImpl.PASSWORD)) {
            boolean value = customService.processTokenScript(management, oauthClient, oauthUser, accessTokenResponse.getScope(),
                    accessTokenResponse.getTokenType(), accessTokenResponse.getClaim(), "user");
            if (!value) {
                accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
                accessTokenResponse.setError_description("Access denied by custom token issuance rule");
                this.processRedirect(accessTokenResponse);
                return;
            }
        }

        //어세스 토큰을 만들고 저장한다.
        this.insertAccessToken(accessTokenResponse, "user");

        //리스폰스를 수행한다.
        this.processRedirect(accessTokenResponse);
    }

    @Override
    public void processClientCredentialsGrant(AccessTokenResponse accessTokenResponse) throws Exception {
        //필요한 값을 검증한다.
        String[] params = new String[]{"client_id", "client_secret", "grant_type", "scope"};
        if (!this.checkParameters(params, accessTokenResponse)) {
            return;
        }

        //클레임을 검증한다.
        if (!this.checkClaim(accessTokenResponse)) {
            return;
        }

        //클라이언트를 검증한다.
        OauthClient oauthClient = oauthClientService.selectByClientKey(accessTokenResponse.getClientId());
        if (!this.checkClient(oauthClient, accessTokenResponse)) {
            return;
        }
        accessTokenResponse.setOauthClient(oauthClient);

        //매니지먼트를 등록한다.
        String managementId = oauthClient.getManagementId();
        Management management = managementService.selectById(managementId);
        accessTokenResponse.setManagement(management);

        //클라이언트의 그런트 타입 허용 범위를 체크한다.
        List grantTypes = Arrays.asList(oauthClient.getAuthorizedGrantTypes().split(","));
        if (!grantTypes.contains("credentials")) {
            accessTokenResponse.setError(OauthConstant.UNSUPPORTED_GRANT_TYPE);
            accessTokenResponse.setError_description("Requested client does not support grant_type client_credentials");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //스코프를 검증한다.
        List<OauthScope> clientScopes = oauthScopeService.selectClientScopes(oauthClient.get_id());
        List<OauthScope> requestScopes = new ArrayList<OauthScope>();
        List<String> enabelScopesNames = new ArrayList<>();
        for (int i = 0; i < clientScopes.size(); i++) {
            enabelScopesNames.add(clientScopes.get(i).getName());
        }
        List<String> requestScopesNames = Arrays.asList(accessTokenResponse.getScope().split(","));
        for (int i = 0; i < requestScopesNames.size(); i++) {
            if (!enabelScopesNames.contains(requestScopesNames.get(i))) {
                accessTokenResponse.setError(OauthConstant.INVALID_SCOPE);
                accessTokenResponse.setError_description("Client dost not have requested scope");
                this.processRedirect(accessTokenResponse);
                return;
            } else {
                for (int c = 0; c < clientScopes.size(); c++) {
                    if (clientScopes.get(c).getName().equals(requestScopesNames.get(i))) {
                        requestScopes.add(clientScopes.get(c));
                    }
                }
            }
        }
        accessTokenResponse.setOauthScopes(requestScopes);

        //커스텀 토큰 스크립트를 수행한다.
        if (customService.inCase(management, CustomServiceImpl.CREDENTIALS)) {
            boolean value = customService.processTokenScript(management, oauthClient, null, accessTokenResponse.getScope(),
                    accessTokenResponse.getTokenType(), accessTokenResponse.getClaim(), "user");
            if (!value) {
                accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
                accessTokenResponse.setError_description("Access denied by custom token issuance rule");
                this.processRedirect(accessTokenResponse);
                return;
            }
        }

        //어세스 토큰을 만들고 저장한다.
        this.insertAccessToken(accessTokenResponse, "client");

        //리스폰스를 수행한다.
        this.processRedirect(accessTokenResponse);
    }

    @Override
    public void processJWTGrant(AccessTokenResponse accessTokenResponse) throws Exception {
        //필요한 값을 검증한다.
        String[] params = new String[]{"assertion", "scope"};
        if (!this.checkParameters(params, accessTokenResponse)) {
            return;
        }

        //토큰을 파싱한다.
        String jwtToken = accessTokenResponse.getAssertion();
        JWTClaimsSet jwtClaimsSet = null;
        try {
            jwtClaimsSet = JwtUtils.parseToken(jwtToken);
        } catch (Exception ex) {
            accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
            accessTokenResponse.setError_description("incorrect jwt token format.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        String issuer = jwtClaimsSet.getIssuer();

        //TODO 아래 두 값을 검증하는 방법을 찾아봐야 한다.
        Date issueTime = jwtClaimsSet.getIssueTime();
        Date expirationTime = jwtClaimsSet.getExpirationTime();


        //클라이언트를 찾는다.
        accessTokenResponse.setClientId(issuer);
        OauthClient oauthClient = oauthClientService.selectByClientKey(accessTokenResponse.getClientId());
        if (oauthClient == null) {
            accessTokenResponse.setError(OauthConstant.UNAUTHORIZED_CLIENT);
            accessTokenResponse.setError_description("Requested client is not exist.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //Jwt를 검증한다.
        boolean validatedToken = false;
        validatedToken = JwtUtils.validateToken(jwtToken, oauthClient.getClientJwtSecret());
        if (!validatedToken) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("Invalid jwt signature.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //Jwt 타임아웃 체크
        validatedToken = JwtUtils.validateToken(jwtToken, oauthClient.getClientJwtSecret(), expirationTime);
        if (!validatedToken) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("jwt token is expired.");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //클라이언트 액티브를 체크한다.
        if (!"Y".equals(oauthClient.getActiveClient())) {
            accessTokenResponse.setError(OauthConstant.UNAUTHORIZED_CLIENT);
            accessTokenResponse.setError_description("Requested client is not active.");
            this.processRedirect(accessTokenResponse);
            return;
        }
        accessTokenResponse.setOauthClient(oauthClient);

        //매니지먼트를 등록한다.
        String managementId = oauthClient.getManagementId();
        Management management = managementService.selectById(managementId);
        accessTokenResponse.setManagement(management);

        //클라이언트의 그런트 타입 허용 범위를 체크한다.
        List grantTypes = Arrays.asList(oauthClient.getAuthorizedGrantTypes().split(","));
        if (!grantTypes.contains("credentials")) {
            accessTokenResponse.setError(OauthConstant.UNSUPPORTED_GRANT_TYPE);
            accessTokenResponse.setError_description("Requested client does not support grant_type client_credentials");
            this.processRedirect(accessTokenResponse);
            return;
        }

        //스코프를 검증한다.
        List<OauthScope> clientScopes = oauthScopeService.selectClientScopes(oauthClient.get_id());
        List<OauthScope> requestScopes = new ArrayList<OauthScope>();
        List<String> enabelScopesNames = new ArrayList<>();
        for (int i = 0; i < clientScopes.size(); i++) {
            enabelScopesNames.add(clientScopes.get(i).getName());
        }
        List<String> requestScopesNames = Arrays.asList(accessTokenResponse.getScope().split(","));
        for (int i = 0; i < requestScopesNames.size(); i++) {
            if (!enabelScopesNames.contains(requestScopesNames.get(i))) {
                accessTokenResponse.setError(OauthConstant.INVALID_SCOPE);
                accessTokenResponse.setError_description("Client dost not have requested scope");
                this.processRedirect(accessTokenResponse);
                return;
            } else {
                for (int c = 0; c < clientScopes.size(); c++) {
                    if (clientScopes.get(c).getName().equals(requestScopesNames.get(i))) {
                        requestScopes.add(clientScopes.get(c));
                    }
                }
            }
        }
        accessTokenResponse.setOauthScopes(requestScopes);


        //어세스토큰을 만들고 저장한다.
        OauthAccessToken accessToken = new OauthAccessToken();
        accessToken.setType("client");
        accessToken.setScopes(accessTokenResponse.getScope());
        accessToken.setToken(UUID.randomUUID().toString());
        accessToken.setManagementId(management.get_id());
        accessToken.setClientId(oauthClient.get_id());
        if ("Y".equals(oauthClient.getRefreshTokenValidity())) {
            accessToken.setRefreshToken(UUID.randomUUID().toString());
        }

        oauthTokenService.insertToken(accessToken);


        //리스폰스에 리턴값을 세팅한다.
        accessTokenResponse.setTokenType("Bearer");
        accessTokenResponse.setAccessToken(accessToken.getToken());
        accessTokenResponse.setExpiresIn(oauthClient.getAccessTokenLifetime());
        if ("Y".equals(oauthClient.getRefreshTokenValidity())) {
            accessTokenResponse.setRefreshToken(accessToken.getRefreshToken());
        }

        //리스폰스를 수행한다.
        this.processRedirect(accessTokenResponse);
    }

    @Override
    public void processRedirect(AccessTokenResponse accessTokenResponse) {
        try {
            if (accessTokenResponse.getError() != null) {
                Map map = new HashMap();
                map.put("error", accessTokenResponse.getError());
                map.put("error_description", accessTokenResponse.getError_description());

                String marshal = JsonUtils.marshal(map);
                String prettyPrint = JsonFormatterUtils.prettyPrint(marshal);
                System.out.println(prettyPrint);

                HttpServletResponse response = accessTokenResponse.getResponse();

                response.setStatus(400);
                response.setHeader("Content-Type", "application/json;charset=UTF-8");
                response.setHeader("Cache-Control", "no-store");
                response.setHeader("Pragma", "no-cache");
                response.getWriter().write(prettyPrint);
            } else {
                Map map = new HashMap();

                switch (accessTokenResponse.getGrant_type()) {
                    case "authorization_code":
                        map.put("access_token", accessTokenResponse.getAccessToken());
                        map.put("token_type", accessTokenResponse.getTokenType());
                        map.put("expires_in", accessTokenResponse.getExpiresIn());
                        if (!StringUtils.isEmpty(accessTokenResponse.getRefreshToken())) {
                            map.put("refresh_token", accessTokenResponse.getRefreshToken());
                        }
                        break;

                    case "password":
                        map.put("access_token", accessTokenResponse.getAccessToken());
                        map.put("token_type", accessTokenResponse.getTokenType());
                        map.put("expires_in", accessTokenResponse.getExpiresIn());
                        if (!StringUtils.isEmpty(accessTokenResponse.getRefreshToken())) {
                            map.put("refresh_token", accessTokenResponse.getRefreshToken());
                        }
                        break;

                    case "client_credentials":
                        map.put("access_token", accessTokenResponse.getAccessToken());
                        map.put("token_type", accessTokenResponse.getTokenType());
                        map.put("expires_in", accessTokenResponse.getExpiresIn());
                        if (!StringUtils.isEmpty(accessTokenResponse.getRefreshToken())) {
                            map.put("refresh_token", accessTokenResponse.getRefreshToken());
                        }
                        break;

                    case "urn:ietf:params:oauth:grant-type:jwt-bearer":
                        map.put("access_token", accessTokenResponse.getAccessToken());
                        map.put("token_type", accessTokenResponse.getTokenType());
                        map.put("expires_in", accessTokenResponse.getExpiresIn());
                        if (!StringUtils.isEmpty(accessTokenResponse.getRefreshToken())) {
                            map.put("refresh_token", accessTokenResponse.getRefreshToken());
                        }
                        break;

                    case "refresh_token":
                        map.put("access_token", accessTokenResponse.getAccessToken());
                        map.put("token_type", accessTokenResponse.getTokenType());
                        map.put("expires_in", accessTokenResponse.getExpiresIn());
                        map.put("refresh_token", accessTokenResponse.getRefreshToken());
                        break;
                }

                String marshal = JsonUtils.marshal(map);
                String prettyPrint = JsonFormatterUtils.prettyPrint(marshal);
                System.out.println(prettyPrint);

                HttpServletResponse response = accessTokenResponse.getResponse();

                response.setStatus(200);
                response.setHeader("Content-Type", "application/json;charset=UTF-8");
                response.setHeader("Cache-Control", "no-store");
                response.setHeader("Pragma", "no-cache");
                response.getWriter().write(prettyPrint);
            }
        } catch (IOException ex) {
            //response 전달 과정 중 실패가 일어나더라도 프로세스에는 영향을 끼지지 않는다.
        }
    }

    private boolean checkParameters(String[] params, AccessTokenResponse accessTokenResponse) {
        List<String> list = Arrays.asList(params);
        for (int i = 0; i < list.size(); i++) {
            String paramName = list.get(i);
            switch (paramName) {
                case "client_id":
                    if (StringUtils.isEmpty(accessTokenResponse.getClientId())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("client_id is required.");
                    }
                    break;
                case "client_secret":
                    if (StringUtils.isEmpty(accessTokenResponse.getClientSecret())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("client_secret is required.");
                    }
                    break;
                case "grant_type":
                    if (StringUtils.isEmpty(accessTokenResponse.getGrant_type())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("grant_type is required.");
                    }
                    break;
                case "code":
                    if (StringUtils.isEmpty(accessTokenResponse.getCode())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("code is required.");
                    }
                    break;
                case "username":
                    if (StringUtils.isEmpty(accessTokenResponse.getUsername())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("username is required.");
                    }
                    break;
                case "password":
                    if (StringUtils.isEmpty(accessTokenResponse.getPassword())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("password is required.");
                    }
                    break;
                case "scope":
                    if (StringUtils.isEmpty(accessTokenResponse.getScope())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("scope is required.");
                    }
                    break;
                case "redirect_uri":
                    if (StringUtils.isEmpty(accessTokenResponse.getRedirectUri())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("Requested client does not have default redirect_uri. You must set redirect_uri in your parameters.");
                    }
                    break;
                case "assertion":
                    if (StringUtils.isEmpty(accessTokenResponse.getAssertion())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("assertion is required.");
                    }
                    break;
                case "access_token":
                    if (StringUtils.isEmpty(accessTokenResponse.getAccessToken())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("access_token is required.");
                    }
                    break;
                case "refresh_token":
                    if (StringUtils.isEmpty(accessTokenResponse.getRefreshToken())) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("refresh_token is required.");
                    }
                    break;
            }
            if (accessTokenResponse.getError() != null) {
                this.processRedirect(accessTokenResponse);
                return false;
            }
        }
        return true;
    }

    private boolean checkClient(OauthClient oauthClient, AccessTokenResponse accessTokenResponse) {
        if (oauthClient == null) {
            accessTokenResponse.setError(OauthConstant.UNAUTHORIZED_CLIENT);
            accessTokenResponse.setError_description("Requested client is not exist.");
            this.processRedirect(accessTokenResponse);
            return false;
        }

        //클라이언트 액티브를 체크한다.
        if (!"Y".equals(oauthClient.getActiveClient())) {
            accessTokenResponse.setError(OauthConstant.UNAUTHORIZED_CLIENT);
            accessTokenResponse.setError_description("Requested client is not active.");
            this.processRedirect(accessTokenResponse);
            return false;
        }

        //클라이언트 비밀번호를 체크한다.
        if (!oauthClient.getClientSecret().equals(accessTokenResponse.getClientSecret())) {
            accessTokenResponse.setError(OauthConstant.ACCESS_DENIED);
            accessTokenResponse.setError_description("client_secret is not match.");
            this.processRedirect(accessTokenResponse);
            return false;
        }

        return true;
    }

    private boolean checkClaim(AccessTokenResponse accessTokenResponse) {
        String claim = accessTokenResponse.getClaim();
        if (!StringUtils.isEmpty(accessTokenResponse.getTokenType())) {
            if (accessTokenResponse.getTokenType().equals("JWT")) {
                if (!StringUtils.isEmpty(accessTokenResponse.getClaim())) {
                    try {
                        JsonUtils.unmarshal(claim);
                    } catch (IOException ex) {
                        accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                        accessTokenResponse.setError_description("claim for jwt must be a json object string format");
                        this.processRedirect(accessTokenResponse);
                        return false;
                    }
                }
            }
        }
        return true;
    }

    private AccessTokenResponse insertAccessToken(AccessTokenResponse accessTokenResponse, String type) throws Exception {
        //어세스토큰을 만들고 저장한다.
        OauthAccessToken accessToken = new OauthAccessToken();

        if (type.equals("user")) {
            accessToken.setType("user");
            accessToken.setOauthUserId(accessTokenResponse.getOauthUser().get_id());
        } else {
            accessToken.setType("client");
        }
        accessToken.setScopes(accessTokenResponse.getScope());
        accessToken.setToken(UUID.randomUUID().toString());
        accessToken.setManagementId(accessTokenResponse.getManagement().get_id());
        accessToken.setClientId(accessTokenResponse.getOauthClient().get_id());

        if ("Y".equals(accessTokenResponse.getOauthClient().getRefreshTokenValidity())) {
            accessToken.setRefreshToken(UUID.randomUUID().toString());
        }

        //토큰 타입이 명시되지 않으면 배리어이다.
        if (accessTokenResponse.getTokenType() == null) {
            accessTokenResponse.setTokenType("Bearer");
        }

        if (accessTokenResponse.getTokenType().equals("JWT")) {
            String jwtToken = oauthTokenService.generateJWTToken(accessTokenResponse.getOauthUser(),
                    accessTokenResponse.getOauthClient(),
                    accessToken, accessTokenResponse.getClaim(),
                    accessTokenResponse.getOauthClient().getJwtTokenLifetime(), type);
            accessToken.setToken(jwtToken);

            //리스폰스에 리턴값을 세팅한다.
            accessTokenResponse.setTokenType("JWT");
            accessTokenResponse.setAccessToken(accessToken.getToken());
            if ("Y".equals(accessTokenResponse.getOauthClient().getRefreshTokenValidity())) {
                accessTokenResponse.setRefreshToken(accessToken.getRefreshToken());
            }
            accessTokenResponse.setExpiresIn(accessTokenResponse.getOauthClient().getJwtTokenLifetime());
        } else {
            //리스폰스에 리턴값을 세팅한다.
            accessTokenResponse.setTokenType("Bearer");
            accessTokenResponse.setAccessToken(accessToken.getToken());
            if ("Y".equals(accessTokenResponse.getOauthClient().getRefreshTokenValidity())) {
                accessTokenResponse.setRefreshToken(accessToken.getRefreshToken());
            }
            accessTokenResponse.setExpiresIn(accessTokenResponse.getOauthClient().getAccessTokenLifetime());
        }

        oauthTokenService.insertToken(accessToken);

        return accessTokenResponse;
    }
}

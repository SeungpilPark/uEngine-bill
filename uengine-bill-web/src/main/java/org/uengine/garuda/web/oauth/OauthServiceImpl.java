package org.uengine.garuda.web.oauth;

import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.util.HttpUtils;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.configuration.ConfigurationHelper;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.*;

@Service
public class OauthServiceImpl implements OauthService {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthClientService oauthClientService;

    @Autowired
    private ManagementService managementService;

    @Autowired
    private OauthScopeService oauthScopeService;

    @Autowired
    ConfigurationHelper configurationHelper;

    @Autowired
    private OauthUserService oauthUserService;

    @Autowired
    private OauthTokenService oauthTokenService;

    @Autowired
    private OauthGrantService oauthGrantService;

    @Autowired
    private CustomService customService;

    @Override
    public AuthorizeResponse validateAuthorize(HttpServletRequest request) {

        AuthorizeResponse authorizeResponse = new AuthorizeResponse();

        authorizeResponse.setClientId(request.getParameter("client_id"));
        authorizeResponse.setResponseType(request.getParameter("response_type"));
        authorizeResponse.setRedirectUri(request.getParameter("redirect_uri"));
        authorizeResponse.setScope(request.getParameter("scope"));
        authorizeResponse.setState(request.getParameter("state"));
        authorizeResponse.setTokenType(request.getParameter("token_type"));
        authorizeResponse.setClaim(request.getParameter("claim"));

        //필요한 값을 검증한다.
        if (StringUtils.isEmpty(authorizeResponse.getClientId())) {
            authorizeResponse.setError(OauthConstant.INVALID_REQUEST);
            authorizeResponse.setError_description("client_id is required.");
            return authorizeResponse;
        }
        if (StringUtils.isEmpty(authorizeResponse.getResponseType())) {
            authorizeResponse.setError(OauthConstant.INVALID_REQUEST);
            authorizeResponse.setError_description("response_type is required.");
            return authorizeResponse;
        }
        if (StringUtils.isEmpty(authorizeResponse.getScope())) {
            authorizeResponse.setError(OauthConstant.INVALID_REQUEST);
            authorizeResponse.setError_description("scope is required.");
            return authorizeResponse;
        }

        //클라이언트를 얻는다
        OauthClient oauthClient = oauthClientService.selectByClientKey(authorizeResponse.getClientId());
        if (oauthClient == null) {
            authorizeResponse.setError(OauthConstant.UNAUTHORIZED_CLIENT);
            authorizeResponse.setError_description("Requested client is not exist.");
            return authorizeResponse;
        }
        authorizeResponse.setOauthClient(oauthClient);

        //매니지먼트를 등록한다.
        String managementId = oauthClient.getManagementId();
        Management management = managementService.selectById(managementId);
        authorizeResponse.setManagement(management);

        //클라이언트의 리스폰트 타입 허용 범위를 체크한다.
        String responseType = authorizeResponse.getResponseType();
        List grantTypes = Arrays.asList(oauthClient.getAuthorizedGrantTypes().split(","));
        switch (responseType) {
            case "code":
                if (!grantTypes.contains("code")) {
                    authorizeResponse.setError(OauthConstant.UNSUPPORTED_RESPONSE_TYPE);
                    authorizeResponse.setError_description("Requested client does not support response_type code");
                    return authorizeResponse;
                }
                break;
            case "token":
                if (!grantTypes.contains("implicit")) {
                    authorizeResponse.setError(OauthConstant.UNSUPPORTED_RESPONSE_TYPE);
                    authorizeResponse.setError_description("Requested client does not support response_type token");
                    return authorizeResponse;
                }
                break;
            default:
                authorizeResponse.setError(OauthConstant.UNSUPPORTED_RESPONSE_TYPE);
                authorizeResponse.setError_description("response_type must be code or token");
                return authorizeResponse;
        }

        //클레임을 검증한다.
        String claim = authorizeResponse.getClaim();
        if (responseType.equals("token")) {
            if (!StringUtils.isEmpty(authorizeResponse.getTokenType())) {
                if (authorizeResponse.getTokenType().equals("JWT")) {
                    if (!StringUtils.isEmpty(authorizeResponse.getClaim())) {
                        try {
                            JsonUtils.unmarshal(claim);
                        } catch (IOException ex) {
                            authorizeResponse.setError(OauthConstant.INVALID_REQUEST);
                            authorizeResponse.setError_description("claim for jwt must be a url encoded json object string format");
                            return authorizeResponse;
                        }
                    }
                }
            }
        }

        //리다이렉트 유알엘을 검증한다.
        if (StringUtils.isEmpty(authorizeResponse.getRedirectUri())) {
            authorizeResponse.setRedirectUri(oauthClient.getWebServerRedirectUri());
        }
        if (StringUtils.isEmpty(authorizeResponse.getRedirectUri())) {
            authorizeResponse.setError(OauthConstant.INVALID_REQUEST);
            authorizeResponse.setError_description("Requested client does not have default redirect_uri. You must set redirect_uri in your parameters.");
            return authorizeResponse;
        }

        //스코프를 검증한다.
        List<OauthScope> clientScopes = oauthScopeService.selectClientScopes(oauthClient.get_id());
        List<OauthScope> requestScopes = new ArrayList<OauthScope>();
        List<String> enabelScopesNames = new ArrayList<>();
        for (int i = 0; i < clientScopes.size(); i++) {
            enabelScopesNames.add(clientScopes.get(i).getName());
        }
        List<String> requestScopesNames = Arrays.asList(authorizeResponse.getScope().split(","));
        for (int i = 0; i < requestScopesNames.size(); i++) {
            if (!enabelScopesNames.contains(requestScopesNames.get(i))) {
                authorizeResponse.setError(OauthConstant.INVALID_SCOPE);
                authorizeResponse.setError_description("Client dost not have requested scope");
                return authorizeResponse;
            } else {
                for (int c = 0; c < clientScopes.size(); c++) {
                    if (clientScopes.get(c).getName().equals(requestScopesNames.get(i))) {
                        requestScopes.add(clientScopes.get(c));
                    }
                }
            }
        }
        authorizeResponse.setOauthScopes(requestScopes);


        return authorizeResponse;
    }

    @Override
    public void processAccessToken(HttpServletRequest request, HttpServletResponse response) {
        AccessTokenResponse accessTokenResponse = new AccessTokenResponse();

        accessTokenResponse.setClientId(request.getParameter("client_id"));
        accessTokenResponse.setClientSecret(request.getParameter("client_secret"));
        accessTokenResponse.setGrant_type(request.getParameter("grant_type"));
        accessTokenResponse.setCode(request.getParameter("code"));
        accessTokenResponse.setRedirectUri(request.getParameter("redirect_uri"));
        accessTokenResponse.setScope(request.getParameter("scope"));
        accessTokenResponse.setUsername(request.getParameter("username"));
        accessTokenResponse.setPassword(request.getParameter("password"));
        accessTokenResponse.setAssertion(request.getParameter("assertion"));
        accessTokenResponse.setRefreshToken(request.getParameter("refresh_token"));
        accessTokenResponse.setTokenType(request.getParameter("token_type"));
        accessTokenResponse.setClaim(request.getParameter("claim"));
        accessTokenResponse.setResponse(response);

        //grant_type을 검증한다.
        if (StringUtils.isEmpty(accessTokenResponse.getGrant_type())) {
            accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
            accessTokenResponse.setError_description("grant_type is required.");
            oauthGrantService.processRedirect(accessTokenResponse);
            return;
        }

        //gratn_type 별로 프로세스를 수행한다.
        try {
            switch (accessTokenResponse.getGrant_type()) {
                case "authorization_code":
                    oauthGrantService.processCodeGrant(accessTokenResponse);
                    break;

                case "password":
                    oauthGrantService.processPasswordGrant(accessTokenResponse);
                    break;

                case "client_credentials":
                    oauthGrantService.processClientCredentialsGrant(accessTokenResponse);
                    break;

                case "urn:ietf:params:oauth:grant-type:jwt-bearer":
                    oauthGrantService.processJWTGrant(accessTokenResponse);
                    break;

                case "refresh_token":
                    oauthGrantService.processRefreshToken(accessTokenResponse);
                    break;

                default:
                    accessTokenResponse.setError(OauthConstant.INVALID_REQUEST);
                    accessTokenResponse.setError_description("grant_type must be one of authorization_code,password,client_credentials,refresh_token,urn:ietf:params:oauth:grant-type:jwt-bearer");
                    oauthGrantService.processRedirect(accessTokenResponse);
            }
        } catch (Exception ex) {
            accessTokenResponse.setError(OauthConstant.SERVER_ERROR);
            accessTokenResponse.setError_description("server error during access token processing");
            oauthGrantService.processRedirect(accessTokenResponse);
        }
    }

    @Override
    public void responseAuthorize(AuthorizeResponse authorizeResponse) {

        //리다이렉트 URL 이 없는 경우는 실행하지 않는다.
        if (StringUtils.isEmpty(authorizeResponse.getRedirectUri())) {
            return;
        }

        //application/x-www-form-urlencoded 을 이용해 리다이렉트 할 것.
        try {
            //에러를 전달해야 하는경우
            if (authorizeResponse.getError() != null) {

                Map<String, String> headers = new HashMap();
                headers.put("Content-Type", "application/x-www-form-urlencoded");

                Map params = new HashMap();
                params.put("error", authorizeResponse.getError());
                params.put("error_description", authorizeResponse.getError_description());
                params.put("state", authorizeResponse.getState());

                String getQueryString = HttpUtils.createGETQueryString(params);
                String url = authorizeResponse.getRedirectUri();

                HttpResponse response = new HttpUtils().makeRequest("GET", url + getQueryString, null, headers);

                StatusLine statusLine = response.getStatusLine();
                int statusCode = statusLine.getStatusCode();

                if (statusCode != 200) {
                    throw new ServiceException("statusCode" + statusCode + ", while excute" + url);
                }
            }
        } catch (Exception ex) {
            //리다이렉트 전달 과정 중 실패가 일어나더라도 프로세스에는 영향을 끼지지 않는다.
        }
    }

    @Override
    public AuthorizeResponse fetchAuthorize(String managementKey, String clientKey, String userName,
                                            String scopes, String responseType, String redirectUri, String state,
                                            String tokenType, String claim) {

        AuthorizeResponse authorizeResponse = new AuthorizeResponse();

        authorizeResponse.setClientId(clientKey);
        authorizeResponse.setRedirectUri(redirectUri);
        authorizeResponse.setScope(scopes);
        authorizeResponse.setState(state);
        authorizeResponse.setResponseType(responseType);
        authorizeResponse.setTokenType(tokenType);
        authorizeResponse.setClaim(URLDecoder.decode(claim));
        authorizeResponse.setOauthClient(oauthClientService.selectByClientKey(clientKey));
        authorizeResponse.setOauthScopes(oauthScopeService.selectClientScopes(authorizeResponse.getOauthClient().get_id()));
        authorizeResponse.setManagement(managementService.selectByKey(managementKey));
        authorizeResponse.setOauthUser(oauthUserService.selectByManagementIdAndUserName(authorizeResponse.getManagement().get_id(), userName));
        return authorizeResponse;
    }

    @Override
    public void processAuthorize(AuthorizeResponse authorizeResponse, HttpServletResponse response) throws IOException {

        //리다이렉트 유알엘이 있을경우만 수행.
        if (StringUtils.isEmpty(authorizeResponse.getRedirectUri())) {
            return;
        }
        Map params = new HashMap();
        try {
            switch (authorizeResponse.getResponseType()) {
                //코드일경우
                //1. 코드를 만들고 저장.
                //2. 코드와 스테이트를 리턴
                case "code":
                    OauthCode oauthCode = new OauthCode();
                    oauthCode.setManagementId(authorizeResponse.getManagement().get_id());
                    oauthCode.setClientId(authorizeResponse.getOauthClient().get_id());
                    oauthCode.setOauthUserId(authorizeResponse.getOauthUser().get_id());
                    oauthCode.setCode(UUID.randomUUID().toString());
                    oauthCode.setScopes(authorizeResponse.getScope());

                    oauthTokenService.insertCode(oauthCode);

                    params.put("code", oauthCode.getCode());
                    params.put("state", authorizeResponse.getState());

                    break;

                //토큰일경우
                //어세스토큰을 만든다.
                //리스레쉬토큰이 허용될 경우 리프레쉬 토큰도 만든다.
                //access_token,token_type,expires_in,scope,state 리턴
                //토큰 타입은 bearer 이다.
                //토큰 타입이 JWT 일 경우 jwt 토큰 제너레이션
                case "token":

                    OauthAccessToken accessToken = new OauthAccessToken();

                    accessToken.setType("user");
                    accessToken.setScopes(authorizeResponse.getScope());
                    accessToken.setToken(UUID.randomUUID().toString());
                    accessToken.setOauthUserId(authorizeResponse.getOauthUser().get_id());
                    accessToken.setManagementId(authorizeResponse.getManagement().get_id());
                    accessToken.setClientId(authorizeResponse.getOauthClient().get_id());

                    if ("Y".equals(authorizeResponse.getOauthClient().getRefreshTokenValidity())) {
                        accessToken.setRefreshToken(UUID.randomUUID().toString());
                    }

                    if (authorizeResponse.getTokenType().equals("JWT")) {
                        String jwtToken = oauthTokenService.generateJWTToken(
                                authorizeResponse.getOauthUser(), authorizeResponse.getOauthClient(),
                                accessToken, authorizeResponse.getClaim(), authorizeResponse.getOauthClient().getJwtTokenLifetime(), "user");
                        accessToken.setToken(jwtToken);

                        params.put("token_type", "JWT");
                        params.put("expires_in", authorizeResponse.getOauthClient().getJwtTokenLifetime());
                    } else {
                        params.put("token_type", "Bearer");
                        params.put("expires_in", authorizeResponse.getOauthClient().getAccessTokenLifetime());
                    }

                    Management management = authorizeResponse.getManagement();
                    OauthClient oauthClient = authorizeResponse.getOauthClient();
                    OauthUser oauthUser = authorizeResponse.getOauthUser();
                    String scope = authorizeResponse.getScope();

                    //커스텀 토큰 스크립트를 수행한다.
                    if (customService.inCase(management, CustomServiceImpl.IMPLICIT)) {
                        boolean value = customService.processTokenScript(management, oauthClient, oauthUser, scope,
                                authorizeResponse.getTokenType(), authorizeResponse.getClaim(), "user");
                        if (!value) {
                            params.put("error", OauthConstant.ACCESS_DENIED);
                            params.put("error_description", "Access denied by custom token issuance rule");
                            params.put("state", authorizeResponse.getState());
                            break;
                        }
                    }

                    oauthTokenService.insertToken(accessToken);

                    params.put("access_token", accessToken.getToken());
                    params.put("scope", authorizeResponse.getScope());
                    params.put("state", authorizeResponse.getState());

                    break;

                default:
                    params.put("error", OauthConstant.SERVER_ERROR);
                    params.put("error_description", "Server can not process authorize");
                    params.put("state", authorizeResponse.getState());

                    break;
            }
        } catch (Exception ex) {
            params.put("error", OauthConstant.SERVER_ERROR);
            params.put("error_description", "Server can not process authorize");
            params.put("state", authorizeResponse.getState());
        }

        response.setHeader("Content-Type", "application/x-www-form-urlencoded");
        String getQueryString = HttpUtils.createGETQueryString(params);
        String url = authorizeResponse.getRedirectUri();
        response.sendRedirect(url + getQueryString);
    }

    @Override
    public void processTokenInfo(HttpServletRequest request, HttpServletResponse response) {

        AccessTokenResponse accessTokenResponse = new AccessTokenResponse();

        accessTokenResponse.setAccessToken(request.getParameter("access_token"));
        accessTokenResponse.setResponse(response);

        try {
            oauthGrantService.processTokenInfo(accessTokenResponse);
        } catch (Exception ex) {
            accessTokenResponse.setError(OauthConstant.SERVER_ERROR);
            accessTokenResponse.setError_description("server error during access token processing");
            oauthGrantService.processRedirect(accessTokenResponse);
        }
    }
}

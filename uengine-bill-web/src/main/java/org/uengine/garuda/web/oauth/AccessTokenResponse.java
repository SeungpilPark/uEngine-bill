package org.uengine.garuda.web.oauth;

import org.uengine.garuda.web.console.oauthclient.OauthClient;
import org.uengine.garuda.web.console.oauthscope.OauthScope;
import org.uengine.garuda.web.console.oauthuser.OauthUser;
import org.uengine.garuda.web.management.Management;

import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.util.List;

/**
 * Created by uengine on 2016. 4. 15..
 */
public class AccessTokenResponse implements Serializable {
    private String clientId;
    private String clientSecret;
    private String grant_type;
    private String redirectUri;
    private String code;
    private String scope;
    private String state;
    private String username;
    private String password;
    private String accessToken;
    private String tokenType;
    private String claim;
    private String assertion;
    private Integer expiresIn;
    private String refreshToken;
    private OauthClient oauthClient;
    private List<OauthScope> oauthScopes;
    private Management management;
    private OauthUser oauthUser;
    private HttpServletResponse response;

    private String error;
    private String error_description;

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getClientSecret() {
        return clientSecret;
    }

    public void setClientSecret(String clientSecret) {
        this.clientSecret = clientSecret;
    }

    public String getGrant_type() {
        return grant_type;
    }

    public void setGrant_type(String grant_type) {
        this.grant_type = grant_type;
    }

    public String getRedirectUri() {
        return redirectUri;
    }

    public void setRedirectUri(String redirectUri) {
        this.redirectUri = redirectUri;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public String getClaim() {
        return claim;
    }

    public void setClaim(String claim) {
        this.claim = claim;
    }

    public String getAssertion() {
        return assertion;
    }

    public void setAssertion(String assertion) {
        this.assertion = assertion;
    }

    public Integer getExpiresIn() {
        return expiresIn;
    }

    public void setExpiresIn(Integer expiresIn) {
        this.expiresIn = expiresIn;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public OauthClient getOauthClient() {
        return oauthClient;
    }

    public void setOauthClient(OauthClient oauthClient) {
        this.oauthClient = oauthClient;
    }

    public List<OauthScope> getOauthScopes() {
        return oauthScopes;
    }

    public void setOauthScopes(List<OauthScope> oauthScopes) {
        this.oauthScopes = oauthScopes;
    }

    public Management getManagement() {
        return management;
    }

    public void setManagement(Management management) {
        this.management = management;
    }

    public OauthUser getOauthUser() {
        return oauthUser;
    }

    public void setOauthUser(OauthUser oauthUser) {
        this.oauthUser = oauthUser;
    }

    public HttpServletResponse getResponse() {
        return response;
    }

    public void setResponse(HttpServletResponse response) {
        this.response = response;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getError_description() {
        return error_description;
    }

    public void setError_description(String error_description) {
        this.error_description = error_description;
    }

    @Override
    public String toString() {
        return "AccessTokenResponse{" +
                "clientId='" + clientId + '\'' +
                ", clientSecret='" + clientSecret + '\'' +
                ", grant_type='" + grant_type + '\'' +
                ", redirectUri='" + redirectUri + '\'' +
                ", code='" + code + '\'' +
                ", scope='" + scope + '\'' +
                ", state='" + state + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", accessToken='" + accessToken + '\'' +
                ", tokenType='" + tokenType + '\'' +
                ", claim='" + claim + '\'' +
                ", assertion='" + assertion + '\'' +
                ", expiresIn=" + expiresIn +
                ", refreshToken='" + refreshToken + '\'' +
                ", oauthClient=" + oauthClient +
                ", oauthScopes=" + oauthScopes +
                ", management=" + management +
                ", oauthUser=" + oauthUser +
                ", response=" + response +
                ", error='" + error + '\'' +
                ", error_description='" + error_description + '\'' +
                '}';
    }
}

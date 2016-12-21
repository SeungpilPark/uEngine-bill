package org.uengine.garuda.web.oauth;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface OauthService {

    AuthorizeResponse validateAuthorize(HttpServletRequest request);

    void responseAuthorize(AuthorizeResponse authorizeResponse);

    AuthorizeResponse fetchAuthorize(String managementKey, String clientKey, String userName,
                                     String scopes, String responseType, String redirectUri, String state,
                                     String tokenType, String claim);

    void processAuthorize(AuthorizeResponse authorizeResponse, HttpServletResponse response) throws IOException;

    void processAccessToken(HttpServletRequest request, HttpServletResponse response);

    void processTokenInfo(HttpServletRequest request, HttpServletResponse response);
}

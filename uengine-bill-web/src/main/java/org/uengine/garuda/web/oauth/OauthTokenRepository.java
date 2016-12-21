package org.uengine.garuda.web.oauth;

public interface OauthTokenRepository {

    OauthCode insertCode(OauthCode oauthCode);

    OauthCode selectCodeById(String id);

    OauthCode selectCodeByCode(String code);

    OauthCode selectCodeByCodeAndClientId(String code, String clientId);

    void deleteCodeById(String id);

    OauthAccessToken insertToken(OauthAccessToken oauthAccessToken);

    OauthAccessToken selectTokenById(String id);

    OauthAccessToken selectTokenByToken(String token);

    OauthAccessToken selectTokenByRefreshToken(String refreshToken);

    OauthAccessToken selectTokenByManagementIdAndId(String managementId, String id);

    OauthAccessToken updateTokenById(OauthAccessToken oauthAccessToken);

    void deleteTokenById(String id);

}

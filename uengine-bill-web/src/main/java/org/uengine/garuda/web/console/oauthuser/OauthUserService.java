package org.uengine.garuda.web.console.oauthuser;

import java.util.List;

public interface OauthUserService {

    OauthUser selectById(String id);

    List<OauthUser> selectAllByManagementId(String managementId);

    List<OauthUser> selectByManagementId(String managementId, int limit, Long skip);

    List<OauthUser> selectByManagementLikeUserName(String managementId, String userName, int limit, Long skip);


    Long countAllByManagementId(String managementId);

    Long countAllByManagementIdLikeUserName(String managementId, String userName);


    OauthUser selectByManagementIdAndUserName(String managementId, String userName);

    OauthUser selectByManagementIdAndCredential(String managementId, String userName, String userPassword);

    OauthUser selectByManagementIdAndId(String managementId, String id);

    OauthUser updateById(String id, String userName, String userPassword, Integer level);

    OauthUser updateById(OauthUser oauthUser);

    void deleteById(String id);

    OauthUser createUser(String managementId, OauthUser oauthUser);

    OauthSessionToken validateSessionToken(String sessionToken) throws Exception;

    OauthScopeToken validateScopeToken(String scopeToken) throws Exception;

    OauthSessionToken generateSessionToken(String managementKey, String userName, String userPassword) throws Exception;

    OauthScopeToken generateScopeToken(String managementKey, String userName, String clientKey, String scopes) throws Exception;
}

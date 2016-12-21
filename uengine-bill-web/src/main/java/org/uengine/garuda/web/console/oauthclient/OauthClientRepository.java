package org.uengine.garuda.web.console.oauthclient;

import java.util.List;

public interface OauthClientRepository {

    OauthClient insert(OauthClient OauthClient);

    OauthClient selectById(String id);


    List<OauthClient> selectAllByManagementId(String managementId);

    List<OauthClient> selectByManagementId(String managementId, int limit, Long skip);

    List<OauthClient> selectByManagementLikeClientName(String managementId, String clientName, int limit, Long skip);


    Long countAllByManagementId(String managementId);

    Long countAllByManagementIdLikeClientName(String managementId, String clientName);


    OauthClient selectByManagementIdAndName(String managementId, String name);

    OauthClient selectByManagementIdAndId(String managementId, String id);

    OauthClient selectByClientKey(String clientKey);

    OauthClient selectByClientKeyAndSecret(String clientKey, String clientSecret);

    OauthClient updateById(OauthClient OauthClient);

    void deleteById(String id);
}

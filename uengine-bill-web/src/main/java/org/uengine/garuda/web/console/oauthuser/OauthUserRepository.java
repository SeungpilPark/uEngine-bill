package org.uengine.garuda.web.console.oauthuser;

import java.util.List;

public interface OauthUserRepository {
    String NAMESPACE = OauthUserRepository.class.getName();

    OauthUser insert(OauthUser oauthUser);

    OauthUser selectById(String id);

    List<OauthUser> selectAllByManagementId(String managementId);

    List<OauthUser> selectByManagementId(String managementId, int limit, Long skip);

    List<OauthUser> selectByManagementLikeUserName(String managementId, String userName, int limit, Long skip);

    Long countAllByManagementId(String managementId);

    Long countAllByManagementIdLikeUserName(String managementId, String userName);

    OauthUser selectByManagementIdAndUserName(String managementId, String userName);

    OauthUser selectByManagementIdAndCredential(String managementId, String userName, String userPassword);

    OauthUser selectByManagementIdAndId(String managementId, String id);

    OauthUser updateById(OauthUser oauthUser);

    void deleteById(String id);
}

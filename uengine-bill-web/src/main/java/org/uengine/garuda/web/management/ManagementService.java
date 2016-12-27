package org.uengine.garuda.web.management;

import java.util.List;

public interface ManagementService {

    List<Management> selectAllByUserId(String userId);

    Management selectById(String id);

    Management selectByKey(String managementKey);

    Management selectByUserIdAndId(String userId, String id);

    Management selectByCredential(String managementKey, String managementSecret);

    Management createManagement(String userId, String managementName, String description, Integer sessionTokenLifetime, Integer scopeCheckLifetime);

    void deleteById(String id);

    Management updateById(Management management);

    Management updateById(String userId, String id, String managementName, String description, Integer sessionTokenLifetime, Integer scopeCheckLifetime);


    List<Management> selectByUserId(String userId, int limit, Long skip);

    List<Management> selectByUserIdLikeManagementName(String userId, String managementName, int limit, Long skip);


    Long countAllByUserId(String userId);

    Long countAllByUserIdLikeManagementName(String userId, String managementName);
}

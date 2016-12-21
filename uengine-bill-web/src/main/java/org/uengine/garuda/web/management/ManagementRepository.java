package org.uengine.garuda.web.management;

import java.util.List;

public interface ManagementRepository {
    List<Management> selectAllByUserId(String userId);

    Management insert(Management management);

    Management selectById(String id);

    Management selectByKey(String managementKey);

    Management selectByUserIdAndId(String userId, String id);

    List<Management> selectByUserId(String userId);

    Management selectByCredential(String managementKey, String managementSecret);

    Management updateById(String id, String managementName, String description, Integer sessionTokenLifetime, Integer scopeCheckLifetime);

    Management updateById(Management management);

    void deleteById(String id);


    List<Management> selectByUserId(String userId, int limit, Long skip);

    List<Management> selectByUserIdLikeManagementName(String userId, String managementName, int limit, Long skip);


    Long countAllByUserId(String userId);

    Long countAllByUserIdLikeManagementName(String userId, String managementName);
}

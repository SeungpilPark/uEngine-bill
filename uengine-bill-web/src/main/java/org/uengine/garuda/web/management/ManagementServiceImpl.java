package org.uengine.garuda.web.management;

import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.web.configuration.ConfigurationHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Properties;
import java.util.UUID;

@Service
public class ManagementServiceImpl implements ManagementService {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private ManagementRepository managementRepository;

    @Autowired
    ConfigurationHelper configurationHelper;


    @Override
    public List<Management> selectAllByUserId(String userId) {
        return managementRepository.selectAllByUserId(userId);
    }

    @Override
    public Management selectById(String id) {
        return managementRepository.selectById(id);
    }

    @Override
    public Management selectByKey(String managementKey) {
        return managementRepository.selectByKey(managementKey);
    }

    @Override
    public Management selectByUserIdAndId(String userId, String id) {
        return managementRepository.selectByUserIdAndId(userId, id);
    }

    @Override
    public Management selectByCredential(String managementKey, String managementSecret) {
        return managementRepository.selectByCredential(managementKey, managementSecret);
    }

    @Override
    public Management createManagement(String userId, String managementName, String description, Integer sessionTokenLifetime, Integer scopeCheckLifetime) {
        Management management = new Management();
        management.setUserId(userId);
        management.setManagementName(managementName);
        management.setDescription(description);
        management.setSessionTokenLifetime(sessionTokenLifetime);
        management.setScopeCheckLifetime(scopeCheckLifetime);

        //클라이언트 키
        String Key = UUID.randomUUID().toString();
        String Secret = UUID.randomUUID().toString();
        String JwtSecret = UUID.randomUUID().toString();

        management.setManagementKey(Key);
        management.setManagementSecret(Secret);
        management.setManagementJwtSecret(JwtSecret);

        return managementRepository.insert(management);
    }

    @Override
    public void deleteById(String id) {
        managementRepository.deleteById(id);
    }

    @Override
    public Management updateById(Management management) {
        return managementRepository.updateById(management);
    }

    @Override
    public Management updateById(String userId, String id, String managementName, String description, Integer sessionTokenLifetime, Integer scopeCheckLifetime) {
        Management management = this.selectByUserIdAndId(userId, id);
        if (management == null) {
            throw new ServiceException("Invalid management id");
        }

        return managementRepository.updateById(id, managementName, description, sessionTokenLifetime, scopeCheckLifetime);
    }

    @Override
    public List<Management> selectByUserId(String userId, int limit, Long skip) {
        return managementRepository.selectByUserId(userId, limit, skip);
    }

    @Override
    public List<Management> selectByUserIdLikeManagementName(String userId, String managementName, int limit, Long skip) {
        return managementRepository.selectByUserIdLikeManagementName(userId, managementName, limit, skip);
    }

    @Override
    public Long countAllByUserId(String userId) {
        return managementRepository.countAllByUserId(userId);
    }

    @Override
    public Long countAllByUserIdLikeManagementName(String userId, String managementName) {
        return managementRepository.countAllByUserIdLikeManagementName(userId, managementName);
    }
}

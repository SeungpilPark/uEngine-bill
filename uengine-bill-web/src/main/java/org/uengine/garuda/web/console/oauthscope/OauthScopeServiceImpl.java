package org.uengine.garuda.web.console.oauthscope;

import org.uengine.garuda.web.configuration.ConfigurationHelper;
import org.uengine.garuda.web.console.oauthclient.OauthClientScopes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Properties;

@Service
public class OauthScopeServiceImpl implements OauthScopeService {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthScopeRepository oauthScopeRepository;

    @Autowired
    ConfigurationHelper configurationHelper;

    @Override
    public OauthScope selectById(String id) {
        return oauthScopeRepository.selectById(id);
    }

    @Override
    public List<OauthScope> selectAllByManagementId(String managementId) {
        return oauthScopeRepository.selectAllByManagementId(managementId);
    }

    @Override
    public List<OauthScope> selectByManagementId(String managementId, int limit, Long skip) {
        return oauthScopeRepository.selectByManagementId(managementId, limit, skip);
    }

    @Override
    public List<OauthScope> selectByManagementLikeScopeName(String managementId, String userName, int limit, Long skip) {
        return oauthScopeRepository.selectByManagementLikeScopeName(managementId, userName, limit, skip);
    }

    @Override
    public Long countAllByManagementId(String managementId) {
        return oauthScopeRepository.countAllByManagementId(managementId);
    }

    @Override
    public Long countAllByManagementIdLikeScopeName(String managementId, String userName) {
        return oauthScopeRepository.countAllByManagementIdLikeScopeName(managementId, userName);
    }

    @Override
    public OauthScope selectByManagementIdAndName(String managementId, String name) {
        return oauthScopeRepository.selectByManagementIdAndName(managementId, name);
    }

    @Override
    public OauthScope selectByManagementIdAndId(String managementId, String id) {
        return oauthScopeRepository.selectByManagementIdAndId(managementId, id);
    }

    @Override
    public OauthScope updateById(String id, String name, String description) {
        OauthScope OauthScope = new OauthScope();
        OauthScope.set_id(id);
        OauthScope.setName(name);
        OauthScope.setDescription(description);
        return oauthScopeRepository.updateById(OauthScope);
    }

    @Override
    public OauthScope updateById(OauthScope oauthScope) {
        return oauthScopeRepository.updateById(oauthScope);
    }

    @Override
    public void deleteById(String id) {
        oauthScopeRepository.deleteById(id);
    }

    @Override
    public OauthScope createScope(String managementId, String name, String description) {
        OauthScope OauthScope = new OauthScope();
        OauthScope.setManagementId(managementId);
        OauthScope.setName(name);
        OauthScope.setDescription(description);
        oauthScopeRepository.insert(OauthScope);

        return OauthScope;
    }

    @Override
    public OauthClientScopes insertClientScopes(OauthClientScopes oauthClientScopes) {
        return oauthScopeRepository.insertClientScopes(oauthClientScopes);
    }

    @Override
    public List<OauthScope> selectClientScopes(String clientId) {
        return oauthScopeRepository.selectClientScopes(clientId);
    }

    @Override
    public OauthScope selectClientScopesByScopeId(String clientId, String scopeId) {
        return oauthScopeRepository.selectClientScopesByScopeId(clientId, scopeId);
    }

    @Override
    public void deleteClientScopes(String clientId){
        oauthScopeRepository.deleteClientScopes(clientId);
    }

    @Override
    public void deleteClientScopesByScopeId(String clientId, String scopeId) {
        oauthScopeRepository.deleteClientScopesByScopeId(clientId, scopeId);
    }
}

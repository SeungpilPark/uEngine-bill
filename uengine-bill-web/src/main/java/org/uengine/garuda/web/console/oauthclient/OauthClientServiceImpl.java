package org.uengine.garuda.web.console.oauthclient;

import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.configuration.ConfigurationHelper;
import org.uengine.garuda.web.console.oauthscope.OauthScopeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Properties;
import java.util.UUID;

@Service
public class OauthClientServiceImpl implements OauthClientService {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthClientRepository oauthClientRepository;

    @Autowired
    private OauthScopeService oauthScopeService;

    @Autowired
    ConfigurationHelper configurationHelper;

    private String TRUST_CLIENT_TYPE = "trust";

    @Override
    public OauthClient selectById(String id) {
        return oauthClientRepository.selectById(id);
    }

    @Override
    public List<OauthClient> selectAllByManagementId(String managementId) {
        return oauthClientRepository.selectAllByManagementId(managementId);
    }

    @Override
    public List<OauthClient> selectByManagementId(String managementId, int limit, Long skip) {
        return oauthClientRepository.selectByManagementId(managementId, limit, skip);
    }

    @Override
    public List<OauthClient> selectByManagementLikeClientName(String managementId, String clientName, int limit, Long skip) {
        return oauthClientRepository.selectByManagementLikeClientName(managementId, clientName, limit, skip);
    }

    @Override
    public Long countAllByManagementId(String managementId) {
        return oauthClientRepository.countAllByManagementId(managementId);
    }

    @Override
    public Long countAllByManagementIdLikeClientName(String managementId, String clientName) {
        return oauthClientRepository.countAllByManagementIdLikeClientName(managementId, clientName);
    }

    @Override
    public OauthClient selectByManagementIdAndName(String managementId, String name) {
        return oauthClientRepository.selectByManagementIdAndName(managementId, name);
    }

    @Override
    public OauthClient selectByManagementIdAndId(String managementId, String id) {
        return oauthClientRepository.selectByManagementIdAndId(managementId, id);
    }

    @Override
    public OauthClient selectByClientKey(String clientKey) {
        return oauthClientRepository.selectByClientKey(clientKey);
    }

    @Override
    public OauthClient selectByClientKeyAndSecret(String clientKey, String clientSecret) {
        return oauthClientRepository.selectByClientKeyAndSecret(clientKey, clientSecret);
    }

    @Override
    public OauthClient updateById(String id, String name, String description, String clientTrust, String clientType, String activeClient,
                                  String authorizedGrantTypes, String webServerRedirectUri, String refreshTokenValidity,
                                  Integer codeLifetime, Integer refreshTokenLifetime,
                                  Integer accessTokenLifetime, Integer jwtTokenLifetime, String scopes) {
        OauthClient oauthClient = new OauthClient();
        oauthClient.set_id(id);
        oauthClient.setName(name);
        oauthClient.setDescription(description);
        oauthClient.setClientTrust(clientTrust);
        oauthClient.setClientType(clientType);
        oauthClient.setActiveClient(activeClient);
        oauthClient.setAuthorizedGrantTypes(authorizedGrantTypes);
        oauthClient.setWebServerRedirectUri(webServerRedirectUri);
        oauthClient.setRefreshTokenValidity(refreshTokenValidity);
        oauthClient.setCodeLifetime(codeLifetime);
        oauthClient.setRefreshTokenLifetime(refreshTokenLifetime);
        oauthClient.setAccessTokenLifetime(accessTokenLifetime);
        oauthClient.setJwtTokenLifetime(jwtTokenLifetime);

        OauthClient update = oauthClientRepository.updateById(oauthClient);

        //스코프 처리
        oauthScopeService.deleteClientScopes(oauthClient.get_id());
        if (!StringUtils.isEmpty(scopes)) {
            String[] split = scopes.split(",");
            for (int i = 0; i < split.length; i++) {
                String scope = split[i];
                OauthClientScopes oauthClientScopes = new OauthClientScopes();
                oauthClientScopes.setClientId(oauthClient.get_id());
                oauthClientScopes.setScopeId(scope);
                oauthScopeService.insertClientScopes(oauthClientScopes);
            }
        }
        return update;
    }

    @Override
    public OauthClient updateById(OauthClient oauthClient) {
        return oauthClientRepository.updateById(oauthClient);
    }

    @Override
    public OauthClient createClient(String managementId, String name, String description, String clientTrust, String clientType, String activeClient,
                                    String authorizedGrantTypes, String webServerRedirectUri, String refreshTokenValidity,
                                    Integer codeLifetime, Integer refreshTokenLifetime,
                                    Integer accessTokenLifetime, Integer jwtTokenLifetime, String scopes) {

        OauthClient oauthClient = new OauthClient();
        oauthClient.setManagementId(managementId);

        oauthClient.setClientKey(UUID.randomUUID().toString());
        oauthClient.setClientSecret(UUID.randomUUID().toString());
        oauthClient.setClientJwtSecret(UUID.randomUUID().toString());

        oauthClient.setName(name);
        oauthClient.setDescription(description);
        oauthClient.setClientTrust(clientTrust);
        oauthClient.setClientType(clientType);
        oauthClient.setActiveClient(activeClient);
        oauthClient.setAuthorizedGrantTypes(authorizedGrantTypes);
        oauthClient.setWebServerRedirectUri(webServerRedirectUri);
        oauthClient.setRefreshTokenValidity(refreshTokenValidity);
        oauthClient.setCodeLifetime(codeLifetime);
        oauthClient.setRefreshTokenLifetime(refreshTokenLifetime);
        oauthClient.setAccessTokenLifetime(accessTokenLifetime);
        oauthClient.setJwtTokenLifetime(jwtTokenLifetime);
        OauthClient insert = oauthClientRepository.insert(oauthClient);

        //스코프 처리
        if (!StringUtils.isEmpty(scopes)) {
            String[] split = scopes.split(",");
            for (int i = 0; i < split.length; i++) {
                String scope = split[i];
                OauthClientScopes oauthClientScopes = new OauthClientScopes();
                oauthClientScopes.setClientId(insert.get_id());
                oauthClientScopes.setScopeId(scope);
                oauthScopeService.insertClientScopes(oauthClientScopes);
            }
        }

        return oauthClient;
    }

    @Override
    public void deleteById(String id) {
        oauthClientRepository.deleteById(id);
    }
}

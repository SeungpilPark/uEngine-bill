package org.uengine.garuda.web.console.oauthclient;

import org.uengine.garuda.couchdb.CouchDAO;

/**
 * Created by uengine on 2016. 4. 15..
 */
public class OauthClientScopes extends CouchDAO {

    private String clientId;
    private String scopeId;
    private Long regDate;
    private Long updDate;
    private String name;
    private String description;

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getScopeId() {
        return scopeId;
    }

    public void setScopeId(String scopeId) {
        this.scopeId = scopeId;
    }

    public Long getRegDate() {
        return regDate;
    }

    public void setRegDate(Long regDate) {
        this.regDate = regDate;
    }

    public Long getUpdDate() {
        return updDate;
    }

    public void setUpdDate(Long updDate) {
        this.updDate = updDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "OauthClientScopes{" +
                "clientId='" + clientId + '\'' +
                ", scopeId='" + scopeId + '\'' +
                ", regDate=" + regDate +
                ", updDate=" + updDate +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}

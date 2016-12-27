package org.uengine.garuda.web.management;

import org.uengine.garuda.couchdb.CouchDAO;

/**
 * Created by uengine on 2015. 6. 3..
 */
public class Management extends CouchDAO {

    private String userId;
    private String managementName;
    private String managementKey;
    private String managementSecret;
    private String managementJwtSecret;
    private Integer sessionTokenLifetime;
    private Integer scopeCheckLifetime;
    private String description;
    private String useCustomTokenIssuance;
    private String customTokenIssuance;
    private Long regDate;
    private Long updDate;

    public Management() {

    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getManagementName() {
        return managementName;
    }

    public void setManagementName(String managementName) {
        this.managementName = managementName;
    }

    public String getManagementKey() {
        return managementKey;
    }

    public void setManagementKey(String managementKey) {
        this.managementKey = managementKey;
    }

    public String getManagementSecret() {
        return managementSecret;
    }

    public void setManagementSecret(String managementSecret) {
        this.managementSecret = managementSecret;
    }

    public String getManagementJwtSecret() {
        return managementJwtSecret;
    }

    public void setManagementJwtSecret(String managementJwtSecret) {
        this.managementJwtSecret = managementJwtSecret;
    }

    public Integer getSessionTokenLifetime() {
        return sessionTokenLifetime;
    }

    public void setSessionTokenLifetime(Integer sessionTokenLifetime) {
        this.sessionTokenLifetime = sessionTokenLifetime;
    }

    public Integer getScopeCheckLifetime() {
        return scopeCheckLifetime;
    }

    public void setScopeCheckLifetime(Integer scopeCheckLifetime) {
        this.scopeCheckLifetime = scopeCheckLifetime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUseCustomTokenIssuance() {
        return useCustomTokenIssuance;
    }

    public void setUseCustomTokenIssuance(String useCustomTokenIssuance) {
        this.useCustomTokenIssuance = useCustomTokenIssuance;
    }

    public String getCustomTokenIssuance() {
        return customTokenIssuance;
    }

    public void setCustomTokenIssuance(String customTokenIssuance) {
        this.customTokenIssuance = customTokenIssuance;
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

    @Override
    public String toString() {
        return "Management{" +
                "userId='" + userId + '\'' +
                ", managementName='" + managementName + '\'' +
                ", managementKey='" + managementKey + '\'' +
                ", managementSecret='" + managementSecret + '\'' +
                ", managementJwtSecret='" + managementJwtSecret + '\'' +
                ", sessionTokenLifetime=" + sessionTokenLifetime +
                ", scopeCheckLifetime=" + scopeCheckLifetime +
                ", description='" + description + '\'' +
                ", useCustomTokenIssuance='" + useCustomTokenIssuance + '\'' +
                ", customTokenIssuance='" + customTokenIssuance + '\'' +
                ", regDate=" + regDate +
                ", updDate=" + updDate +
                '}';
    }
}

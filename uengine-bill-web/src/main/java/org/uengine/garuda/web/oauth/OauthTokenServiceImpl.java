package org.uengine.garuda.web.oauth;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSSigner;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import org.uengine.garuda.util.JsonUtils;
import org.uengine.garuda.util.StringUtils;
import org.uengine.garuda.web.console.oauthclient.OauthClient;
import org.uengine.garuda.web.console.oauthuser.OauthUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Service
public class OauthTokenServiceImpl implements OauthTokenService {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private OauthTokenRepository oauthTokenRepository;

    @Override
    public OauthCode insertCode(OauthCode oauthCode) {
        return oauthTokenRepository.insertCode(oauthCode);
    }

    @Override
    public OauthCode selectCodeById(String id) {
        return oauthTokenRepository.selectCodeById(id);
    }

    @Override
    public OauthCode selectCodeByCode(String code) {
        return oauthTokenRepository.selectCodeByCode(code);
    }

    @Override
    public OauthCode selectCodeByCodeAndClientId(String code, String clientId) {
        return oauthTokenRepository.selectCodeByCodeAndClientId(code, clientId);
    }

    @Override
    public void deleteCodeById(String id) {
        oauthTokenRepository.deleteCodeById(id);
    }

    @Override
    public OauthAccessToken insertToken(OauthAccessToken oauthAccessToken) {
        oauthTokenRepository.insertToken(oauthAccessToken);
        return oauthAccessToken;
    }

    @Override
    public OauthAccessToken selectTokenById(String id) {
        return oauthTokenRepository.selectTokenById(id);
    }

    @Override
    public OauthAccessToken selectTokenByToken(String token) {
        return oauthTokenRepository.selectTokenByToken(token);
    }

    @Override
    public OauthAccessToken selectTokenByRefreshToken(String refreshToken) {
        return oauthTokenRepository.selectTokenByRefreshToken(refreshToken);
    }

    @Override
    public OauthAccessToken selectTokenByManagementIdAndId(String managementId, String id) {
        return oauthTokenRepository.selectTokenByManagementIdAndId(managementId, id);
    }

    @Override
    public OauthAccessToken updateTokenById(OauthAccessToken oauthAccessToken) {
        return oauthTokenRepository.updateTokenById(oauthAccessToken);
    }

    @Override
    public void deleteTokenById(String id) {
        oauthTokenRepository.deleteTokenById(id);
    }

    @Override
    public String generateJWTToken(OauthUser oauthUser, OauthClient oauthClient, OauthAccessToken accessToken, String claimJson, Integer lifetime, String type) throws Exception {

        //발급 시간
        Date issueTime = new Date();

        //만료시간
        Date expirationTime = new Date(new Date().getTime() + lifetime * 1000);

        //발급자
        String issuer = config.getProperty("security.jwt.issuer");

        //시그네이쳐 설정
        String sharedSecret = config.getProperty("security.jwt.secret");
        JWSSigner signer = new MACSigner(sharedSecret);

        //콘텍스트 설정
        Map context = new HashMap();

        if(type.equals("user")){
            context.put("managementId", accessToken.getManagementId());
            context.put("clientId", accessToken.getClientId());
            context.put("clientKey", oauthClient.getClientKey());
            context.put("userId", accessToken.getOauthUserId());
            context.put("userName", oauthUser.getUserName());
            context.put("type", accessToken.getType());
            context.put("scopes", accessToken.getScopes());
            context.put("refreshToken", accessToken.getRefreshToken());
        }else{
            context.put("managementId", accessToken.getManagementId());
            context.put("clientId", accessToken.getClientId());
            context.put("clientKey", oauthClient.getClientKey());
            context.put("type", accessToken.getType());
            context.put("scopes", accessToken.getScopes());
            context.put("refreshToken", accessToken.getRefreshToken());
        }

        JWTClaimsSet.Builder builder = new JWTClaimsSet.Builder();
        JWTClaimsSet claimsSet = builder
                .issuer(issuer)
                .issueTime(issueTime)
                .expirationTime(expirationTime)
                .claim("context", context)
                .claim("claim", StringUtils.isEmpty(claimJson) ? new HashMap<>() : JsonUtils.marshal(claimJson))
                .build();

        SignedJWT signedJWT = new SignedJWT(new JWSHeader(JWSAlgorithm.HS256), claimsSet);

        signedJWT.sign(signer);

        return signedJWT.serialize();
    }
}

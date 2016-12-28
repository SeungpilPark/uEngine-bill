/**
 * Copyright (C) 2011 Flamingo Project (http://www.opencloudengine.org).
 * <p/>
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * <p/>
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * <p/>
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.uengine.garuda.web.system;

import org.opencloudengine.garuda.client.AccessTokenRequest;
import org.opencloudengine.garuda.client.IamClient;
import org.opencloudengine.garuda.client.ResourceOwnerPasswordCredentials;
import org.opencloudengine.garuda.client.model.OauthUser;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.mail.MailService;
import org.uengine.garuda.model.User;
import org.uengine.garuda.web.configuration.ConfigurationHelper;
import org.uengine.garuda.web.registe.Registe;
import org.uengine.garuda.web.registe.RegisteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.codec.Base64;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Properties;

/**
 * @author Seungpil PARK
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private RegisteRepository registeRepository;

    @Autowired
    IamServiceFactory serviceFactory;

    @Autowired
    ConfigurationHelper configurationHelper;

    @Autowired
    private MailService mailService;

    @Override
    public Map accessToken(String userName, String password, String scope) {
        IamClient iamClient = serviceFactory.trustClient();
        ResourceOwnerPasswordCredentials passwordCredentials = new ResourceOwnerPasswordCredentials();
        passwordCredentials.setUsername(userName);
        passwordCredentials.setPassword(password);
        passwordCredentials.setScope(scope);
        try{
            return iamClient.accessToken(passwordCredentials);
        }catch (Exception ex){
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public Map tokenInfo(String accessToken) {
        IamClient iamClient = serviceFactory.trustClient();
        try{
            return iamClient.tokenInfo(accessToken);
        }catch (Exception ex){
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public OauthUser acknowledge(String userName) {
        IamClient iamClient = serviceFactory.trustClient();
        OauthUser user = this.selectByUserName(userName);
        try {
            user.put("enable", true);
            return iamClient.updateUser(user);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public OauthUser createUser(OauthUser oauthUser) {
        IamClient iamClient = serviceFactory.trustClient();
        try {
            oauthUser.setLevel(0);
            oauthUser.put("enable", false);
            return iamClient.createUser(oauthUser);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public OauthUser createEnableUser(OauthUser oauthUser) {
        IamClient iamClient = serviceFactory.trustClient();
        try {
            oauthUser.setLevel(0);
            oauthUser.put("enable", true);
            return iamClient.createUser(oauthUser);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public OauthUser updatePassword(String userName, String password) {
        IamClient iamClient = serviceFactory.trustClient();
        OauthUser user = this.selectByUserName(userName);
        try {
            user.setUserPassword(password);
            return iamClient.updateUser(user);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public void deleteUser(String userName) {
        IamClient iamClient = serviceFactory.trustClient();
        OauthUser user = this.selectByUserName(userName);
        try {
            iamClient.deleteUser(user.get_id());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public OauthUser updateUser(OauthUser user) {
        IamClient iamClient = serviceFactory.trustClient();
        try {
            return iamClient.updateUser(user);
        } catch (Exception ex) {
            return null;
        }
    }

    @Override
    public OauthUser selectByUserId(String id) {
        IamClient iamClient = serviceFactory.trustClient();
        try {
            return iamClient.getUser(id);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public OauthUser selectByUserName(String userName) {
        IamClient iamClient = serviceFactory.trustClient();
        try {
            return iamClient.getUserByName(userName);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean waitingConfirmation(String userName) {
        OauthUser user = this.selectByUserName(userName);
        if (user != null) {
            if (!user.containsKey("enable") || !(boolean) user.get("enable")) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean completeAccount(String userName) {
        OauthUser user = this.selectByUserName(userName);
        if (user != null) {
            if (user.containsKey("enable") && (boolean) user.get("enable")) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void sendPasswdMail(String userName) {
        OauthUser user = this.selectByUserName(userName);
        Registe registe = new Registe();
        registe.setUserId(user.get_id());

        String fromUser = config.getProperty("mail.contacts.address");
        String token = new String(Base64.encode(String.valueOf(System.currentTimeMillis()).getBytes()));
        registe.setToken(token);

        registeRepository.insert(registe);
        mailService.passwd(registe.get_id(), token, "Forgot Password", fromUser, "uEngine", (String) user.get("email"), null);
    }

    @Override
    public boolean reqPasswdExist(String id, String token) {
        Registe registe = new Registe();
        registe.setUserId(id);
        registe.setToken(token);
        Registe managedRegiste = registeRepository.selectByUserIdAndToken(registe);
        if (managedRegiste == null) {
            return false;
        }
        return true;

    }

}

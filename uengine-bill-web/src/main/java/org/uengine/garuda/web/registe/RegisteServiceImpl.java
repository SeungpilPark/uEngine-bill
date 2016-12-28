package org.uengine.garuda.web.registe;

import org.opencloudengine.garuda.client.model.OauthUser;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.mail.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.codec.Base64;
import org.springframework.stereotype.Service;
import org.uengine.garuda.web.system.UserService;

import java.util.Properties;

@Service
public class RegisteServiceImpl implements RegisteService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private RegisteRepository registeRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private MailService mailService;


    @Override
    public void sendRegisteMail(String userName) {

        OauthUser user = userService.selectByUserName(userName);
        Registe registe = new Registe();
        registe.setUserId(user.get_id());

        String email = user.get("email").toString();

        String fromUser = config.getProperty("mail.contacts.address");
        String token = new String(Base64.encode(String.valueOf(System.currentTimeMillis()).getBytes()));
        registe.setToken(token);

        registeRepository.insert(registe);
        mailService.registe(registe.getUserId(), token, "Confirm Registration", fromUser, "uEngine", email, null);
    }

    @Override
    public void completeRegiste(String user_id, String token) {
        Registe registe = new Registe();
        registe.setUserId(user_id);
        registe.setToken(token);
        Registe managedRegiste = registeRepository.selectByUserIdAndToken(registe);
        if (managedRegiste == null) throw new ServiceException("가입 확인 처리할 대상이 없습니다.");

        OauthUser user = userService.selectByUserId(registe.getUserId());
        userService.acknowledge(user.getUserName());

        try {
            //zenService.upgradeZendeskUser( user.getEmail() );
        } catch (Exception ex) {
        } //별다른 작업을 하지 않아도 된다.
    }
}

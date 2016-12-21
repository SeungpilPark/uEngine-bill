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
    UserRepository userRepository;

    @Autowired
    ConfigurationHelper configurationHelper;

    @Autowired
    private MailService mailService;

    @Override
    public void acknowledge(String email) {
        userRepository.updateByAck(email);
    }

    @Override
    public User createUser(User user) {
        String email = user.getEmail();

        if (userRepository.selectByUserEmail(email) != null) {
            throw new ServiceException("이미 존재하는 사용자입니다.");
        }
        user.setAuthority("ROLE_USER");
        return userRepository.insertByUser(user);
    }

    @Override
    public User updatePassword(String email, String password) {
        return userRepository.updatePassword(email, password);
    }

    @Override
    public void deleteUser(String email) {
        userRepository.deleteByEmail(email);
    }

    @Override
    public User updateUserInfo(User user) {
        return userRepository.updateUserInfo(user);
    }

    @Override
    public User selectByUserId(String id) {
        return userRepository.selectByUserId(id);
    }

    @Override
    public User selectByUserEmail(String email) {
        return userRepository.selectByUserEmail(email);
    }

    @Override
    public boolean waitingConfirmation(String email) {
        User user = userRepository.selectByUserEmail(email);
        if (user != null) {
            if (!user.getEnabled())
                return true;
        }
        return false;
    }

    @Override
    public boolean completeAccount(String email) {
        User user = userRepository.selectByUserEmail(email);
        if (user != null) {
            if (user.getEnabled())
                return true;
        }
        return false;
    }

    @Override
    public void sendPasswdMail(String email) {
        User user = userRepository.selectByUserEmail(email);
        Registe registe = new Registe();
        registe.setUserId(user.get_id());

        String fromUser = config.getProperty("mail.contacts.address");
        String token = new String(Base64.encode(String.valueOf(System.currentTimeMillis()).getBytes()));
        registe.setToken(token);

        registeRepository.insert(registe);
        mailService.passwd(registe.get_id(), token, "Forgot Password", fromUser, "uEngine", email, null);
    }

    @Override
    public boolean reqPasswdExist(String user_id, String token) {
        Registe registe = new Registe();
        registe.setUserId(user_id);
        registe.setToken(token);
        Registe managedRegiste = registeRepository.selectByUserIdAndToken(registe);
        if (managedRegiste == null)
            return false;
        return true;

    }

}

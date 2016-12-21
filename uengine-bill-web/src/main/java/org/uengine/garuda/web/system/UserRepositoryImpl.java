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

import com.cloudant.client.api.model.Response;
import com.cloudant.client.api.views.Key;
import com.cloudant.client.api.views.ViewRequestBuilder;
import org.uengine.garuda.couchdb.CouchServiceFactory;
import org.uengine.garuda.model.User;
import org.uengine.garuda.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;

/**
 * @author Seungpil PARK
 */
@Repository
public class UserRepositoryImpl implements UserRepository {

    private String NAMESPACE = "management_user";

    @Autowired
    CouchServiceFactory serviceFactory;

    @Override
    public User selectByUserId(String id) {
        try {
            ViewRequestBuilder builder = serviceFactory.getDb().getViewRequestBuilder(NAMESPACE, "selectByUserId");
            Key.ComplexKey complex = new Key().complex(id);
            return builder.newRequest(Key.Type.COMPLEX, User.class).
                    keys(complex).
                    build().getResponse().getRows().get(0).getValue();
        } catch (Exception ex) {
            return null;
        }
    }

    @Override
    public User selectByUserEmail(String email) {
        try {
            ViewRequestBuilder builder = serviceFactory.getDb().getViewRequestBuilder(NAMESPACE, "selectByUserEmail");
            Key.ComplexKey complex = new Key().complex(email);
            return builder.newRequest(Key.Type.COMPLEX, User.class).
                    keys(complex).
                    build().getResponse().getRows().get(0).getValue();
        } catch (Exception ex) {
            return null;
        }
    }

    @Override
    public User insertByUser(User user) {
        long time = new Date().getTime();
        user.setDocType(NAMESPACE);
        user.setRegDate(time);
        user.setUpdDate(time);
        user.setLevel("5");
        user.setEnabled(false);

        Response response = serviceFactory.getDb().save(user);
        user.set_id(response.getId());
        user.set_rev(response.getRev());
        return user;
    }

    @Override
    public User insertByManager(User user) {
        long time = new Date().getTime();
        user.setDocType(NAMESPACE);
        user.setRegDate(time);
        user.setUpdDate(time);
        user.setLevel("1");
        user.setEnabled(true);

        Response response = serviceFactory.getDb().save(user);
        user.set_id(response.getId());
        user.set_rev(response.getRev());
        return user;
    }

    @Override
    public User updateByAck(String email) {
        User user = this.selectByUserEmail(email);
        user.setEnabled(true);
        user.setUpdDate(new Date().getTime());
        Response update = serviceFactory.getDb().update(user);
        user.set_rev(update.getRev());
        return user;
    }

    @Override
    public User updatePassword(String email, String password) {
        User user = this.selectByUserEmail(email);
        user.setPassword(password);
        user.setUpdDate(new Date().getTime());
        Response update = serviceFactory.getDb().update(user);
        user.set_rev(update.getRev());
        return user;
    }

    @Override
    public void deleteByEmail(String email) {
        User user = this.selectByUserEmail(email);
        serviceFactory.getDb().remove(user);
    }

    @Override
    public User updateUserInfo(User user) {
        String id = user.get_id();
        User existUser = this.selectByUserId(id);

        existUser = (User) JsonUtils.merge(existUser, user);
        Response update = serviceFactory.getDb().update(existUser);
        existUser.set_rev(update.getRev());
        return existUser;
    }

}
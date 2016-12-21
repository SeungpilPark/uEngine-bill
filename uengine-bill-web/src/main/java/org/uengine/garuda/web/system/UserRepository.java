/**
 * Copyright (C) 2011 Flamingo Project (http://www.opencloudengine.org).
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.uengine.garuda.web.system;

import org.uengine.garuda.model.User;

/**
 * 사용자 정보에 대한 CRUD 기능을 처리하는 User Repository
 *
 * @author Seungpil PARK
 */
public interface UserRepository {

    User selectByUserId(String id);

    User selectByUserEmail(String email);

    User insertByUser(User user);

    User insertByManager(User user);

    User updateUserInfo(User user);

    User updateByAck(String email);

    User updatePassword(String email, String password);

    void deleteByEmail(String email);

}

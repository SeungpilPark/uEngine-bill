/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 * <p/>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p/>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.uengine.garuda.web.system;

import org.uengine.garuda.model.User;

/**
 * @author Seungpil PARK
 * @since 2.0
 */
public interface UserService {

    /**
     * 이메일 확인 후 사용자의 가입 신청을 처리한다.
     *
     * @param email 사용자메일
     */
    void acknowledge(String email);

    /**
     * 이메일 확인 전 사용자의 가입 신청을 처리한다.
     *
     * @param user User Map
     * @return User
     */
    User createUser(User user);


    User updatePassword(String email, String password);

    void deleteUser(String email);

    User updateUserInfo(User user);

    User selectByUserId(String id);

    User selectByUserEmail(String email);


    /**
     * 사용자가 이메일 확인 대기중일 경우 true
     *
     * @param email 사용자메일
     * @return true or false
     */
    boolean waitingConfirmation(String email);

    /**
     * 사용자가 이메일 확인 완료일 경우 true
     *
     * @param email 사용자메일
     * @return true or false
     */
    boolean completeAccount(String email);

    /**
     * 사용자가에게 패스워드 변경 이메일을 보낸다.
     *
     * @param email 사용자메일
     */
    void sendPasswdMail(String email);

    boolean reqPasswdExist(String user_id, String token);


}

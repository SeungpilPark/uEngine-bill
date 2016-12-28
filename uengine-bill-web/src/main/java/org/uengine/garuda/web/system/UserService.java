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

import org.opencloudengine.garuda.client.model.OauthUser;

import java.util.Map;

/**
 * @author Seungpil PARK
 * @since 2.0
 */
public interface UserService {

    Map accessToken(String userName, String password, String scope);

    Map tokenInfo(String accessToken);

    /**
     * 이메일 확인 후 사용자의 가입 신청을 처리한다.
     *
     * @param userName 사용자 이름
     */
    OauthUser acknowledge(String userName);

    /**
     * 이메일 확인 전 사용자의 가입 신청을 처리한다.
     *
     * @param user User Map
     * @return User
     */
    OauthUser createUser(OauthUser user);

    OauthUser createEnableUser(OauthUser user);

    OauthUser updatePassword(String userName, String password);

    void deleteUser(String userName);

    OauthUser updateUser(OauthUser user);

    OauthUser selectByUserId(String id);

    OauthUser selectByUserName(String userName);


    /**
     * 사용자가 이메일 확인 대기중일 경우 true
     *
     * @param userName 사용자 이름
     * @return true or false
     */
    boolean waitingConfirmation(String userName);

    /**
     * 사용자가 이메일 확인 완료일 경우 true
     *
     * @param userName 사용자 이름
     * @return true or false
     */
    boolean completeAccount(String userName);

    /**
     * 사용자가에게 패스워드 변경 이메일을 보낸다.
     *
     * @param userName 사용자 이름
     */
    void sendPasswdMail(String userName);

    boolean reqPasswdExist(String id, String token);
}

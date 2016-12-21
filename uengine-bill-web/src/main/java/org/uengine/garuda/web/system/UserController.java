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

import org.apache.commons.codec.binary.Base64;
import org.uengine.garuda.common.security.SessionUtils;
import org.uengine.garuda.model.User;
import org.uengine.garuda.util.DateUtils;
import org.uengine.garuda.web.configuration.DefaultController;
import org.uengine.garuda.web.security.AESPasswordEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

/**
 * Security Auth Controller
 *
 * @author Seungpil PARK
 * @since 2.0
 */
@Controller
@RequestMapping("/auth")
public class UserController extends DefaultController {

    @Autowired
    private UserService userService;

    @Autowired
    @Qualifier("passwordEncoder")
    private AESPasswordEncoder passwordEncoder;

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(UserController.class);

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(HttpSession session) {
        return new ModelAndView("/auth/login");
    }

    @RequestMapping(value = "/forgetPasswd", method = RequestMethod.GET)
    public ModelAndView forgetPasswd(HttpSession session) {
        return new ModelAndView("/auth/forgetPasswd");
    }

    @RequestMapping(value = "/fail", method = RequestMethod.GET)
    public ModelAndView fail(HttpSession session) {
        return new ModelAndView("/auth/fail");
    }


    /**
     * 사용자가 패스워드 분실 정보를 입력하면 이메일이 있을 경우 입력한 정보로 이메일을 전송한다.
     */
    @RequestMapping(value = "/sendPasswd", method = RequestMethod.POST)
    public ModelAndView registerRequest(
            @RequestParam String email) {

        try {
            //계정은 없는 경우
            if (userService.selectByUserEmail(email) == null) {
                ModelAndView mav = new ModelAndView();
                mav.setViewName("/auth/sendPasswdFail");
                mav.addObject("responseEmail", email);
                return mav;
            }
            //계정이 있을 경우 패스워드변경 페이지 이메일 전송 후 화면 이동시킨다.
            userService.sendPasswdMail(email);

            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/sendPasswdSuccess");
            return mav;

        } catch (Exception ex) {
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/sendPasswdFail");
            mav.addObject("responseEmail", email);
            return mav;
        }
    }

    @RequestMapping(value = "/passwdConfirm", method = RequestMethod.GET)
    public ModelAndView confirm(HttpServletResponse res, @RequestParam String userid, @RequestParam String token) throws IOException {
        long tokenTimestamp = Long.parseLong(new String(Base64.decodeBase64(token)));
        if (DateUtils.getDiffDays(new Date(), new Date(tokenTimestamp)) > 1) {
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/error-401");
            return mav;
        }
        try {
            if (userService.reqPasswdExist(userid, token)) {
                ModelAndView mav = new ModelAndView();
                mav.setViewName("/auth/repasswd");
                return mav;
            } else {
                ModelAndView mav = new ModelAndView();
                mav.setViewName("/auth/error-401");
                return mav;
            }
        } catch (Exception ex) {
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/error-401");
            return mav;
        }
    }

    /**
     * 로그인한 사용자의 패스워드를 변경한다.
     */
    @RequestMapping(value = "/repasswdProc", method = RequestMethod.POST)
    @Secured({"ROLE_ADMIN", "ROLE_USER"})
    public ModelAndView changePassword(@RequestParam String password, @RequestParam String newPassword, @RequestParam String confirmNewPassword) {
        String email = SessionUtils.getEmail();

        //기존 패스워드 입력이 틀린경우
        if (!passwordEncoder.matches(password, SessionUtils.getPasswd())) {
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/invalidPasswd");
            return mav;
        }

        userService.updatePassword(email, passwordEncoder.encode(newPassword));

        ModelAndView mav = new ModelAndView();
        mav.setViewName("/auth/passwdChanged");
        return mav;
    }

    /**
     * 사용자 정보를 수정한다.( 패스워드 제외 )
     *
     * @param user 사용자
     */
    @RequestMapping(value = "/updateUserInfo", method = RequestMethod.POST)
    @Secured({"ROLE_ADMIN", "ROLE_USER"})
    public ModelAndView updateUserInfo(@RequestBody User user) {
        try {
            userService.updateUserInfo(user);
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/reviewUserInfo");
            return mav;
        } catch (Exception ex) {
            ModelAndView mav = new ModelAndView();
            mav.setViewName("/auth/updateUserInfoFailed");
            return mav;
        }
    }
}

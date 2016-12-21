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
package org.uengine.garuda.web.security;

import org.uengine.garuda.common.security.SessionUtils;
import org.uengine.garuda.model.User;
import org.uengine.garuda.util.ApplicationContextRegistry;
import org.uengine.garuda.web.system.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collection;

/**
 * Security Auth Controller
 *
 * @author Seungpil PARK
 * @since 2.0
 */
public class SessionFilter implements Filter {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(SessionFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);

        if(session == null){
            filterChain.doFilter(request, response);
        }

        //session에 User 객체가 있는경우 SessionUtils 유저 등록
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");

            SessionUtils.put(user);
            filterChain.doFilter(request, response);
            SessionUtils.remove();
        }

        //session에 User 객체가 없는경우
        else {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            //로그인에 성공한 상태인 경우에 한해 session에  User 객체를 넣어준다.
            if (!(auth instanceof AnonymousAuthenticationToken) && auth != null) {
                ApplicationContext context = ApplicationContextRegistry.getApplicationContext();
                UserService userService = context.getBean(UserService.class);
                AESPasswordEncoder passwordEncoder = context.getBean(AESPasswordEncoder.class);

                String email = (String) auth.getPrincipal();
                CustomUserDetails details = (CustomUserDetails) auth.getDetails();
                Collection<? extends GrantedAuthority> authorities = details.getAuthorities();

                boolean admin = false;
                for (GrantedAuthority authority : authorities) {
                    String authString = authority.getAuthority();
                    if (authString.equals("ROLE_ADMIN"))
                        admin = true;
                }
                User managedUser = userService.selectByUserEmail(email);
                managedUser.setAdmin(admin);
                managedUser.setPassword(passwordEncoder.decode(managedUser.getPassword()));
                session.setAttribute("user", managedUser);

                SessionUtils.put(managedUser);
                filterChain.doFilter(request, response);
                SessionUtils.remove();
            } else {
                filterChain.doFilter(request, response);
            }
        }
    }

    @Override
    public void destroy() {
    }

}
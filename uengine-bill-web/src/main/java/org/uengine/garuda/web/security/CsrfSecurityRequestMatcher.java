package org.uengine.garuda.web.security;

import org.springframework.security.web.util.matcher.RegexRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import javax.servlet.http.HttpServletRequest;
import java.util.regex.Pattern;

/**
 * Created by uengine on 2015. 6. 18..
 */
public class CsrfSecurityRequestMatcher implements RequestMatcher {
    private Pattern allowedMethods = Pattern.compile("^(GET|HEAD|TRACE|OPTIONS)$");

    private RegexRequestMatcher unprotectedMatcher = new RegexRequestMatcher("/oauth/authorize_redirect", null);

    private RegexRequestMatcher redirectMatcher = new RegexRequestMatcher("/oauth/redirect", null);

    private RegexRequestMatcher accessTokentMatcher = new RegexRequestMatcher("/oauth/access_token", null);

    private RegexRequestMatcher restMatcher = new RegexRequestMatcher("/rest/v1/.*", null);

    @Override
    public boolean matches(HttpServletRequest request) {

        if(allowedMethods.matcher(request.getMethod()).matches()){
            return false;
        }

        if(unprotectedMatcher.matches(request)){
            return false;
        }

        if(redirectMatcher.matches(request)){
            return false;
        }

        if(accessTokentMatcher.matches(request)){
            return false;
        }

        if(restMatcher.matches(request)){
            return false;
        }

        return true;
    }
}

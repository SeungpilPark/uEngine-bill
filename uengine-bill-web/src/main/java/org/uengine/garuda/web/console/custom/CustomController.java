package org.uengine.garuda.web.console.custom;

import com.google.common.base.Joiner;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.common.rest.Response;
import org.uengine.garuda.common.security.SessionUtils;
import org.uengine.garuda.util.ExceptionUtils;
import org.uengine.garuda.web.console.oauthclient.OauthClient;
import org.uengine.garuda.web.console.oauthclient.OauthClientService;
import org.uengine.garuda.web.console.oauthscope.OauthScope;
import org.uengine.garuda.web.console.oauthscope.OauthScopeService;
import org.uengine.garuda.web.console.oauthuser.OauthUser;
import org.uengine.garuda.web.console.oauthuser.OauthUserService;
import org.uengine.garuda.web.management.Management;
import org.uengine.garuda.web.management.ManagementService;
import org.uengine.garuda.web.oauth.CustomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Controller
@RequestMapping("/console/custom")
public class CustomController {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private ManagementService managementService;

    @Autowired
    private OauthScopeService oauthScopeService;

    @Autowired
    private OauthClientService oauthClientService;

    @Autowired
    private OauthUserService oauthUserService;

    @Autowired
    private CustomService customService;

    @RequestMapping(value = "/token/edit", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView edit(HttpSession session) throws IOException {
        Management management = (Management) session.getAttribute("management");
        try {
            if (management == null) {
                ModelAndView mav = new ModelAndView("/management/list");
                List<Management> managements = managementService.selectAllByUserId(SessionUtils.getId());
                mav.addObject("managements", managements);

                return mav;
            }
            List<OauthScope> oauthScopes = oauthScopeService.selectAllByManagementId(management.get_id());
            List<OauthClient> oauthClients = oauthClientService.selectAllByManagementId(management.get_id());
            List<OauthUser> oauthUsers = oauthUserService.selectAllByManagementId(management.get_id());

            ModelAndView mav = new ModelAndView("/console/custom/token/edit");
            mav.addObject("management", management);
            mav.addObject("oauthScopes", oauthScopes);
            mav.addObject("oauthClients", oauthClients);
            mav.addObject("oauthUsers", oauthUsers);

            return mav;

        } catch (Exception ex) {
            throw new ServiceException("Invalid Server Error");
        }
    }

    @RequestMapping(value = "/token/update", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView update(HttpSession session,
                               @RequestParam(defaultValue = "") String useCustomTokenIssuance,
                               @RequestParam(defaultValue = "") String customTokenIssuance) throws IOException {

        Management management = (Management) session.getAttribute("management");
        List<OauthScope> oauthScopes = oauthScopeService.selectAllByManagementId(management.get_id());
        List<OauthClient> oauthClients = oauthClientService.selectAllByManagementId(management.get_id());
        List<OauthUser> oauthUsers = oauthUserService.selectAllByManagementId(management.get_id());

        try {
            management.setUseCustomTokenIssuance(useCustomTokenIssuance);
            management.setCustomTokenIssuance(customTokenIssuance);

            Management updated = managementService.updateById(management);

            ModelAndView mav = new ModelAndView("/console/custom/token/edit");
            mav.addObject("management", updated);
            mav.addObject("oauthScopes", oauthScopes);
            mav.addObject("oauthClients", oauthClients);
            mav.addObject("oauthUsers", oauthUsers);

            return mav;

        } catch (Exception ex) {
            ModelAndView mav = new ModelAndView("/console/custom/token/edit");
            mav.addObject("management", management);
            mav.addObject("oauthScopes", oauthScopes);
            mav.addObject("oauthClients", oauthClients);
            mav.addObject("oauthUsers", oauthUsers);
            mav.addObject("failed", true);

            return mav;
        }
    }

    @RequestMapping(value = "/token/test", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Response test(HttpSession session, @RequestBody Map params) {
        Response response = new Response();
        try {
            Management management = (Management) session.getAttribute("management");
            String userId = (String) params.get("userId");
            String clientId = (String) params.get("clientId");
            List<String> list = (List) params.get("scopes");

            String tokenType = (String) params.get("tokenType");
            String claim = (String) params.get("claim");
            String script = (String) params.get("script");

            Map map = customService.processTokenTest(management, userId, clientId, Joiner.on(",").join(list), tokenType, claim, script);

            response.setSuccess(true);
            response.getMap().putAll(map);

        } catch (Exception ex) {
            response.setSuccess(false);
            response.getError().setMessage(ex.getMessage());

            if (ex.getCause() != null) {
                response.getError().setCause(ex.getCause().getMessage());
            }
            response.getError().setException(ExceptionUtils.getFullStackTrace(ex));
        }
        return response;
    }
}

package org.uengine.garuda.web.console.oauthclient;

import net.minidev.json.JSONObject;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.web.console.oauthscope.OauthScope;
import org.uengine.garuda.web.console.oauthscope.OauthScopeService;
import org.uengine.garuda.web.management.Management;
import org.uengine.garuda.web.system.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Properties;

@Controller
@RequestMapping("/console/client")
public class OauthClientController {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private UserService userService;

    @Autowired
    private OauthClientService oauthClientService;

    @Autowired
    private OauthScopeService oauthScopeService;

    @RequestMapping(method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public String load() {
        return "/console/client/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public @ResponseBody
    String list(HttpSession session,
                                     @RequestParam(value = "limit", required = false, defaultValue = "10") int limit,
                                     @RequestParam(value = "skip", required = false, defaultValue = "0") int skip,
                                     @RequestParam(value = "clientName", required = false, defaultValue = "") String clientName) {

        Management management = (Management) session.getAttribute("management");

        Long count;
        List<OauthClient> oauthClients;

        if(clientName.length() > 0) {
            count = oauthClientService.countAllByManagementIdLikeClientName(management.get_id(), clientName);
            oauthClients = oauthClientService.selectByManagementLikeClientName(management.get_id(), clientName, limit, new Long(skip));

        } else {
            count = oauthClientService.countAllByManagementId(management.get_id());
            oauthClients = oauthClientService.selectByManagementId(management.get_id(), limit, new Long(skip));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("recordsTotal", limit);
        jsonObject.put("recordsFiltered", count);
        jsonObject.put("displayStart", skip);
        jsonObject.put("data", oauthClients);

        return jsonObject.toString();
    }

    @RequestMapping(value = "/new", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView newManagement(HttpSession session) {
        Management management = (Management) session.getAttribute("management");
        List<OauthScope> oauthScopes = oauthScopeService.selectAllByManagementId(management.get_id());

        ModelAndView mav = new ModelAndView("/console/client/new");

        mav.addObject("management", management);
        mav.addObject("oauthScopes", oauthScopes);

        return mav;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView create(HttpSession session,
                               @RequestParam(defaultValue = "") String name,
                               @RequestParam(defaultValue = "") String description,
                               @RequestParam(defaultValue = "") String clientTrust,
                               @RequestParam(defaultValue = "") String clientType,
                               @RequestParam(defaultValue = "N") String activeClient,
                               @RequestParam(defaultValue = "") String authorizedGrantTypes,
                               @RequestParam(defaultValue = "") String webServerRedirectUri,
                               @RequestParam(defaultValue = "") String refreshTokenValidity,
                               @RequestParam(defaultValue = "") String additionalInformation,
                               @RequestParam(defaultValue = "") Integer codeLifetime,
                               @RequestParam(defaultValue = "") Integer refreshTokenLifetime,
                               @RequestParam(defaultValue = "") Integer accessTokenLifetime,
                               @RequestParam(defaultValue = "") Integer jwtTokenLifetime,
                               @RequestParam(defaultValue = "") String scopes
    ) throws IOException {


        Management management = (Management) session.getAttribute("management");
        List<OauthScope> oauthScopes = oauthScopeService.selectAllByManagementId(management.get_id());

        try {

            //같은 이름 검색
            OauthClient existClient = oauthClientService.selectByManagementIdAndName(management.get_id(), name);
            if (existClient != null) {
                ModelAndView mav = new ModelAndView("/console/client/new");
                mav.addObject("management", management);
                mav.addObject("oauthScopes", oauthScopes);
                mav.addObject("duplicate", true);

                return mav;
            }

            //클라이언트 생성
            oauthClientService.createClient(management.get_id(), name, description, clientTrust, clientType, activeClient, authorizedGrantTypes,
                    webServerRedirectUri, refreshTokenValidity, codeLifetime,
                    refreshTokenLifetime, accessTokenLifetime, jwtTokenLifetime, scopes);

            //리스트 페이지 반환
            ModelAndView mav = new ModelAndView("/console/client/list");
            mav.addObject("management", management);

            return mav;

        } catch (Exception ex) {
            ModelAndView mav = new ModelAndView("/console/client/new");
            mav.addObject("management", management);
            mav.addObject("oauthScopes", oauthScopes);
            mav.addObject("failed", true);

            return mav;
        }
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView edit(HttpSession session,
                             @RequestParam(defaultValue = "") String _id) throws IOException {

        Management management = (Management) session.getAttribute("management");
        List<OauthScope> oauthScopes = oauthScopeService.selectAllByManagementId(management.get_id());

        //클라이언트 검색
        OauthClient oauthClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);
        if (oauthClient == null) {
            throw new ServiceException("Invalid oauth client id");
        }

        //스코프 검색
        List<OauthScope> clientScopes = oauthScopeService.selectClientScopes(_id);
        try {

            ModelAndView mav = new ModelAndView("/console/client/edit");
            mav.addObject("management", management);
            mav.addObject("oauthClient", oauthClient);
            mav.addObject("oauthScopes", oauthScopes);
            mav.addObject("clientScopes", clientScopes);

            return mav;

        } catch (Exception ex) {
            throw new ServiceException("Invalid oauth client id");
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView delete(HttpSession session,
                               @RequestParam(defaultValue = "") String _id) throws IOException {

        Management management = (Management) session.getAttribute("management");

        try {
            //클라이언트 검색
            OauthClient oauthClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);
            if (oauthClient == null) {
                throw new ServiceException("Invalid oauth client id");
            }

            oauthClientService.deleteById(_id);

            ModelAndView mav = new ModelAndView("/console/client/list");
            mav.addObject("management", management);

            return mav;

        } catch (Exception ex) {
            throw new ServiceException("Invalid oauth client id");
        }
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView update(HttpSession session,
                               @RequestParam(defaultValue = "") String _id,
                               @RequestParam(defaultValue = "") String name,
                               @RequestParam(defaultValue = "") String description,
                               @RequestParam(defaultValue = "") String clientTrust,
                               @RequestParam(defaultValue = "") String clientType,
                               @RequestParam(defaultValue = "N") String activeClient,
                               @RequestParam(defaultValue = "") String authorizedGrantTypes,
                               @RequestParam(defaultValue = "") String webServerRedirectUri,
                               @RequestParam(defaultValue = "") String refreshTokenValidity,
                               @RequestParam(defaultValue = "") Integer codeLifetime,
                               @RequestParam(defaultValue = "") Integer refreshTokenLifetime,
                               @RequestParam(defaultValue = "") Integer accessTokenLifetime,
                               @RequestParam(defaultValue = "") Integer jwtTokenLifetime,
                               @RequestParam(defaultValue = "") String scopes
    ) throws IOException {

        Management management = (Management) session.getAttribute("management");
        List<OauthScope> oauthScopes = oauthScopeService.selectAllByManagementId(management.get_id());

        //클라이언트 검색
        OauthClient oauthClient = oauthClientService.selectByManagementIdAndId(management.get_id(), _id);
        if (oauthClient == null) {
            throw new ServiceException("Invalid oauth client id");
        }

        //스코프 검색
        List<OauthScope> clientScopes = oauthScopeService.selectClientScopes(_id);
        try {

            //같은 이름 검색
            OauthClient existClient = oauthClientService.selectByManagementIdAndName(management.get_id(), name);
            if (existClient != null) {
                if (!existClient.get_id().equals(_id)) {
                    ModelAndView mav = new ModelAndView("/console/client/edit");
                    mav.addObject("management", management);
                    mav.addObject("oauthClient", oauthClient);
                    mav.addObject("clientScopes", clientScopes);
                    mav.addObject("duplicate", true);

                    return mav;
                }
            }

            oauthClientService.updateById(_id, name, description, clientTrust, clientType, activeClient, authorizedGrantTypes,
                    webServerRedirectUri, refreshTokenValidity, codeLifetime,
                    refreshTokenLifetime, accessTokenLifetime, jwtTokenLifetime, scopes);

            ModelAndView mav = new ModelAndView("/console/client/list");
            mav.addObject("management", management);

            return mav;

        } catch (Exception ex) {
            ModelAndView mav = new ModelAndView("/console/client/edit");
            mav.addObject("management", management);
            mav.addObject("oauthClient", oauthClient);
            mav.addObject("oauthScopes", oauthScopes);
            mav.addObject("clientScopes", clientScopes);
            mav.addObject("failed", true);

            return mav;
        }
    }
}

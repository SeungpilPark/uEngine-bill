package org.uengine.garuda.web.management;

import net.minidev.json.JSONObject;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.common.security.SessionUtils;
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
@RequestMapping("/management")
public class ManagementController {
    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private UserService userService;

    @Autowired
    private ManagementService managementService;

    @RequestMapping(method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public String load() {
        return "/management/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public @ResponseBody
    String list(@RequestParam(value = "limit", required = false, defaultValue = "10") int limit,
                                     @RequestParam(value = "skip", required = false, defaultValue = "0") int skip,
                                     @RequestParam(value = "managementName", required = false, defaultValue = "") String managementName) {

        Long count;
        List<Management> managements;
        String id = SessionUtils.getId();

        if(managementName.length() > 0) {
            count = managementService.countAllByUserIdLikeManagementName(id, managementName);
            managements = managementService.selectByUserIdLikeManagementName(id, managementName, limit, new Long(skip));

        } else {
            count = managementService.countAllByUserId(id);
            managements = managementService.selectByUserId(id, limit, new Long(skip));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("recordsTotal", limit);
        jsonObject.put("recordsFiltered", count);
        jsonObject.put("displayStart", skip);
        jsonObject.put("data", managements);

        return jsonObject.toString();
    }

    @RequestMapping(value = "/new", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView newManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("/management/new");
        return mav;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView create(HttpSession session,
                               @RequestParam(defaultValue = "") String managementName,
                               @RequestParam(defaultValue = "") String description,
                               @RequestParam(defaultValue = "") Integer sessionTokenLifetime,
                               @RequestParam(defaultValue = "") Integer scopeCheckLifetime) throws IOException {

        try {
            managementService.createManagement(SessionUtils.getId(), managementName, description, sessionTokenLifetime, scopeCheckLifetime);
            ModelAndView mav = new ModelAndView("/management/list");

            List<Management> managements = managementService.selectAllByUserId(SessionUtils.getId());
            mav.addObject("managements", managements);
            return mav;
        } catch (Exception ex) {
            ModelAndView mav = new ModelAndView("/management/new");
            mav.addObject("failed", true);
            return mav;
        }
    }

    @RequestMapping(value = "/session", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView session(HttpSession session,
                                @RequestParam(defaultValue = "") String _id) throws IOException {

        try {
            Management management = managementService.selectByUserIdAndId(SessionUtils.getId(), _id);
            if (management != null) {
                session.setAttribute("management", management);
                ModelAndView mav = new ModelAndView("/console/overview");
                mav.addObject("management", management);
                return mav;
            } else {
                session.removeAttribute("management");
                throw new ServiceException("Invalid management managementId");
            }
        } catch (Exception ex) {
            session.removeAttribute("management");
            throw new ServiceException("Invalid management managementId");
        }
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView edit(HttpSession session,
                             @RequestParam(defaultValue = "") String _id) throws IOException {

        try {
            Management management = managementService.selectByUserIdAndId(SessionUtils.getId(), _id);
            if (management != null) {
                ModelAndView mav = new ModelAndView("/management/edit");
                mav.addObject("management", management);
                return mav;
            } else {
                throw new ServiceException("Invalid management managementId");
            }
        } catch (Exception ex) {
            throw new ServiceException("Invalid management managementId");
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView delete(HttpSession session,
                               @RequestParam(defaultValue = "") String _id) throws IOException {

        try {
            Management management = managementService.selectByUserIdAndId(SessionUtils.getId(), _id);
            if (management != null) {
                managementService.deleteById(_id);
                ModelAndView mav = new ModelAndView("/management/list");
                List<Management> managements = managementService.selectAllByUserId(SessionUtils.getId());
                mav.addObject("managements", managements);
                return mav;
            } else {
                throw new ServiceException("Invalid managementId");
            }
        } catch (Exception ex) {
            throw new ServiceException("Invalid managementId");
        }
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public ModelAndView update(HttpSession session,
                               @RequestParam(defaultValue = "") String _id,
                               @RequestParam(defaultValue = "") String managementName,
                               @RequestParam(defaultValue = "") String description,
                               @RequestParam(defaultValue = "") Integer sessionTokenLifetime,
                               @RequestParam(defaultValue = "") Integer scopeCheckLifetime) throws IOException {

        try {
            managementService.updateById(SessionUtils.getId(), _id, managementName, description, sessionTokenLifetime, scopeCheckLifetime);

            ModelAndView mav = new ModelAndView("/management/list");
            List<Management> managements = managementService.selectAllByUserId(SessionUtils.getId());
            mav.addObject("managements", managements);
            return mav;
        } catch (Exception ex) {
            ModelAndView mav = new ModelAndView("/management/edit");
            mav.addObject("failed", true);
            return mav;
        }
    }
}

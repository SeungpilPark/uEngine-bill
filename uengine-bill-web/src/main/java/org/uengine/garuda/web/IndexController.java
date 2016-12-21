package org.uengine.garuda.web;

import org.uengine.garuda.web.contactus.ContactUs;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Locale;
import java.util.Properties;

@Controller
@RequestMapping("/")
public class IndexController {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    @Qualifier("config")
    private Properties config;

    /**
     * API 페이지로 이동한다.
     *
     * @return Model And View
     */
    @RequestMapping(value = "/rest/console", method = RequestMethod.GET)
    public ModelAndView api(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("api");
    }


    /**
     * 인덱스 페이지로 이동한다.
     *
     * @return Model And View
     */
    @RequestMapping(value = "index", method = RequestMethod.GET)
    public ModelAndView index(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("index");
    }

    @RequestMapping(value = "product", method = RequestMethod.GET)
    public ModelAndView product(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/product/index");
    }
    @RequestMapping(value = "customer", method = RequestMethod.GET)
    public ModelAndView customer(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/customer/index");
    }
    @RequestMapping(value = "customer/new", method = RequestMethod.GET)
    public ModelAndView customerNew(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/customer/new");
    }
    @RequestMapping(value = "customer/detail", method = RequestMethod.GET)
    public ModelAndView customerDetail(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/customer/detail");
    }
    @RequestMapping(value = "subscription", method = RequestMethod.GET)
    public ModelAndView subscription(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/subscription/index");
    }
    @RequestMapping(value = "invoice", method = RequestMethod.GET)
    public ModelAndView invoice(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/invoice/index");
    }
    @RequestMapping(value = "events", method = RequestMethod.GET)
    public ModelAndView events(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/events/index");
    }
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/report/index");
    }

    @RequestMapping(value = "apidoc", method = RequestMethod.GET)
    public ModelAndView apidoc(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/apidoc/index");
    }

    @RequestMapping(value = "setting/organization", method = RequestMethod.GET)
    public ModelAndView organization(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/organization/index");
    }
    @RequestMapping(value = "setting/user", method = RequestMethod.GET)
    public ModelAndView user(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/user/index");
    }
    @RequestMapping(value = "setting/preference", method = RequestMethod.GET)
    public ModelAndView preference(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/preference/index");
    }
    @RequestMapping(value = "setting/retry", method = RequestMethod.GET)
    public ModelAndView retry(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/retry/index");
    }
    @RequestMapping(value = "setting/currencie", method = RequestMethod.GET)
    public ModelAndView currencie(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/currencie/index");
    }
    @RequestMapping(value = "setting/template", method = RequestMethod.GET)
    public ModelAndView template(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/template/index");
    }
    @RequestMapping(value = "setting/hosted", method = RequestMethod.GET)
    public ModelAndView hosted(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/hosted/index");
    }
    @RequestMapping(value = "setting/notification", method = RequestMethod.GET)
    public ModelAndView notification(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/notification/index");
    }
    @RequestMapping(value = "setting/reminder", method = RequestMethod.GET)
    public ModelAndView reminder(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/reminder/index");
    }
    @RequestMapping(value = "setting/integration", method = RequestMethod.GET)
    public ModelAndView integration(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/integration/index");
    }
    @RequestMapping(value = "setting/webhook", method = RequestMethod.GET)
    public ModelAndView webhook(HttpSession session, final Locale locale) {
        session.setAttribute("lang", locale.toString());

        return new ModelAndView("/setting/webhook/index");
    }


    @RequestMapping(value = "redirect", method = RequestMethod.GET)
    public ModelAndView redirect(@RequestParam String url) {
        return new ModelAndView("redirect:" + url);
    }

    @RequestMapping(value = "go", method = RequestMethod.GET)
    public ModelAndView go(@RequestParam String url) {
        return new ModelAndView(url);
    }

}

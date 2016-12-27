package org.uengine.garuda.web.contactus;

import org.uengine.garuda.common.rest.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/contact")
public class ContactUsController {

    @Autowired
    ContactUsService service;

    @Autowired
    private ContactUsService contactUsService;


    // 위의 코드가 반응속도가 느려서 AJAX로 다시 구현
    @RequestMapping(value = "/post", method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Response index(HttpSession session, @ModelAttribute("contact") ContactUs contactUs, @RequestParam(defaultValue = "") String redirect) {
        Response response = new Response();

        contactUs.setMessage(contactUs.getMessage().replace("\r\n", "<br>"));

        try {
            contactUsService.sendContactMail(contactUs);
            response.setSuccess(true);
        } catch (Exception ex) {
            response.setSuccess(false);
        }
        return response;
    }
}

package org.uengine.garuda.web.contactus;

import org.uengine.garuda.mail.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Properties;

@Service
public class ContactUsServiceImpl implements ContactUsService {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Autowired
    private ContactUsRepository contactUsRepository;

    @Autowired
    private MailService mailService;

    @Override
    public void sendContactMail(ContactUs contactUs) {
        contactUsRepository.insert(contactUs);
        String toUser = config.getProperty("mail.contacts.address");
        mailService.sendBySmtp(contactUs.getSubject(), contactUs.getMessage(), contactUs.getEmail(), contactUs.getName(), toUser, contactUs.getTelephone(), null);
    }
}

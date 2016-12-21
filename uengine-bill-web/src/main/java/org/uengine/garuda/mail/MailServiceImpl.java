package org.uengine.garuda.mail;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import reactor.core.Reactor;
import reactor.event.Event;

import javax.mail.internet.InternetAddress;
import java.util.HashMap;
import java.util.Map;


@Service
public class MailServiceImpl implements MailService {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(MailService.class);


    @Autowired
    private Reactor reactor;


    @Override
    public void sendBySmtp(String subject, String text, String fromUser, String fromName, final String toUser, String telephone, InternetAddress[] toCC) {
        Map map = new HashMap();
        map.put("command", "sendBySmtp");
        map.put("subject", subject);
        map.put("text", text);
        map.put("fromUser", fromUser);
        map.put("fromName", fromName);
        map.put("toUser", toUser);
        map.put("telephone", telephone);
        map.put("toCC", toCC);

        reactor.notify("mail", Event.wrap(map));
    }

    @Override
    public void registe(String userId, String token, String subject, String fromUser, String fromName, final String toUser, InternetAddress[] toCC) {
        Map map = new HashMap();
        map.put("command", "registe");
        map.put("userId", userId);
        map.put("token", token);
        map.put("subject", subject);
        map.put("fromUser", fromUser);
        map.put("fromName", fromName);
        map.put("toUser", toUser);
        map.put("toCC", toCC);

        reactor.notify("mail", Event.wrap(map));

    }

    @Override
    public void passwd(String userId, String token, String subject, String fromUser, String fromName, final String toUser, InternetAddress[] toCC) {
        Map map = new HashMap();
        map.put("command", "passwd");
        map.put("userId", userId);
        map.put("token", token);
        map.put("subject", subject);
        map.put("fromUser", fromUser);
        map.put("fromName", fromName);
        map.put("toUser", toUser);
        map.put("toCC", toCC);

        reactor.notify("mail", Event.wrap(map));
    }
}
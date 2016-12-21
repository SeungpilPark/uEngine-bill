package org.uengine.garuda.mail;

import org.apache.commons.exec.LogOutputStream;
import org.apache.velocity.app.VelocityEngine;
import org.uengine.garuda.common.async.ConsumerNameAware;
import org.uengine.garuda.common.exception.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.helpers.MessageFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;
import reactor.event.Event;
import reactor.function.Consumer;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Service
public class MailAsyncService implements ConsumerNameAware, Consumer<Event<Map>> {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(MailAsyncService.class);

    @Value("#{config['mail.from.name']}")
    private String fromName;

    @Value("#{config['mail.from.address']}")
    private String fromAddress;

    @Value("#{config['mail.html']}")
    private boolean html = false;

    @Value("#{config['mail.username']}")
    private String account;

    @Value("#{config['mail.password']}")
    private String password;

    @Value("#{config['mail.host']}")
    private String host;

    @Value("#{config['mail.port']}")
    private String port;

    @Value("#{config['mail.smtp.auth']}")
    private boolean auth = true;

    @Value("#{config['mail.smtp.starttls.enable']}")
    private boolean starttls = true;

    @Value("#{config['mail.redirect.address']}")
    private String redirectAddress;

    @Autowired
    private VelocityEngine velocityEngine;

    @Override
    public String getName() {
        return "mail";
    }

    @Override
    public void accept(Event<Map> event) {
        // mailService.sendMail("");
        String command = (String) event.getData().get("command");
        Map map = event.getData();

        switch (command) {
            case "sendBySmtp":
                this.sendBySmtp(
                        map.get("subject") != null ? map.get("subject").toString() : null,
                        map.get("text") != null ? map.get("text").toString() : null,
                        map.get("fromUser") != null ? map.get("fromUser").toString() : null,
                        map.get("fromName") != null ? map.get("fromName").toString() : null,
                        map.get("toUser") != null ? map.get("toUser").toString() : null,
                        map.get("telephone") != null ? map.get("telephone").toString() : null,
                        map.get("toCC") != null ? (InternetAddress[]) map.get("toCC") : null
                );
                break;

            case "registe":
                this.registe(
                        map.get("userId") != null ? (String) map.get("userId") : null,
                        map.get("token") != null ? map.get("token").toString() : null,
                        map.get("subject") != null ? map.get("subject").toString() : null,
                        map.get("fromUser") != null ? map.get("fromUser").toString() : null,
                        map.get("fromName") != null ? map.get("fromName").toString() : null,
                        map.get("toUser") != null ? map.get("toUser").toString() : null,
                        map.get("toCC") != null ? (InternetAddress[]) map.get("toCC") : null
                );
                break;

            case "passwd":
                this.passwd(
                        map.get("userId") != null ? (String) map.get("userId") : null,
                        map.get("token") != null ? map.get("token").toString() : null,
                        map.get("subject") != null ? map.get("subject").toString() : null,
                        map.get("fromUser") != null ? map.get("fromUser").toString() : null,
                        map.get("fromName") != null ? map.get("fromName").toString() : null,
                        map.get("toUser") != null ? map.get("toUser").toString() : null,
                        map.get("toCC") != null ? (InternetAddress[]) map.get("toCC") : null
                );
                break;

            default:
                break;
        }
    }

    @Async
    public void passwd(String userId, String token, String subject, String fromUser, String fromName, final String toUser, InternetAddress[] toCC) {
        Session session = setMailProperties(toUser);

        Map model = new HashMap();
        model.put("link", MessageFormatter.arrayFormat(redirectAddress + "/auth/passwdConfirm?userid={}&token={}", new Object[]{userId, token}).getMessage());

        String body = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mail/passwd.vm", "UTF-8", model);

        try {
            InternetAddress from = new InternetAddress(fromUser, fromName);
            MimeMessage message = new MimeMessage(session);
            message.setFrom(from);
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toUser));
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=utf-8");
            if (toCC != null && toCC.length > 0)
                message.setRecipients(Message.RecipientType.CC, toCC);

            Transport.send(message);

            logger.info("{} 메일주소로 메일을 발송했습니다.", toUser);
        } catch (Exception e) {
            throw new ServiceException("메일을 발송할 수 없습니다.", e);
        }
    }

    @Async
    public void registe(String userId, String token, String subject, String fromUser, String fromName, final String toUser, InternetAddress[] toCC) {
        Session session = setMailProperties(toUser);

        Map model = new HashMap();
        model.put("link", MessageFormatter.arrayFormat(redirectAddress + "/registe/confirm?userid={}&token={}", new Object[]{userId, token}).getMessage());

        String body = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mail/registe.vm", "UTF-8", model);

        try {
            InternetAddress from = new InternetAddress(fromUser, fromName);
            MimeMessage message = new MimeMessage(session);
            message.setFrom(from);
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toUser));
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=utf-8");
            if (toCC != null && toCC.length > 0)
                message.setRecipients(Message.RecipientType.CC, toCC);

            Transport.send(message);

            logger.info("{} 메일주소로 메일을 발송했습니다.", toUser);
        } catch (Exception e) {
            throw new ServiceException("메일을 발송할 수 없습니다.", e);
        }
    }

    @Async
    public void sendBySmtp(String subject, String text, String fromUser, String fromName, final String toUser, String telephone, InternetAddress[] toCC) {
        Session session = setMailProperties(toUser);

        Map<String, Object> model = new HashMap<>();
        model.put("subject", subject);
        model.put("message", text);
        model.put("name", fromName);
        model.put("email", fromUser);
        model.put("telephone", telephone);


        String body = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "mail/contactus.vm", "UTF-8", model);
        try {
            InternetAddress from = new InternetAddress(fromUser, fromName);
            Message message = new MimeMessage(session);
            message.setFrom(from);
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toUser));
            message.setSubject(subject);
//            message.setText(text);
            message.setContent(body, "text/html;charset=utf-8");
            if (toCC != null && toCC.length > 0)
                message.setRecipients(Message.RecipientType.CC, toCC);

            Transport.send(message);

            logger.info("{} 메일주소로 메일을 발송했습니다.", toUser);
        } catch (Exception e) {
            throw new ServiceException("메일을 발송할 수 없습니다.", e);
        }
    }

    private Session setMailProperties(final String toUser) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", auth);
        props.put("mail.smtp.starttls.enable", starttls);
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        LogOutputStream loggerToStdOut = new LogOutputStream() {
            @Override
            protected void processLine(String line, int level) {
                logger.debug("[JavaMail] [{}] {}", toUser, line);
            }
        };

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(account, password);
                    }
                }
        );
        session.setDebug(true);
        session.setDebugOut(new PrintStream(loggerToStdOut));
        return session;
    }

}

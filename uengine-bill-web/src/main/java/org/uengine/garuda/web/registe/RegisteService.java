package org.uengine.garuda.web.registe;

public interface RegisteService {

    void sendRegisteMail(String userName);

    void completeRegiste(String user_id, String token);
}

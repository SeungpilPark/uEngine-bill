package org.uengine.garuda.web.registe;

public interface RegisteService {

    void sendRegisteMail(String email);

    void completeRegiste(String user_id, String token);
}

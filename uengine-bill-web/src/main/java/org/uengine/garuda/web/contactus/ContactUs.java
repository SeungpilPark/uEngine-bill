package org.uengine.garuda.web.contactus;

import org.uengine.garuda.couchdb.CouchDAO;

public class ContactUs extends CouchDAO{

    private String name;
    private String email;
    private String telephone;
    private String subject;
    private String message;
    private Long regDate;
    private Long updDate;

    public ContactUs() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Long getRegDate() {
        return regDate;
    }

    public void setRegDate(Long regDate) {
        this.regDate = regDate;
    }

    public Long getUpdDate() {
        return updDate;
    }

    public void setUpdDate(Long updDate) {
        this.updDate = updDate;
    }

    @Override
    public String toString() {
        return "ContactUs{" +
                "name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", telephone='" + telephone + '\'' +
                ", subject='" + subject + '\'' +
                ", message='" + message + '\'' +
                ", regDate=" + regDate +
                ", updDate=" + updDate +
                '}';
    }
}

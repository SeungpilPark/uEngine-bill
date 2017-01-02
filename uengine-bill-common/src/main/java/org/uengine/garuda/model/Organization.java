package org.uengine.garuda.model;

import org.uengine.garuda.couchdb.CouchDAO;

import java.util.List;

/**
 * Created by uengine on 2016. 12. 28..
 */
public class Organization extends CouchDAO {
    private String industry;
    private String phone;
    private String fax;
    private String website;
    private String languageCode;
    private String timeZone;
    private String dateFormat;
    private String currencyId;
    private String active;


    private List<ContactPoint> contactPoints;


//
//
//    Base Currency
//    Language
//    Time Zone
//    Date Format
//    "contactPoints:[
//    {
//        name:sdfsdf,
//                email:sdfsds,
//            position
//    }
//    ]"
//            "authoriteis[
//    {
//        userId,
//                role: ADMIN,MEMBER
//    }
//    ]"
//    is_org_active
//
//    private Long regDate;
//    private Long updDate;
}

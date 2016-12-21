package org.uengine.garuda.util;

import java.io.Serializable;
import java.util.HashMap;

/**
 * Created by uengine on 2016. 4. 27..
 */
public class Sample extends HashMap implements Serializable {

    private String test;

    private Long regDate;

    public String getTest() {
        return test;
    }

    public void setTest(String test) {
        this.test = test;
    }

    public Long getRegDate() {
        return regDate;
    }

    public void setRegDate(Long regDate) {
        this.regDate = regDate;
    }
}

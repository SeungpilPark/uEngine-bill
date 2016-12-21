package org.uengine.garuda.util;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by uengine on 2015. 5. 22..
 */
public class HttpTest {

    public static void main(String[] args) throws Exception {

        HttpUtils httpUtils = new HttpUtils();

        String type = "POST";
        String url = "http://localhost:8080/oauth/access_token";

        Map params = new HashMap();
        params.put("client_id","9a1e6155-c735-4986-b654-b1269a955666");
        params.put("grant_type","refresh_token");
        params.put("client_secret","fa2fdfbb-2dad-45de-9f1f-d2621cf61971");
        params.put("refresh_token","82df2641-bd88-4b6f-a4a9-ffd1187b605c");

        String postQueryString = HttpUtils.createPOSTQueryString(params);

        Map headers = new HashMap();
        headers.put("Content-Type","application/x-www-form-urlencoded");

        HttpResponse httpResponse = httpUtils.makeRequest(type, url, postQueryString, headers);

        HttpEntity entity = httpResponse.getEntity();
        String s = EntityUtils.toString(entity);
        System.out.println(s);

    }
}

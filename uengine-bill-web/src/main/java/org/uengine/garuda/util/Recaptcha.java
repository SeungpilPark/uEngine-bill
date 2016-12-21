package org.uengine.garuda.util;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.util.JsonUtils;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class Recaptcha {

    public static void validate(String responseString, String url, String secretKey) {
        try {
            DefaultHttpClient httpclient = new DefaultHttpClient();
            HttpPost httpPost = new HttpPost(url);

            List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
            urlParameters.add(new BasicNameValuePair("secret", secretKey));
            urlParameters.add(new BasicNameValuePair("response", responseString));

            httpPost.setEntity(new UrlEncodedFormEntity(urlParameters));

            HttpResponse httpResponse = httpclient.execute(httpPost);
            HttpEntity entity = httpResponse.getEntity();
            String resultString = EntityUtils.toString(entity);
            Map unmarshal = JsonUtils.unmarshal(resultString);
            boolean flag = (boolean) unmarshal.get("success");
            if (!flag)
                throw new ServiceException("중복 방지 확인에 실패하였습니다.");

        } catch (Exception ex) {
            throw new ServiceException("중복 방지 확인에 실패하였습니다.");
        }
    }

    public static String generateShortUUID() {
        UUID uuid = UUID.randomUUID();
        long l = ByteBuffer.wrap(uuid.toString().getBytes()).getLong();
        return Long.toString(l, Character.MAX_RADIX);
    }
}

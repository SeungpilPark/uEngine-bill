package org.uengine.garuda.util;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.uengine.garuda.util.JsonUtils;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NetworkUtils {

    public static boolean isMacAddress(String address){
        Pattern p = Pattern.compile("(([0-9A-Fa-f][0-9A-Fa-f][-:]){5}[0-9A-Fa-f][0-9A-Fa-f])|(([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f].){2}[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])");
        Matcher m = p.matcher(address);
        return m.matches();
    }

    public static String getMacAddress() {
        String macAddress = "";
        try {
            InetAddress addr = InetAddress.getLocalHost();
            NetworkInterface ni = NetworkInterface.getByInetAddress(addr);
            byte[] mac = ni.getHardwareAddress();
            for (int i = 0; i < mac.length; i++) {
                macAddress += String.format("%02X%s", mac[i], (i < mac.length - 1) ? ":" : "");

            }
            macAddress.replaceAll("-", ":");
        } catch (UnknownHostException e) {
            macAddress = null;
        } catch (SocketException e) {
            macAddress = null;
        }
        return macAddress;

    }

    public static String getCountryCode(String ipaddress) {
        try {
            String url = "http://ip-api.com/json/" + ipaddress;

            HttpClient client = HttpClientBuilder.create().build();
            HttpGet request = new HttpGet(url);

            // add request header
            HttpResponse response = client.execute(request);

            HttpEntity entity = response.getEntity();
            String resultString = EntityUtils.toString(entity);

            Map unmarshal = JsonUtils.unmarshal(resultString);
            return unmarshal.get("countryCode").toString();
        } catch (Exception ex) {
            //아이피를 못찾을 경우 디폴트 국가
            return "US";
        }
    }

    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Real-IP");
        if (null != ip && !"".equals(ip.trim())
                && !"unknown".equalsIgnoreCase(ip)) {
            return ip;
        }
        ip = request.getHeader("X-Forwarded-For");
        if (null != ip && !"".equals(ip.trim())
                && !"unknown".equalsIgnoreCase(ip)) {
            // get first ip from proxy ip
            int index = ip.indexOf(',');
            if (index != -1) {
                return ip.substring(0, index);
            } else {
                return ip;
            }
        }
        return request.getRemoteAddr();
    }

    public static String getLocaleFromISOCode(String ISOCode){
        switch (ISOCode){
            case "KR":
                return "ko_KR";
            case "JP":
                return "ja_JP";
            case "CN":
                return "zh_CN";
            default:
                return "en_US";
        }
    }

}

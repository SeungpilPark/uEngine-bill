package org.uengine.garuda.util;


import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class CipherAES {

    private Cipher cipher;

    String key = "FlamingoFlamingo";

    public CipherAES() throws Exception {
        cipher = Cipher.getInstance("AES");
    }

    public String encrypt(String plainText) throws Exception {
        return encrypt(plainText, this.key);
    }

    public String encryptAsHex(String plainText, String key) throws Exception {
        byte[] raw = key.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        byte[] encrypted = cipher.doFinal(plainText.getBytes());
        return asHex(encrypted);
    }

    public String encrypt(String plainText, String key) throws Exception {
        byte[] raw = key.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        byte[] encrypted = cipher.doFinal(plainText.getBytes());
        return new String(encrypted);
    }

    public String decrypt(String cipherText) throws Exception {
        if (cipherText == null) return null;
        return decrypt(cipherText, this.key);
    }

    public String decrypt(String cipherText, String key) throws Exception {
        byte[] raw = key.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        byte[] original = cipher.doFinal(fromString(cipherText));
        return new String(original);
    }

    private static String asHex(byte buf[]) {
        StringBuilder builder = new StringBuilder(buf.length * 2);
        for (int i = 0; i < buf.length; i++) {
            if (((int) buf[i] & 0xff) < 0x10) builder.append("0");
            builder.append(Long.toString((int) buf[i] & 0xff, 16));
        }
        return builder.toString();
    }

    private static byte[] fromString(String hex) {
        int len = hex.length();
        byte[] buf = new byte[((len + 1) / 2)];

        int i = 0, j = 0;
        if ((len % 2) == 1)
            buf[j++] = (byte) fromDigit(hex.charAt(i++));

        while (i < len) {
            buf[j++] =
                    (byte) ((fromDigit(hex.charAt(i++)) << 4)
                            | fromDigit(hex.charAt(i++)));
        }
        return buf;
    }

    private static int fromDigit(char ch) {
        if (ch >= '0' && ch <= '9')
            return ch - '0';
        if (ch >= 'A' && ch <= 'F')
            return ch - 'A' + 10;
        if (ch >= 'a' && ch <= 'f')
            return ch - 'a' + 10;

        throw new IllegalArgumentException("Invalid hex digit '" + ch + "'");
    }
}


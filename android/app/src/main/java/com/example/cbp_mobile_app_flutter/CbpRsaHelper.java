package com.example.cbp_mobile_app_flutter;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.security.*;

import javax.crypto.spec.PSource;

import java.security.spec.MGF1ParameterSpec;

import javax.crypto.*;
import javax.crypto.spec.GCMParameterSpec;

import java.nio.charset.StandardCharsets;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;
import java.io.ByteArrayInputStream;
import java.io.IOException;

import javax.crypto.spec.OAEPParameterSpec;

import java.security.spec.X509EncodedKeySpec;

import io.flutter.Log;


public class CbpRsaHelper {


    @RequiresApi(api = Build.VERSION_CODES.O)
    public PrivateKey getClientRSAPrivateKey() throws Exception {
        // Client to load Client RSA private key either from file system or key management system
        // without "-----BEGIN/END PRIVATE KEY-----"
        String rsaPrivateKey = "MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQDpwNOY69lzDiVf" +
                "pS4cZpiHqAgpnJ92oQ4nvtZeAcwXIcx/7+Ak5YpE+KS6W++HbSEWE0YW3xTUh7di" +
                "hW9Mfre3e2WwtBPhinVKOoGJEzz7+ADXgXnDYvU4IYUEqv9fgdA2QoVK+/3EkFjS" +
                "TkIlzlR5dGnQ6z2GHLXYTKCyCLY+OD2147NL9nXKhM5436zLj63wnNkYw27qpeCy" +
                "oMFBoA7On9P4Vri8QChNVOpNbsKnhRPdOZBtUO9UGbr8Z14qeKBDJ6CCDYvJrRpu" +
                "WLtPBuDc05rlmHD8nX87efO4ZQMJgVKAyXWKevE0JGwShM+3nD9Nm3PnIq33pGGw" +
                "yy4TlFQZAgMBAAECggEBAL/2Ns7SgNTXvSF6yQ9RwdlFyM5DbUFCqhlBw1GYMD6e" +
                "5w35tB0Y1CAoAT952I9is1UpptmJgdW3ToZ+BhTPy5fGopAmkl0aE5BN06r6PY6+" +
                "8BIKpjAqyC68eDyJIQcR2Cd3IXee0Zvm3sp2siPR+dV0IKINTY0hbsSeySjrtp4I" +
                "h+1Lx0X4u0HPDF+rBTp8OzBnKtOCq8LdP2/d5veg6hQhEnh9FdkhYfjXWFPTuGmR" +
                "gwvVPvMrqcrfBagPcajK53Qgj3astR9O3wFYkDUxB46ZNZxj4UgAUR5IBpjgIBhR" +
                "4aLvnuO0PG0aQ6Os6uBRFWKaElo6IEwUWJqPCGuKi3ECgYEA+Nwl/xiAaY+lS2LY" +
                "y5q9oWv5VO/98CBC6uOMU0kgmZPV4e15TLTP9ZIMe5SqCn4U3Il1KGBj505giINo" +
                "8fVPjx2wF9qYyktd1alJX2/DqZO4BOVNudx99lhSIk/KRTQ45jCmD+bXgz10KEfu" +
                "Sz1suQ2KRgbfgO7TcDQe//1JADMCgYEA8HW4gcqzqxtzFt69NInDDFMor4H1xMgF" +
                "wg1FS3zTstnkOkJZFRZDc89s9SWn/Qf/9SDGbdUgzCwdYzj73W67SJgGVCn57CaF" +
                "nbKzmzPd9Dgmz33DhmFlJZ1EJORgjeJwlBfj6pRr5BKznCQCYowgsdw4HyXvS6zq" +
                "aphbkfG/3oMCgYEAodDUTBksdndW7bvqaAnIQEwrJdWfcyInIQCw3/7u2a3NJ0j4" +
                "1K3Fg1JiF4FFR+lPu08OBSEYFPFbx6ha9umhv9d4Byq2quNyslmPQiU0PvG0eEp5" +
                "zd7XcPVhArqLNZCNZvA/KpvZipbNDtwm0HmyVmm9fWc+sWGZzp21gpK5gw0CgYEA" +
                "40BORJO+Y3qItVeCdxGvPYmmDOCE1hm3n2KNV788D25vjEPCDvTAgMXLEpApCDC0" +
                "TQVRouFmoq8agviKyAXrh7rtWENniDAL3TLTHV3SaQlcXIJd9DU9s2PC0B7pxY34" +
                "mW1OoBbvNFgcWPeLLXmDOLSIcZ+XXOypil49RFu12mMCgYEAzApBuueHzCgf8drB" +
                "+jtCYUM/mDEasN9TR7y9w+fmnxGBxzWmPGlQ+Pz7I3PxMw+WUROztIs1nKgH7pDm" +
                "d8cbfwv6MhpB3CEERcIGBdZMlgrWUHIL91yNtesIiphDASCZXXj/daFnO3PLEHXc" +
                "RDsPu1B3xKoqSessNJSeynmbn8M=";
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(rsaPrivateKey.getBytes());
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        byte[] encodedKey = read(byteArrayInputStream);
        encodedKey = Base64.getMimeDecoder().decode(encodedKey);
        return keyFactory.generatePrivate(new PKCS8EncodedKeySpec(encodedKey));
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public PublicKey getCbpMbibRSAPublicKey() throws Exception {
        // Client to load CBP MBIB RSA public key either from file system or key management system
        // Without "-----BEGIN/END PUBLIC KEY-----"
        String rsaPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAycewBxVsn0hv4SLXo4t6" +
                "0A8NWBSH6mdR2Fp6pL8uD+vU8gYJHENoL7kkzgBZwU6PlydVRG7hstluXUqiqtft" +
                "xcSpA91xq3H+peKw4qJSnfKwiX4sgMtMu7Cqdq7kxQDCqTV1Zhv4gcs95yWiSJJT" +
                "2dQCFxOJbLbrp9mo5QtAsFfrc1UwQX0CIRzFvcQD/wypZFN08Cpx+neuYSTuAE0l" +
                "Rb2p2zgFjg3Tn9FaViB3IOxFHol/uwzeoSvagWTEq6FSABzeFQs77Gn+YZjpqvE1" +
                "8wKWX2Yg/IZeLrjqIqq58eizS37yF+c+t6gZO8qoQb6NHqf987+/Avxq8WcjvI9V" +
                "YQIDAQAB";

        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(rsaPublicKey.getBytes());
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        byte[] encodedKey = read(byteArrayInputStream);
        encodedKey = Base64.getMimeDecoder().decode(encodedKey);
        return keyFactory.generatePublic(new X509EncodedKeySpec(encodedKey));
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public PublicKey getCbpMbibRSAClientPublicKey() throws Exception {
        // Client to load CBP MBIB RSA public key either from file system or key management system
        // Without "-----BEGIN/END PUBLIC KEY-----"
        String rsaPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6cDTmOvZcw4lX6UuHGaY" +
                "h6gIKZyfdqEOJ77WXgHMFyHMf+/gJOWKRPikulvvh20hFhNGFt8U1Ie3YoVvTH63" +
                "t3tlsLQT4Yp1SjqBiRM8+/gA14F5w2L1OCGFBKr/X4HQNkKFSvv9xJBY0k5CJc5U" +
                "eXRp0Os9hhy12Eygsgi2Pjg9teOzS/Z1yoTOeN+sy4+t8JzZGMNu6qXgsqDBQaAO" +
                "zp/T+Fa4vEAoTVTqTW7Cp4UT3TmQbVDvVBm6/GdeKnigQyeggg2Lya0abli7Twbg" +
                "3NOa5Zhw/J1/O3nzuGUDCYFSgMl1inrxNCRsEoTPt5w/TZtz5yKt96RhsMsuE5RU" +
                "GQIDAQAB";

        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(rsaPublicKey.getBytes());
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        byte[] encodedKey = read(byteArrayInputStream);
        encodedKey = Base64.getMimeDecoder().decode(encodedKey);
        return keyFactory.generatePublic(new X509EncodedKeySpec(encodedKey));
    }

    public byte[] read(ByteArrayInputStream byteArrayInputStream) throws IOException {
        byte[] buffer = new byte[1024];
        int bytesRead;
        StringBuilder stringBuilder = new StringBuilder();
        while ((bytesRead = byteArrayInputStream.read(buffer)) != -1) {
            stringBuilder.append(new String(buffer, 0, bytesRead));
        }
        return stringBuilder.toString().getBytes();
    }

    public String aesEncryption(String requestMessage, Key oneTimeAESKey, byte[] ivBuffer) {
        Cipher cipher = null;
        try {
            cipher = Cipher.getInstance("AES/GCM/NoPadding");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        }
        try {
            cipher.init(1, oneTimeAESKey, new GCMParameterSpec(128, ivBuffer));
        } catch (InvalidAlgorithmParameterException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        }
        byte[] encryptedText = new byte[0];
        try {
            encryptedText = cipher.doFinal(requestMessage.getBytes(StandardCharsets.UTF_8));
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            return Base64.getMimeEncoder().encodeToString(encryptedText);
        }
        return requestMessage;
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public String rsaEncryption(SecretKey oneTimeAESKey, byte[] ivBuffer, PublicKey cbpMbibRSAPublicKey) throws Exception {
        String encodedKey = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            encodedKey = Base64.getEncoder().encodeToString(oneTimeAESKey.getEncoded());
        }
        String encodedIV = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            encodedIV = Base64.getEncoder().encodeToString(ivBuffer);
        }
        String keyAndIv = encodedIV + "|" + encodedKey;
        Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
        cipher.init(Cipher.ENCRYPT_MODE, cbpMbibRSAPublicKey, new OAEPParameterSpec("SHA-256", "MGF1",
                MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT));
        byte[] encryptedText = cipher.doFinal(keyAndIv.getBytes(StandardCharsets.UTF_8));
        return Base64.getMimeEncoder().encodeToString(encryptedText);

    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public String getSignature(String requestMessage, PrivateKey clientRSAPrivateKey) throws Exception {
        Signature signatureInstance = Signature.getInstance("SHA256withRSA");
        signatureInstance.initSign(clientRSAPrivateKey);
        signatureInstance.update(requestMessage.getBytes(StandardCharsets.UTF_8));
        byte[] signature = signatureInstance.sign();
        return Base64.getEncoder().encodeToString(signature);
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public Boolean verifySignature(String responseMessage, String signature, PublicKey cbpMbibRSAPublicKey) throws Exception {
        Signature signatureInstance = Signature.getInstance("SHA256withRSA");
        signatureInstance.initVerify(cbpMbibRSAPublicKey);
        signatureInstance.update(responseMessage.getBytes(StandardCharsets.UTF_8));
        Boolean verified = signatureInstance.verify(Base64.getMimeDecoder().decode(signature.getBytes()));
        return verified;
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public String rsaDecryption(String textToDecrypt, Key privateKey) throws Exception {
        byte[] textToDecryptBytes = Base64.getMimeDecoder().decode(textToDecrypt);
        Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
        cipher.init(Cipher.DECRYPT_MODE, privateKey, new OAEPParameterSpec("SHA-256", "MGF1",
                MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT));
        byte[] decryptedText = cipher.doFinal(textToDecryptBytes);
        return new String(decryptedText, StandardCharsets.UTF_8);
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public String aesDecryption(String dataInResponseMessage, SecretKey oneTimeAESKey, byte[] decodedIv) throws Exception {
        byte[] textToDecryptBytes = Base64.getMimeDecoder().decode(dataInResponseMessage);
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.DECRYPT_MODE, oneTimeAESKey, new GCMParameterSpec(128, decodedIv));
        byte[] plainTextResponseMessage = cipher.doFinal(textToDecryptBytes);
        return new String(plainTextResponseMessage, StandardCharsets.UTF_8);
    }
}

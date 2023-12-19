package com.example.cbp_mobile_app_flutter;

import android.os.Build;

import androidx.annotation.RequiresApi;

import org.json.JSONObject;

import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.util.HashMap;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

import io.flutter.Log;

public class ApiHelper {
    @RequiresApi(api = Build.VERSION_CODES.O)
    public String makeRequest(String data){

        CbpRsaHelper cbpRsaHelper = new CbpRsaHelper();

        String request = "";
        KeyGenerator keyGen = null;
        try {
            keyGen = KeyGenerator.getInstance("AES");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        keyGen.init(256);
        SecretKey oneTimeAESKey = keyGen.generateKey();

        PublicKey cbpMbibRSAPublicKey = null;

        byte[] ivBuffer = new byte[16];

        try {
            cbpMbibRSAPublicKey = cbpRsaHelper.getCbpMbibRSAPublicKey();
        } catch (Exception e) {
            e.printStackTrace();
        }


        String dataEncryptAes = "";

        try {
            dataEncryptAes = cbpRsaHelper.aesEncryption(data, oneTimeAESKey, ivBuffer);

        } catch (Exception e) {
            e.printStackTrace();
        }

        String secretEncrypt = "";

        try {
            secretEncrypt = cbpRsaHelper.rsaEncryption(oneTimeAESKey, ivBuffer, cbpMbibRSAPublicKey);

        } catch (Exception e) {

            e.printStackTrace();
        }

        HashMap<String, Object> body = new HashMap<>();
        Log.e("secretEncrypt", secretEncrypt);
        Log.e("dataEncryptAes", dataEncryptAes);
        //Callback data
        body.put("data", dataEncryptAes);
        body.put("secret", secretEncrypt);
//        "version": "1.0",
//                "messageId": "4476e673-982f-4573-9c8e-6af9ae1d4b76",
//                "sendTimeStamp": "2023-09-20 12:35:56.056"
        HashMap<String, Object> header = new HashMap<>();
        header.put("version", "1.0");
        header.put("messageId", "4476e673-982f-4573-9c8e-6af9ae1d4b76");
        header.put("sendTimeStamp", "2023-09-20 12:35:56.056");
        HashMap<String, Object> message = new HashMap<>();
        message.put("header", header);
        message.put("body", body);
        String messageJson = new JSONObject(message).toString().replaceAll("\r\n", "");
        String signature = "";
        try {
            Log.e("messageJson", messageJson);
            signature = cbpRsaHelper.getSignature(messageJson, cbpRsaHelper.getClientRSAPrivateKey());
        } catch (Exception e) {
            e.printStackTrace();
        }
        HashMap<String, Object> requestHashMap = new HashMap<>();
        requestHashMap.put("message", message);
        requestHashMap.put("signature", signature);

        request = new JSONObject(requestHashMap).toString().replaceAll("\r\n", "");

        return request;
    }
}

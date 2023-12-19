package com.alphaway.cbp;

import android.os.Build;

import android.renderscript.Sampler;

import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.Base64;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.example.cbp_mobile_app_flutter.ApiHelper;
import com.example.cbp_mobile_app_flutter.CbpRsaHelper;

import io.flutter.Log;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.android.FlutterActivity;

import javax.crypto.spec.*;
import javax.crypto.*;

import java.security.Key;
import java.util.HashMap;
import java.util.Base64;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Map;
import io.flutter.embedding.android.FlutterFragmentActivity;
import android.view.WindowManager.LayoutParams;
import android.os.Bundle;

public class MainActivity extends FlutterFragmentActivity {

    private CbpRsaHelper cbpRsaHelper = new CbpRsaHelper();

    private String publicKeyToString(PublicKey publicKey) {
        byte[] publicKeyBytes = publicKey.getEncoded();
        String publicKeyString = Base64.getEncoder().encodeToString(publicKeyBytes);
        return publicKeyString;
    }

    private String privateKeyToString(PrivateKey privateKey) {
        byte[] privateKeyBytes = privateKey.getEncoded();
        String privateKeyString = Base64.getEncoder().encodeToString(privateKeyBytes);
        return privateKeyString;
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(LayoutParams.FLAG_SECURE, LayoutParams.FLAG_SECURE);
    }   

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "flavor").setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @RequiresApi(api = Build.VERSION_CODES.O)
                    @Override
                    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                        if ("getFlavor".equals(call.method)) {
                            result.success(BuildConfig.FLAVOR);
                        }
                    }
                }
        );

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "cbp_rsa").setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @RequiresApi(api = Build.VERSION_CODES.O)
                    @Override
                    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {


                        ArrayList arguments = (ArrayList) call.arguments;
                        switch (call.method) {

                            case "makeRequest":
                                ApiHelper apiHelper = new ApiHelper();
                                String dataStr = (String) arguments.get(0);
                                String request = apiHelper.makeRequest(dataStr);
                                result.success(request);
                                break;

                            case "aesEncryption":
                                // Encrypt the request message using AES
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

                                String plainText = (String) arguments.get(0);
                                String dataEncryptA = "";

                                try {
                                    dataEncryptA = cbpRsaHelper.aesEncryption(plainText, oneTimeAESKey, ivBuffer);

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                                String secretEncrypt = "";

                                try {
                                    secretEncrypt = cbpRsaHelper.rsaEncryption(oneTimeAESKey, ivBuffer, cbpMbibRSAPublicKey);

                                } catch (Exception e) {

                                    e.printStackTrace();
                                }

                                HashMap<String, Object> bodyData = new HashMap<>();

                                //Callback data
                                bodyData.put("data", dataEncryptA);
                                bodyData.put("secret", secretEncrypt);

                                result.success(bodyData);

                                break;


                            case "getSignature":
                                String plainTextMessage = (String) arguments.get(0);

                                try {
                                    PrivateKey privateKey = cbpRsaHelper.getClientRSAPrivateKey();
                                    String signature = cbpRsaHelper.getSignature(plainTextMessage, privateKey);


                                    result.success(signature);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                break;
                            case "aesDecryption":
                                String dataEncrypt = "";
                                String secret = "";

                                HashMap<String, String> dataMapScan = (HashMap<String, String>) arguments.get(0);

                                if (dataMapScan != null &&
                                        dataMapScan.containsKey("data") &&
                                        dataMapScan.containsKey("secret")) {
                                    dataEncrypt = dataMapScan.get("data");
                                    secret = dataMapScan.get("secret");
                                }


                                String[] keyData = new String[0];

                                try {
                                    Key privateKey = cbpRsaHelper.getClientRSAPrivateKey();
                                    secret.replaceAll("\\r\\n", "");
                                    dataEncrypt.replaceAll("\\r\\n", "");
                                    keyData = cbpRsaHelper.rsaDecryption(secret, privateKey).split("\\|");
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }



                                byte[] decodedKey = Base64.getDecoder().decode(keyData[1]);
                                byte[] decodedIv = Base64.getDecoder().decode(keyData[0]);


                                SecretKey oneTimeAESKeyDecrypt = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");

                                String data = null;
                                try {
                                    data = cbpRsaHelper.aesDecryption(dataEncrypt,
                                            oneTimeAESKeyDecrypt, decodedIv
                                    );
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                result.success(data);

                                break;
                            case "publicKeyData":
                                String publicKeyString = null;
                                try {
                                    PublicKey publicKey = cbpRsaHelper.getCbpMbibRSAClientPublicKey();
                                     publicKeyString = publicKeyToString(publicKey);
                                    
                                } catch (Exception e) {
                                    result.error("KEY_ERROR", e.getMessage(), null);
                                }
                                result.success(publicKeyString);
                                break;
                            case "privateKeyData":
                                 String privateKeyString = null;
                                 try {
                                    PrivateKey privateKey = cbpRsaHelper.getClientRSAPrivateKey();
                                    privateKeyString = privateKeyToString(privateKey);
                                } catch (Exception e) {
                                    result.error("KEY_ERROR", e.getMessage(), null);
                                }
                                result.success(privateKeyString);
                                break;

                        }


                    }
                }
        );
    }
}

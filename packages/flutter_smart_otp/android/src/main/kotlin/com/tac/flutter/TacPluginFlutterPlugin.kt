package com.tac.flutter

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.text.SimpleDateFormat
import java.util.*
import com.thd.makelib.MakeLibNative
import org.json.JSONObject

/** SamplePluginFlutterPlugin */
class TacPluginFlutterPlugin: FlutterPlugin {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  val makeLib by lazy {
    MakeLibNative()
  }
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.thd.flutter/tacsoft")

    val context = flutterPluginBinding.applicationContext;
    channel.setMethodCallHandler(object : MethodChannel.MethodCallHandler{
      override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getInitializeRegisterTAC") {
          val userId = call.argument<String>("userId")
          val response = makeLib.ci(context, userId!!)
          result.success(response)
        } else if (call.method == "onSuccessRegisterTAC") {
          val userId = call.argument<String>("userId")
          val dataTacServer = call.argument<String>("dataTacServer")
          val response = makeLib.di(context, userId!!, dataTacServer!!)
          if(response.isNullOrEmpty()){
            result.success("{\"isActived\": false}")
          }else {
            val json = JSONObject(response)
            val jsonrs = JSONObject()
            jsonrs.put("isActived", json.has("status") && json.getInt("status") == 0)
            result.success(jsonrs.toString())
          }
        } else if (call.method == "doCreateTAC") {
          val userId = call.argument<String>("userId") ?: ""
          val dataTransaction = call.argument<String>("dataTransaction") ?: ""
          val response = makeLib.m(context, userId, dataTransaction)
//          android.util.Log.wtf("ON_GPX",response)
          if(response.isNullOrEmpty()){
            result.success("")
          }else {
            val json = JSONObject(response)
            if( json.has("status") && json.getInt("status") == 0)
                result.success(json.getString("dataSecure"))
            else{
//              android.util.Log.wtf("Error_SmartOTP", if(json.has("status")) "${json.getInt("status")}" else  response)
              result.success("")
            }
          }
        } else if (call.method == "isActiveTAC") {
          val userId = call.argument<String>("userId") ?: ""
          val response = makeLib.ri(context, userId)
          result.success(response)
        } else if (call.method == "doClearTAC") {
          makeLib.rn(context)
          result.success("OK")
        } else {
          result.notImplemented()
        }
      }

    })
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
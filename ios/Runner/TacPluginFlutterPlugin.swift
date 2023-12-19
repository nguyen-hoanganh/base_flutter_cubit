//
//  TacPluginFlutterPlugin.swift
//  Runner
//
//  Created by HungNQ on 27/09/2023.
//

import Foundation
import Flutter
import THDSmartOTP


class TacPluginFlutterPlugin: NSObject{
    var flutterResult: FlutterResult?
    var rootVC: FlutterViewController?

    public func setMethodCallHandler(controller: FlutterViewController) {
        let METHOD_CHANNEL_NAME = "com.thd.flutter/tacsoft"
        let smartTacChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)

        smartTacChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "getInitializeRegisterTAC":// Khởi tạo đăng ký
                if let args = call.arguments as? Dictionary<String, Any>{
                    let inita = KSoftOTP.InitRegisterSmartOTP()

                    result(inita)
                } else {
                    result(FlutterError.init(code: "bad args", message: nil, details: nil))
                }
            case "onSuccessRegisterTAC"://Đăng ký thành công, MB truyền trường data TacServer -> TacSDK
                NSLog("onSuccessRegisterTAC")
                if let args = call.arguments as? Dictionary<String, Any>{
                    let userId = args["userId"] as? String
                    let data = args["dataTacServer"] as? String
                    let rs = KSoftOTP.ConfirmRegisterSmartOTP(data ?? "")
                    let yss = rs ? "true" : "false"
                    result("{\"isActived\": "+yss+"}")

                }
            case "doCreateTAC"://Tạo mã TAC
                if let args = call.arguments as? Dictionary<String, Any>{
                    let userId = args["userId"] as? String ?? ""
                    let tranInfo = (args["dataTransaction"] as? String)  ?? ""
                    var dicValue = NSMutableDictionary()
                    dicValue.setValue(tranInfo, forKey: "tranInfo")

                    dicValue.setValue(userId, forKey: "userId")

                    let res =  KSoftOTP.genSmartOTP(dicValue)

                    result(res)
                }
             case "isActiveTAC"://Check Active
                if let args = call.arguments as? Dictionary<String, Any>{
                    let userId = args["userId"] as? String
                    let yss = KSoftOTP.isActiveSmartOTP() ? "true" : "false"
                    result("{\"isActived\": "+yss+"}")
                }
              case "doClearTAC": // Huý Smart OTP
                KSoftOTP.Clear()
                result("OK")
            default:
                result(FlutterMethodNotImplemented)

            }
        })
    }


}

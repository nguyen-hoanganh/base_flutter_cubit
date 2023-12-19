# THD TECH - TAC SDK MOBILE
Tài liệu cung cấp riêng cho đối tác Alphaway và THD Tech.
Nếu bạn không liên quan, tham gia dự án, vui lòng rời khỏi và báo cho đơn vị hỗ trợ sau đây để được giải quyết.
Hỗ trợ: hieulv.ptit.1993@gmail.com/ 0983907706
## Tac.dart
1. Cài đặt đăng ký TAC
2. Kịch bản xác thực giao dịch
3. Hủy TAC
4. Kiểm tra trạng thái TAC

Kết nối với Module:
```git
// Mở thư mục cha chứa dự án đang phát triển.
git clone  --branch module https://github.com/talk114/FlutterX
cd FlutterX
flutter pub getư
cd to_your_project or example
```
### Import module thông qua phương thức pubspec.yaml
Mở file  pubspec.yaml và cài đặt như dưới đây:
```yaml
dependencies:
  flutter:
    sdk: flutter
  tacmodule:
    path: ../FlutterX
```
Import tac.dart:
```dart
import 'package:tacmodule/tac.dart';
```

##### 1. Cài đặt đăng ký TAC
Lấy String data TAC SDK gửi Server TAC đăng ký xác thực với TAC

```dart
    Future<String> TACSDK.getInitializeRegisterTAC(String userId);
```
| Paramerter | Mô tả                                                            |
| ------ |------------------------------------------------------------------|
| userId | Id định danh User - MBapp + iMocha thống nhất định danh cho user |
* Request Server:
```dart
  "activeData": "string" //  Chuỗi giá trị nhận được từ TAC SDK
```
* Response:
```dart
  "softData": "string"  //  Chuỗi giá trị nhận được từ TAC Server
```
> Thời điểm này TAC đã được kích hoạt thành công cho User trên server. MB App thực hiện đồng bộ TAC Server và TAC SDK thông qua giao thức:
```dart
    Future<bool> TACSDK.onSuccessRegisterTAC( String userId, String dataTacServer);
```
| Paramerter | Mô tả                                                                          |
| ------ |--------------------------------------------------------------------------------|
| userId | Id định danh User - MBapp + iMocha thống nhất 1 thông định danh cho khách hàng |
| dataTacServer | là softData nhận từ response của TAC Server                                    |
> True/False: đăng ký thành công và thất bại.
> Hoàn tất đăng ký kích hoạt.

###### Bảng mô tả trạng thái:

| Paramerter | Mô tả |
| ------ | ------ |
| isActived | Trạng thái TACSDK: true: đã  active TAC thành công. false: chưa active TAC |

##### Kịch bản xác thực giao dịch
Tạo phiên xác thực giao dịch giữa TAC Server và TAC SDK trên Mobile App.
TAC hỗ trợ xác thực IB Web trên MB App.
Để tiến hành xác thực giao dịch, thực hiện như sau:
```dart
    Future<Map<String, dynamic>> TACSDK.doCreateTAC(String userId, List<String> arrayVerify);
```
| Paramerter  | Mô tả                                                                |
|-------------|----------------------------------------------------------------------|
| userId      | Id định danh User                                                    |
| arrayVerify | Trường xác thực giao dịch, cần thống nhất với iMocha server để khớp. |
| isActived   | Trạng thái TAC Smart OTP(bool). True hợp lệ, false không hợp lệ      |
| dataSecure  | Trường dữ liệu xác nhận giao dịch                                    |

> * Response là json có 2 trường isActived và dataSecure

> * Optional: Trường thông tin ký xác thực giao dịch MB App và iMocha Server, 2 bên chủ động thống nhất truyền giống nhau cho TAC Server và TAC SDK.

* Request Server:
```dart
  "secureData": "string" //  Chuỗi giá trị nhận được từ TAC SDK
```
* Response:
```dart
  "code": "string"  //  Chuỗi giá trị nhận được từ TAC Server
```
> Nhận kết quả xác thựcgiao dịch từ TAC Server.

###### Bảng mô tả trạng thái:

| Paramerter | Mô tả |
| ------ | ------ |
| code: 00 | Giao dịch thành công |
| code: 02 | Giao dịch thất bại do thông tin MB App và iMocha không khớp |
| code: 99 | Thời gian thiết bị Mobile App và TAC Server không khớp |
* Chi tiết các mã lỗi cụ thể hơn, xem tại tài liệu TAC Server.


##### 3. Hủy đăng ký TAC
Mobile App thông báo với Server iMocha Hủy đăng ký với TAC Server.
Sau đó, thực hiện hủy toàn bộ tài liệu, chữ ký, dữ liệu dưới TAC SDK, bằng phương thức sau:
```dart
    void TACSDK.doClearTAC( String userId);
```
##### 4. Kiếm tra trạng thái đăng ký TAC trên TAC SDK
```dart
    Future<bool> TACSDK.isActiveTAC( String userId);
```

### II. Install IOS TAC SDK
```sh
    cd example/ios
    pod install
    pod update
```
Di chuyển tới example/ios, mở Runner.xcworkspace bằng IDE Xcode:
Import module THDSmartOTP.framework

Bổ sung cài đặt vào AppDelegate.swift theo mẫu dưới đây
```swift
import UIKit
import Flutter
import THDSmartOTP


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    

     let smartTacChannel = FlutterMethodChannel(name: "com.thd.flutter/tacsoft",
                                              binaryMessenger: controller.binaryMessenger)
      smartTacChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

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
      
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}=
```

Khởi chạy với IOS
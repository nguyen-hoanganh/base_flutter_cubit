import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        self.window.makeSecure()
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let flavorChannel = FlutterMethodChannel(name: "flavor",
                                                 binaryMessenger: controller.binaryMessenger)
        flavorChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            guard call.method == "getFlavor" else {
                result(FlutterMethodNotImplemented)
                return
            }
            self.receiveCurrentFlavor(result: result)
        })
        
        
        let cbpCryptoConfig = CbpCryptoConfig()
        cbpCryptoConfig.setMethodCallHandler(controller: controller)
        
        let tacPlugin = TacPluginFlutterPlugin()
        tacPlugin.setMethodCallHandler(controller: controller)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    
    
    private func receiveCurrentFlavor(result: FlutterResult) {
        var config: [String: Any]?
        
        if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }
        
        result(config?["Flavor"])
    }
}
extension UIWindow {
func makeSecure() {
    let field = UITextField()

    let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))

    let image = UIImageView(image: UIImage(named: "whiteImage"))
    image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

    field.isSecureTextEntry = true

    self.addSubview(field)
    view.addSubview(image)

    self.layer.superlayer?.addSublayer(field.layer)
    field.layer.sublayers?.last!.addSublayer(self.layer)

    field.leftView = view
    field.leftViewMode = .always
  }
}



import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let CHANNEL = "id.acessodigital.native_communication.channel"
    let KEY_NATIVE_LIVENESSX = "showNativeLivenessX"
    var controller: FlutterViewController!
    var methodChannel: FlutterMethodChannel!

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()

        initControler()
        initChannel()
        initMethodHandler()

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func initControler() {
        controller = window?.rootViewController as? FlutterViewController
    }
    
    private func initChannel(){
        methodChannel = FlutterMethodChannel(
            name: CHANNEL,
            binaryMessenger: controller.binaryMessenger
        )
    }
    
    private func initMethodHandler(){
        methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if(call.method == self.KEY_NATIVE_LIVENESSX){

                let tView = AcessoBioView()
                tView.result = result
                let nav = UINavigationController(rootViewController: tView)
                nav.setNavigationBarHidden(false, animated: false)
                nav.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                self.controller.present(nav, animated: true, completion: nil)
                
            }


        })
    }

    
}

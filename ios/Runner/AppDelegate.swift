import UIKit
import Flutter
import GoogleMaps
import flutter_background_service_ios // add this

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   GMSServices.provideAPIKey("AIzaSyAQqGaYBImwBfEwNfZEDkHDbOaJW7Pofrs")
    GeneratedPluginRegistrant.register(with: self)
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "dev.flutter.background.refresh"
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
   
  }
}

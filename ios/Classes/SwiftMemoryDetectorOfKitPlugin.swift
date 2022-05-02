import Flutter
import UIKit

public class SwiftMemoryDetectorOfKitPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "memory_detector_of_kit", binaryMessenger: registrar.messenger())
    let instance = SwiftMemoryDetectorOfKitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}

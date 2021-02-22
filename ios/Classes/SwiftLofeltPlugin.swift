import Flutter
import UIKit
import LofeltHaptics
import os


public class SwiftLofeltPlugin: NSObject, FlutterPlugin {
    
    private static let channelName = "dev.juliengrandchavin.lofelt"
    private var flutterChannel: FlutterMethodChannel!
    private var registrar: FlutterPluginRegistrar? = nil
    
    
    private var haptics: LofeltHaptics?
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
        let instance = SwiftLofeltPlugin(withChannel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
        instance.registrar = registrar
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method) {
        case "init":
            self.initLofelt()
            result(nil)
        case "load":
            self.log(message: "load")
            if let args = call.arguments as? Dictionary<String, Any>,
               let path = args["path"] as? String {
                self.loadFile(flutterPath: path)
                result(nil)
              } else {
                result(FlutterError.init(code: "errorSetDebug", message: "data or format error", details: nil))
              }
        case "play":
            self.play()
            result(nil)
        case "stop":
            self.stop()
            result(nil)
        default:
            self.log(message: "Unknown method called on Lofelt channel.")
        }
        
        
    }
    
    public init(withChannel channel: FlutterMethodChannel) {
        super.init()
        flutterChannel = channel
    }
    
    private func initLofelt() {
        haptics = try? LofeltHaptics.init()
    }
    
    private func loadFile(flutterPath:String) {
        let hapticData = loadHapticData(flutterFilePath: flutterPath)
        try? haptics?.load(hapticData as String)
    }
    
    private func play() {
        try? haptics?.play()
    }
    
    private func stop() {
        try? haptics?.stop()
    }
    
    private func log(message: StaticString) {
        if #available(iOS 10.0, *) {
            os_log(message)
        }
    }
    
    private func loadHapticData(flutterFilePath: String) -> String {
        let key = self.registrar?.lookupKey(forAsset: flutterFilePath)
        let assetPath = Bundle.main.path(forResource: key, ofType: nil)!
        let hapticData = FileManager.default.contents(atPath: assetPath)!
        let dataString = NSString(data: hapticData , encoding: String.Encoding.utf8.rawValue)
        return dataString! as String
    }
}


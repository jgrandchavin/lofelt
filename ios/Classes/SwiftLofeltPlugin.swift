import Flutter
import UIKit
import LofeltHaptics
import os


public class SwiftLofeltPlugin: NSObject, FlutterPlugin {
    
    private static let channelName = "lofelt"
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
            do {
                try initLofelt()
                result(nil)
            } catch {
                result(FlutterError.init(code: "FAILED_TO_INIT_LOFELT", message: "Something went wrong when trying to init lofelt", details: nil))
            }
        case "load":
            do {
                let path = try getPathFromArguments(arguments: call.arguments)
                try loadFile(path: path)
                result(nil)
            } catch LoadHapticFileError.arguments {
                result(FlutterError.init(code: "INVALID_ARGUMENTS", message: "Arguements seems to be badly formatted", details: nil))
            } catch LoadHapticFileError.path {
                result(FlutterError.init(code: "INVALID_PATH", message: "Path is absent in arguements or baddly formatted", details: nil))
            } catch {
                result(FlutterError.init(code: "FAILED_TO_LOAD_FILE", message: "Something went wrong when trying to load .haptic file", details: nil))
            }
        case "play":
            do {
                try play()
                result(nil)
            } catch {
                result(FlutterError.init(code: "FAILED_TO_PLAY_HAPTIC", message: "Something went wrong when trying to load .haptic file", details: nil))
            }
        case "stop":
            do {
                try stop()
                result(nil)
            } catch {
                result(FlutterError.init(code: "FAILED_TO_STOP_HAPTIC", message: "Something went wrong when trying to load .haptic file", details: nil))
            }
            
        default:
            self.log(message: "Unknown method called on Lofelt channel.")
        }
        
        
    }
    
    public init(withChannel channel: FlutterMethodChannel) {
        super.init()
        flutterChannel = channel
    }
    
    private func initLofelt() throws {
        
        haptics = try LofeltHaptics.init()
        
        
    }
    
    private func getPathFromArguments(arguments:Any?)throws -> String {
        guard let args = arguments as? Dictionary<String, Any> else {
            throw LoadHapticFileError.arguments
        }
        
        guard let path = args["path"] as? String else {
            throw LoadHapticFileError.path
        }
        
        return path
    }
    
    private func loadFile(path:String) throws {
        let hapticData = try loadHapticData(path: path)
        try haptics?.load(hapticData as String)
    }
    
    private func play() throws {
        try haptics?.play()
    }
    
    private func stop() throws {
        try haptics?.stop()
    }
    
    
    private func log(message: StaticString) {
        if #available(iOS 10.0, *) {
            os_log(message)
        }
    }
    
    private func loadHapticData(path: String) throws -> String {
        guard let key = self.registrar?.lookupKey(forAsset: path),
              let assetPath = Bundle.main.path(forResource: key, ofType: nil),
              let hapticData = FileManager.default.contents(atPath: assetPath),
              let data = NSString(data: hapticData , encoding: String.Encoding.utf8.rawValue),
              let dataString = data as String?
        else {
            throw LoadHapticFileError.assetNotFound
        }
        return dataString
    }
}


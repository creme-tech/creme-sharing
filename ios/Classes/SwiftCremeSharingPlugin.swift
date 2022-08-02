import Flutter
import UIKit

public class SwiftCremeSharingPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "creme_sharing", binaryMessenger: registrar.messenger())
    let instance = SwiftCremeSharingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch (call.method){
        case "shareToInstagramStories":
          if let storiesUrl = URL(string: "instagram-stories://share") {
              if UIApplication.shared.canOpenURL(storiesUrl) {
                  let arguments = (call.arguments as! [String: Any])
                  let backgroundTopColor = arguments["backgroundTopColor"] as? String
                  let backgroundBottomColor = arguments["backgroundBottomColor"] as? String
                  let stickerImage = arguments["stickerImage"] as? String
                  let backgroundVideo = arguments["backgroundVideo"] as? String
                  let backgroundImage = arguments["backgroundImage"] as? String
                  let contentURL = arguments["contentURL"] as? String
                  var pasteboardItems: [String: Any] = [:]
                  if let backgroundTopColor = backgroundTopColor {
                      pasteboardItems["com.instagram.sharedSticker.backgroundTopColor"] = backgroundTopColor
                  }
                  if let backgroundBottomColor = backgroundBottomColor {
                      pasteboardItems["com.instagram.sharedSticker.backgroundBottomColor"] = backgroundBottomColor
                  }
                  if let contentURL = contentURL {
                      pasteboardItems["com.instagram.sharedSticker.contentURL"] = contentURL
                  }
                  if let stickerImageData = getImageData(source: stickerImage) {
                      pasteboardItems["com.instagram.sharedSticker.stickerImage"] = stickerImageData
                  }
                  if let backgroundImageData = getImageData(source: backgroundImage) {
                      pasteboardItems["com.instagram.sharedSticker.backgroundImage"] = backgroundImageData
                  }
                  if let backgroundVideo = getVideoData(source: backgroundVideo) {
                      print(backgroundVideo)
                      pasteboardItems["com.instagram.sharedSticker.backgroundVideo"] = backgroundVideo
                  }
                  if #available(iOS 10.0, *) {
                      let pasteboardOptions = [
                        UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
                      ]
                      UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                      UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
                      return result("User have instagram on their device.")
                  }
                  return result("work only in IOS 10.0 or newer")
              } else {
                  result("User doesn't have instagram on their device.")
              }
          }
        default:
          result(FlutterMethodNotImplemented)
      }
  }
    
    private func getImageData(source: String?) -> Data? {
        guard let source = source  else { return nil }
        guard let url = URL(string: source) else { return nil }
        if url.isFileURL {
            return UIImage(contentsOfFile: source)?.pngData()
        }
        if let dataDecoded = Data(base64Encoded: source) {
            return UIImage(data: dataDecoded)?.pngData()
        }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)?.pngData()
    }
    
    private func getVideoData(source: String?) -> NSData? {
        guard let source = source else { return nil }
        print(source)
        guard let url = NSURL(string: source) else { return nil }
        print(source)
        guard let urlData = NSData(contentsOf: url as URL) else { return nil }
        print(urlData)
        return urlData
    }
}






import Flutter
import Photos
import UIKit

public class SwiftCremeSharingPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "creme_sharing", binaryMessenger: registrar.messenger())
    let instance = SwiftCremeSharingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "instagramIsAvailableToShare":
      if let storiesUrl = URL(string: "instagram-stories://share") {
        if UIApplication.shared.canOpenURL(storiesUrl) {
          if #available(iOS 10.0, *) {
            return result(true)
          }
          return result(false)
        } else {
          return result(false)
        }
      }
    case "instagramIsAvailableToShareFeed":
      if let storiesUrl = URL(string: "instagram://") {
        if UIApplication.shared.canOpenURL(storiesUrl) {
          if #available(iOS 10.0, *) {
            return result(true)
          }
          return result(false)
        } else {
          return result(false)
        }
      }
    case "whatsappIsAvailableToShare":
      if let whatsappUrl = URL(string: "whatsapp://send?text=Message") {
        if UIApplication.shared.canOpenURL(whatsappUrl) {
          if #available(iOS 10.0, *) {
            return result(true)
          }
          return result(false)
        } else {
          return result(false)
        }
      }
    case "twitterIsAvailableToShare":
      if let twitterUrl = URL(string: "twitter://post?message=Message") {
        if UIApplication.shared.canOpenURL(twitterUrl) {
          if #available(iOS 10.0, *) {
            return result(true)
          }
          return result(false)
        } else {
          return result(false)
        }
      }
    case "shareTextToTwitter":
      let arguments = (call.arguments as! [String: Any])
      let message = arguments["message"] as? String
      var components = URLComponents(string: "twitter://post")!
      components.queryItems = [URLQueryItem(name: "message", value: message)]
      if let url = components.url, UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10.0, *) {
          UIApplication.shared.openURL(url)
          return result(nil)
        }
      } else {
        return result(nil)
      }
    case "shareTextToWhatsapp":
      let arguments = (call.arguments as! [String: Any])
      let message = arguments["message"] as? String
      let whatsMessage = "whatsapp://send?text=\(message!)"
      var characterSet = CharacterSet.urlQueryAllowed
      characterSet.insert(charactersIn: "?&")
      let whatsAppURL = NSURL(
        string: whatsMessage.addingPercentEncoding(withAllowedCharacters: characterSet)!)
      if UIApplication.shared.canOpenURL(whatsAppURL! as URL) {
        if #available(iOS 10.0, *) {
          UIApplication.shared.openURL(whatsAppURL! as URL)
          return result(nil)
        }
        return result(nil)
      } else {
        return result(nil)
      }
    case "shareToInstagramFeed":
      let arguments = (call.arguments as! [String: Any])
      guard let image = arguments["image"] as? String else { return result(nil) }
      guard let source = Data(base64Encoded: image) else { return result(nil) }
      let instagramURL = NSURL(string: "instagram://")
      if UIApplication.shared.canOpenURL(instagramURL! as URL) {
        if let dataDecoded = UIImage(data: source) {
          postImageToInstagram(image: dataDecoded)
        }
        return result(nil)
      } else {
        return result(nil)
      }
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
            pasteboardItems["com.instagram.sharedSticker.backgroundBottomColor"] =
              backgroundBottomColor
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
            pasteboardItems["com.instagram.sharedSticker.backgroundVideo"] = backgroundVideo
          }
          if #available(iOS 10.0, *) {
            let pasteboardOptions = [
              UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
            ]
            UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
            UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
            return result(nil)
          }
          return result(nil)
        } else {
          return result(nil)
        }
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getImageData(source: String?) -> Data? {
    guard let source = source else { return nil }
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
    guard let url = NSURL(string: source) else { return nil }
    guard let urlData = NSData(contentsOf: url as URL) else { return nil }
    return urlData
  }

  private func postImageToInstagram(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(
      image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }

  @objc private func image(
    _ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer
  ) {
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    if let lastAsset = fetchResult.firstObject {
      let url = URL(string: "instagram://library?LocalIdentifier=\(lastAsset.localIdentifier)")!
      if UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10.0, *) {
          UIApplication.shared.open(url)
        } else {
        }
      } else {
      }
    }
  }

}

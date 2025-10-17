import Flutter
import UIKit
import InsideMobileiOS
import WebKit

public class FlutterPowerfrontPlugin: NSObject, FlutterPlugin, InsideClientDelegate {

  private var client: InsideClient?
  private var viewController: UIViewController?
  private var channel: FlutterMethodChannel?
  // Add a static instance to maintain a strong reference
  private static var instance: FlutterPowerfrontPlugin?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_powerfront", binaryMessenger: registrar.messenger())
    instance = FlutterPowerfrontPlugin()
    registrar.addMethodCallDelegate(instance!, channel: channel)
      
    instance!.channel = channel
 
    if let controller = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
        instance!.viewController = controller
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    // Powerfront methods
    case "init":
      print("init method was called")
      powerfrontInit(call: call, result: result)
    case "trackView":
      print("trackView method was called")
      result(true)
    case "push":
      print("push method was called")
      powerfrontPush(result: result)
    case "pushView":
      print("pushView method was called")
      powerfrontPushView()
    case "presentView":
      print("presentView method was called")
      powerfrontPresentView()
    case "getUnreadMessagesCount":
      print("getUnreadMessagesCount method was called")
      getUnreadMessagesCount(result: result)
    case "dismiss":
      print("dismiss method was called")
      viewController?.dismiss(animated: true, completion: nil)
      result(true)
    case "disconnect":
      print("disconnect method was called")
      client?.disconnect()
      result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  //getUnreadMessagesCount
  func getUnreadMessagesCount(result: @escaping FlutterResult){
      let unreadMessagesCount = client?.unreadMessagesCount
      if let count = unreadMessagesCount {
          result(Int(count))
      } else {
          result(0)
      }
  }
  
  // consider the use of powerfrontPresentView instead this one (at least for now)
  func powerfrontPushView() {
    guard let chatViewController = client?.chatViewController else {
      print("Error: chatViewController is nil")
      return
    }

    // Find the nearest navigation controller in the view hierarchy
    if let navigationController = viewController?.navigationController ?? viewController as? UINavigationController {
        navigationController.pushViewController(chatViewController, animated: true)
    } else {
        // Fallback to present modally if no navigation controller is available
        viewController?.present(chatViewController, animated: true, completion: nil)
    }
  }

  // this one is working fine, the Push View not so much
  func powerfrontPresentView() {
    guard let chatViewController = client?.chatViewController else {
      print("Error: chatViewController is nil")
      return
    }

    chatViewController.view.backgroundColor = .white

    if let webView = chatViewController.view.subviews.first(where: { $0 is WKWebView }) {
        webView.backgroundColor = .white
        (webView as? WKWebView)?.isOpaque = false
    }
      viewController?.present(chatViewController, animated: true, completion: nil)
  }


  func powerfrontPush(result: @escaping FlutterResult){
    client?.push()
    result(true)
  }

  // init power front chat integration
  func powerfrontInit(call: FlutterMethodCall, result: @escaping FlutterResult){
    // check the parameters
    guard let params = call.arguments as? NSDictionary else {
      result(FlutterError.invalidParams)
      return
    }
      
    if let chatVC = client?.chatViewController {
        chatVC.willMove(toParent: nil)
        chatVC.view.removeFromSuperview()
        chatVC.removeFromParent()
    }
      
    client = nil

    if let domainURL = params["domainURL"] as? String,
       let accountKey = params["accountKey"] as? String,
       let mobileSiteURL = params["mobileSiteURL"] as? String,
       let appName = params["appName"] as? String,
       let subsiteId = params["subsiteId"] as? String {
       
        client = InsideClient(
            domainURL: domainURL,
            accountKey: accountKey,
            mobileSiteURL: mobileSiteURL,
            appName: appName,
            subsiteId: subsiteId
        )

        if let localClient = client {
            localClient.delegate = self
            client = localClient
            result(true)
        } else {
            result(FlutterError(code: "Initialization Error", message: "Failed to initialize InsideClient", details: nil))
        }
    } else {
        result(FlutterError.invalidParams("Missing or invalid parameters"))
    }
  }

  //  --------------------------------------
  //  listeners from the Powerfront Delegate
  //  --------------------------------------
  public func onConnected() {
      self.channel?.invokeMethod("onConnected", arguments: nil);
  }
  
  public func onChatAvailable(_ available: Bool) {
    let arguments: [String: Bool] = [
      "available": available,
    ]
    // Envia para o Flutter
    self.channel?.invokeMethod("onChatAvailable", arguments: arguments)
  }
  
  public func onChatMessage(messageText: String, proactiveChat: Bool, senderName: String, operatorImageUrl: String?) {
    let arguments: [String: Any?] = [
      "messageText": messageText,
      "proactiveChat": proactiveChat,
      "senderName": senderName,
      "operatorImageUrl": operatorImageUrl
    ]

    // Envia para o Flutter
    self.channel?.invokeMethod("onChatMessage", arguments: arguments)
  }
  
  public func onAddToBasket(productId: String, skuId: String, completionBlock: @escaping ((Bool) -> Void)) {
    let arguments: [String: Any?] = [
      "productId": productId,
      "skuId": skuId,
    ]

    // TODO - handle completionBlock

    // Envia para o Flutter
    self.channel?.invokeMethod("onAddToBasket", arguments: arguments)
  }
  
  public func onViewProductDetails(productId: String, skuId: String?) {
    let arguments: [String: Any?] = [
      "productId": productId,
      "skuId": skuId,
    ]

    // Envia para o Flutter
    self.channel?.invokeMethod("onViewProductDetails", arguments: arguments)
  }
  
  public func onChatClose() {
    channel?.invokeMethod("onChatClose", arguments: nil) { result in
      // If the Flutter returns an error, it will come as FlutterError
      if let error = result as? FlutterError {
          print("Error calling onChatClose on Flutter: \(error.code) – \(error.message ?? "")")
      }
      // Now that the method has been invoked (successfully or not), close the view on the main thread
      DispatchQueue.main.async {
          self.viewController?.dismiss(animated: true, completion: nil)
      }
    }
  }

    
  public func onChatMinimise() {
    self.channel?.invokeMethod("onChatMinimise", arguments: nil);
  }
  
  public func onChatEnded(_ endedBy: String) {
    let arguments: [String: Any?] = [
      "endedBy": endedBy,
    ]

    // Envia para o Flutter
    self.channel?.invokeMethod("onChatEnded", arguments: arguments)
  }
  
  public func onDisconnected() {
    self.channel?.invokeMethod("onDisconnected", arguments: nil);
  }
  
  public func onError(message: String, statusCode: Int) {
    let arguments: [String: Any?] = [
      "message": message,
      "statusCode": statusCode,
    ]

    // Envia para o Flutter
    self.channel?.invokeMethod("onError", arguments: arguments)
  }
  
  public func onLinkTapped(url: URL?) -> Bool {
    let arguments: [String: String?] = [
      "url": url?.absoluteString
    ]

    // Send to Flutter and wait for result
    self.channel?.invokeMethod("onLinkTapped", arguments: arguments, result: { (result) in
      // Handle result if needed
    })
      
    return true
  }
  //  ----------------------------------------------------
  //  ---- END listeners from the Powerfront Delegate ----
  //  ----------------------------------------------------


  // ---- Life Cycle events -----
  // Notify server when app entered in background
  public func applicationDidEnterBackground(_ application: UIApplication) {
    client?.disconnect()
  }
    // Notify server when app is about to terminatprivate e
  public func applicationWillTerminate(_ application: UIApplication) {
    client?.disconnect()
  }
}

extension FlutterError {
    static func invalidParams(_ message: String?) -> FlutterError {
        return FlutterError.init(code: "Invalid Params", message: message, details: nil)
    }
    
    static var invalidParams: FlutterError {
        return FlutterError.init(code: "Invalid Params", message: "", details: "")
    }
}

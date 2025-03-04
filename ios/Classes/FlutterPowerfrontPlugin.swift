import Flutter
import UIKit
import InsideMobileiOS

public class FlutterPowerfrontPlugin: NSObject, FlutterPlugin, InsideClientDelegate {

  private var client: InsideClient?
  private var viewController: UIViewController?
  private var channel: FlutterMethodChannel?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_powerfront", binaryMessenger: registrar.messenger())
    let instance = FlutterPowerfrontPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
    instance.channel = channel

    // save the main controller
    if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
      if let navController = rootViewController as? UINavigationController {
        instance.viewController = navController
      } else {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        instance.viewController = navigationController
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
      }
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
    case "setUser":
      print("presentView method was called")
      powerfrontSetUser(call: call, result: result)
    case "getUnreadMessagesCount":
      print("getUnreadMessagesCount method was called")
      powerfrontPresentView()
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  //getUnreadMessagesCount
  func getUnreadMessagesCount(){}
  
  // consider the use of powerfrontPresentView instead this one (at least for now)
  func powerfrontPushView() {
    guard let chatViewController = client?.chatViewController else {
      print("Error: chatViewController is nil")
      return
    }

    guard let navController = viewController?.navigationController else {
      print("Error: NavigationController is nil")
      return
    }

    navController.pushViewController(chatViewController, animated: true)
  }

  // this one is working fine, the Push View not so much
  func powerfrontPresentView() {
    guard let chatViewController = client?.chatViewController else {
      print("Error: chatViewController is nil")
      return
    }

    viewController?.present(chatViewController, animated: true, completion: nil)
  }

  func powerfrontSetUser(call: FlutterMethodCall, result: @escaping FlutterResult) {

    guard let params = call.arguments as? NSDictionary else {
      result(FlutterError.invalidParams)
      return
    }

    if let userId = params["userId"] as? String,
       let name = params["name"] as? String{
        client.setUser(userId:userId, name:name)
        }else {
        result(FlutterError.invalidParams("Missing or invalid parameters"))
    }

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

        if let client = client {
            client.delegate = self
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
    self.channel?.invokeMethod("onChatClose", arguments: nil);

    // close the chat
    self.viewController?.dismiss(animated: true, completion: nil)
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
    let arguments: [String: Any?] = [
      "url": url,
    ]

    // Envia para o Flutter
    self.channel?.invokeMethod("onLinkTapped", arguments: arguments)
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

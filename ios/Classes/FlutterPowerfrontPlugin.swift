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

  private func findWKWebView(in view: UIView) -> WKWebView? {
      if let wv = view as? WKWebView { return wv }
      for sub in view.subviews {
          if let found = findWKWebView(in: sub) { return found }
      }
      return nil
  }

 private func forceInsideIframeFullscreenReliable(in chatVC: UIViewController) {

     let js = """
     (function () {
       function apply() {
         var iframe = document.getElementById('insideChatFrame');
         if (!iframe) return false;

         iframe.style.position = 'fixed';
         iframe.style.top = '0';
         iframe.style.left = '0';
         iframe.style.right = '0';
         iframe.style.bottom = '0';
         iframe.style.width = '100vw';
         iframe.style.height = '100vh';
         iframe.style.maxWidth = '100%';
         iframe.style.maxHeight = '100%';
         iframe.style.borderRadius = '0';
         iframe.style.boxShadow = 'none';
         iframe.style.margin = '0';
         iframe.style.zIndex = '2147483647';

         var holder = document.getElementById('inside_holder');
         if (holder) {
           holder.style.position = 'fixed';
           holder.style.top = '0';
           holder.style.left = '0';
           holder.style.right = '0';
           holder.style.bottom = '0';
           holder.style.width = '100vw';
           holder.style.height = '100vh';
           holder.style.margin = '0';
         }

         var overlay = document.getElementById('inside_overlay');
         if (overlay) {
           overlay.style.position = 'fixed';
           overlay.style.top = '0';
           overlay.style.left = '0';
           overlay.style.right = '0';
           overlay.style.bottom = '0';
           overlay.style.width = '100vw';
           overlay.style.height = '100vh';
         }

         if (!window.__insideFullscreenObserver) {
           window.__insideFullscreenObserver = new MutationObserver(function(){ apply(); });
           window.__insideFullscreenObserver.observe(document.documentElement, { childList:true, subtree:true, attributes:true });
         }
         return true;
       }
       return apply();
     })();
     """

     let start = Date()

     func tick() {
         guard let webView = self.findWKWebView(in: chatVC.view) else {
             if Date().timeIntervalSince(start) < 20.0 {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { tick() }
             } else {
                 print("WKWebView not found within timeout ⏱️")
             }
             return
         }
         webView.evaluateJavaScript(js) { result, error in
             let ok = (result as? Bool) == true
             if ok {
                 print("Applied fullscreen iframe styles ✅")
                 return
             }

             if Date().timeIntervalSince(start) < 20.0 {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { tick() }
             } else {
                 if let error = error {
                     print("Iframe not found within timeout ⏱️. Last JS error: \(error)")
                 } else {
                     print("Iframe not found within timeout ⏱️")
                 }
             }
         }
     }

     DispatchQueue.main.async { tick() }
 }


  
  // consider the use of powerfrontPresentView instead this one (at least for now)
func powerfrontPushView() {
    guard let chatViewController = client?.chatViewController else {
        print("Error: chatViewController is nil")
        return
    }
  chatViewController.view.backgroundColor = .white
    if let navigationController =
        viewController?.navigationController ??
        (viewController as? UINavigationController) {

        navigationController.pushViewController(chatViewController, animated: true)

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.forceInsideIframeFullscreenReliable(in: chatViewController)
        }

    } else {
        viewController?.present(chatViewController, animated: true) { [weak self] in
            guard let self else { return }
            self.forceInsideIframeFullscreenReliable(in: chatViewController)
        }
    }
}
  private var isIPad: Bool {
    UIDevice.current.userInterfaceIdiom == .pad
  }

func powerfrontPresentView() {
  guard let chatViewController = client?.chatViewController else {
    print("Error: chatViewController is nil")
    return
  }
  chatViewController.view.backgroundColor = .white

viewController?.present(chatViewController, animated: true, completion: { [weak self] in
  guard let self else { return }
  self.forceInsideIframeFullscreenReliable(in: chatViewController)
})

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

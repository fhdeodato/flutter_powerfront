package com.example.powerfront.flutter_powerfront

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import android.app.Activity
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

import com.powerfront.insidewebsdkandroid.interfaces.InsideChatInterface
import com.powerfront.insidewebsdkandroid.InsideClient

/** FlutterPowerfrontPlugin */
class FlutterPowerfrontPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    InsideChatInterface {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private lateinit var insideClient: InsideClient

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_powerfront")
        channel.setMethodCallHandler(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onLoad(){}

    override fun onChatUnavailable(){}

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "init" -> {
                val websiteUrl = call.argument<String>("websiteUrl") ?: ""
                val accountKey = call.argument<String>("accountKey") ?: ""
                val serverUrl = call.argument<String>("serverUrl") ?: ""
                val appName = call.argument<String>("appName") ?: ""
                val subsiteId = call.argument<String>("subsiteId") ?: ""
                initializeInsideClient(websiteUrl, accountKey, serverUrl, appName, subsiteId)
                result.success(null)
            }
            "presentView" -> {
                val top = call.argument<Int>("top") ?: 0
                val bottom = call.argument<Int>("bottom") ?: 0
                attachChatPane(top, bottom)
                result.success(null)
            }
            "detachChatPane" -> {
                insideClient.detachChatPane()
                result.success(null)
            }
            // "setFcmToken" -> {
            //     val token = call.argument<String>("token") ?: ""
            //     insideClient.setFcmToken(token)
            //     result.success(null)
            // }
            else -> result.notImplemented()
        }
    }

    private fun initializeInsideClient(
        websiteUrl: String,
        accountKey: String,
        serverUrl: String,
        appName: String,
        subsiteId: String
    ) {
        activity?.let { act ->
            insideClient = InsideClient.getInstance(act)
            insideClient.setChatInterface(this)
            // call according integration manual
            insideClient.initialize(act, websiteUrl, accountKey, serverUrl, appName, subsiteId)
        }
    }

    private fun attachChatPane(top: Int, bottom: Int) {
        activity?.let { act ->
            insideClient.attachChatPane(act, top, bottom)
        }
    }

    override fun unReadCount(p0: Int): Unit{
      // TODO - implement
    }

    override fun onError(message: String, statusCode: Int) {
      val arguments = hashMapOf("message" to message, "statusCode" to statusCode)

      channel.invokeMethod("onError", arguments)
    }

    //calback implementations
    override fun onConnected() {
        channel.invokeMethod("onConnected", null)
    }

    override fun onChatVisible() {
        channel.invokeMethod("onChatVisible", null)
    }

    fun onChatAvailable(available: Boolean) {
        channel.invokeMethod("onChatAvailable", available)
    }

    override fun onChatAvailable() {
        channel.invokeMethod("onChatAvailable", null)
    }

    override fun onChatNotificationReceived(msg: String, isProactiveChat: Boolean, fromName: String, image: String?) {
        val map = hashMapOf("msg" to msg, "isProactiveChat" to isProactiveChat)
        channel.invokeMethod("onChatNotificationReceived", map)
    }

    override fun onCloseChat() {
        channel.invokeMethod("onCloseChat", null)
    }

    // fun onChatMinimise() {}
    override fun onMinimiseChat(){
        channel.invokeMethod("onChatMinimise", null)
    }

    override fun requirePermissions(status: Boolean) {
        channel.invokeMethod("requirePermission", status)
    }

    override fun canAppHandleUrl(url: String): Boolean {
      var resultValue = false
      val latch = java.util.concurrent.CountDownLatch(1)
      channel.invokeMethod("canAppHandleUrl", url, object : MethodChannel.Result {
          override fun success(result: Any?) {
              if (result is Boolean) {
                  resultValue = result
              }
              latch.countDown()
          }
          override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
              latch.countDown()
          }
          override fun notImplemented() {
              latch.countDown()
          }
      })
      latch.await()
      return resultValue
    }

    override fun onChatEndedBy(name: String) {
        channel.invokeMethod("onChatEndedBy", name)
    }

    override fun onDisconnectedToChat() {
        channel.invokeMethod("onDisconnectedToChat", null)
    }

    override fun onAddToBasket(productId: String, skuId: String) {
        val map = hashMapOf("productId" to productId, "skuId" to skuId)
        channel.invokeMethod("onAddToBasket", map)
    }

    override fun onViewProductDetails(productId: String, skuId: String?) {
        val map = hashMapOf("productId" to productId, "skuId" to skuId)
        channel.invokeMethod("onViewProductDetails", map)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

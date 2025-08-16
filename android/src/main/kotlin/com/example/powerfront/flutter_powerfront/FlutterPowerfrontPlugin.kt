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
import android.content.Intent
import java.math.BigDecimal

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
                val domainURL = call.argument<String>("domainURL") ?: ""
                val accountKey = call.argument<String>("accountKey") ?: ""
                val mobileSiteURL = call.argument<String>("mobileSiteURL") ?: ""
                val appName = call.argument<String>("appName") ?: ""
                val subsiteId = call.argument<String>("subsiteId") ?: ""
                val isLoadingEnabled = call.argument<Boolean>("isLoadingEnabled") ?: true
                initializeInsideClient(domainURL, accountKey, mobileSiteURL, appName, subsiteId, isLoadingEnabled)
                result.success(null)
            }
            "dismiss" -> {
                // Dismiss pode ser implementado fechando a view do chat
                // Se houver uma view ativa, fechar ela
                result.success(true)
            }
            "disconnect" -> {
                // Método disconnect() existe e é obrigatório conforme documentação
                insideClient.disconnect()
                result.success(true)
            }
            "setView" -> {
                // Implementar setView conforme documentação
                val type = call.argument<String>("type") ?: ""
                val name = call.argument<String>("name") ?: ""
                val image = call.argument<String>("image") ?: ""
                val url = call.argument<String>("url") ?: ""
                val price = call.argument<String>("price") ?: ""
                val category = call.argument<String>("category") ?: ""
                val sku = call.argument<String>("sku") ?: ""
                val customData = call.argument<HashMap<String, Any>>("customData")
                val tags = call.argument<List<String>>("tags")
                
                // TODO: use setView with InsideViewType
                result.success(true)
            }
            "push" -> {
                // TODO: pending implementation
                insideClient.push()
                result.success(true)
            }
            "pushView" -> {
                // pushView is similar to presentView but with different navigation
                try {
                    val top = call.argument<Int>("top") ?: 0
                    val bottom = call.argument<Int>("bottom") ?: 0
                    attachChatPane(top, bottom)
                    result.success(null)
                } catch (e: Exception) {
                    result.error("PUSHVIEW_ERROR", "Error pushing view", e.message)
                }
            }
            "presentView" -> {
                val top = call.argument<Int>("top") ?: 0
                val bottom = call.argument<Int>("bottom") ?: 0
                attachChatPane(top, bottom)
                result.success(null)
            }
            "getUnreadMessagesCount" -> {
                val count = insideClient.unreadMessagesCount
                result.success(count)
            }
            "detachChatPane" -> {
                insideClient.detachChatPane()
                result.success(null)
            }
            "setUser" -> {
                val email = call.argument<String>("email") ?: ""
                val name = call.argument<String>("name") ?: ""
                val data = call.argument<HashMap<String, Any>>("data")

                // TODO: pending implementation
                // if (data != null) {
                //     insideClient.setUser(email, name, data)
                // } else {
                //     insideClient.setUser(email, name)
                // }
                result.success(true)
            }
            "addItemToCart" -> {
                val sku = call.argument<String>("sku") ?: ""
                val name = call.argument<String>("name") ?: ""
                val price = call.argument<String>("price") ?: "0"
                val quantity = call.argument<Int>("quantity") ?: 1
                val category = call.argument<String>("category") ?: ""
                val image = call.argument<String>("image") ?: ""
                
                val bigDecimalPrice = BigDecimal(price)
                // TODO: pending implementation
                // insideClient.cart.addItem(sku, name, bigDecimalPrice, quantity, category, image)
                result.success(true)
            }
            "updateItemToCart" -> {
                val sku = call.argument<String>("sku") ?: ""
                val name = call.argument<String>("name") ?: ""
                val price = call.argument<String>("price") ?: "0"
                val quantity = call.argument<Int>("quantity") ?: 1
                val image = call.argument<String>("image") ?: ""
                
                val bigDecimalPrice = BigDecimal(price)
                // TODO: pending implementation
                // insideClient.cart.updateItem(sku, name, bigDecimalPrice, quantity, image)
                result.success(true)
            }
            "removeItemFromCart" -> {
                val sku = call.argument<String>("sku") ?: ""
                insideClient.cart.removeItem(sku)
                result.success(true)
            }
            "clearCart" -> {
                insideClient.cart.clearItems()
                result.success(true)
            }
            "completeOrder" -> {
                val orderId = call.argument<String>("orderId") ?: ""
                val orderTotal = call.argument<String>("orderTotal") ?: "0"
                
                val bigDecimalTotal = BigDecimal(orderTotal)
                // TODO: pending implementation
                // insideClient.cart.complete(orderId, bigDecimalTotal)
                result.success(true)
            }
            "abandonCart" -> {
                // TODO: pending implementation
                // insideClient.cart.abandonCart()
                result.success(true)
            }
            "setCartOrderTotal" -> {
                val orderTotal = call.argument<String>("orderTotal") ?: "0"
                val bigDecimalTotal = BigDecimal(orderTotal)
                // TODO: pending implementation
                // insideClient.cart.setOrderTotal = bigDecimalTotal
                result.success(true)
            }
            "addCartData" -> {
                val key = call.argument<String>("key") ?: ""
                val value = call.argument<String>("value") ?: ""
                insideClient.cart.addData(key, value)
                result.success(true)
            }
            "setFcmToken" -> {
                val token = call.argument<String>("token") ?: ""
                insideClient.setFcmToken(token)
                result.success(true)
            }
            "showHideDefaultLoader" -> {
                val isEnabled = call.argument<Boolean>("isEnabled") ?: true
                insideClient.showHideDefaultLoader(isEnabled)
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    private fun initializeInsideClient(
        domainURL: String,
        accountKey: String,
        mobileSiteURL: String,
        appName: String,
        subsiteId: String,
        isLoadingEnabled: Boolean
    ) {
        activity?.let { act ->
            insideClient = InsideClient.getInstance(act)
            insideClient.setChatInterface(this)

            insideClient.showHideDefaultLoader(isLoadingEnabled)
            // call according integration manual
            insideClient.initialize(act, mobileSiteURL, accountKey, domainURL, appName, subsiteId)
        }
    }

    private fun attachChatPane(top: Int, bottom: Int) {
        activity?.let { act ->
            insideClient.attachChatPane(act, top, bottom)
        }
    }

    override fun unReadCount(count: Int) {
        val arguments = hashMapOf("count" to count)
        activity?.runOnUiThread {
            channel.invokeMethod("onUnreadCount", arguments)
        }

    }

    override fun onError(message: String, statusCode: Int) {
        val arguments = hashMapOf("message" to message, "statusCode" to statusCode)
        activity?.runOnUiThread {
            channel.invokeMethod("onError", arguments)
        }
    }

    //calback implementations
    override fun onConnected() {
        activity?.runOnUiThread {
            channel.invokeMethod("onConnected", null)
        }
    }

    override fun onChatVisible() {
        activity?.runOnUiThread {
            channel.invokeMethod("onChatVisible", null)
        }
    }

    override fun onChatAvailable() {
        activity?.runOnUiThread {
            channel.invokeMethod("onChatAvailable", true)
        }
    }

    override fun onChatNotificationReceived(msg: String, isProactiveChat: Boolean, fromName: String, image: String?) {
        val map = hashMapOf(
            "messageText" to msg, 
            "proactiveChat" to isProactiveChat,
            "senderName" to fromName,
            "operatorImageUrl" to image
        )
        activity?.runOnUiThread {
            channel.invokeMethod("onChatMessage", map)
        }
    }

    override fun onCloseChat() {
        activity?.runOnUiThread {
            channel.invokeMethod("onChatClose", null)
        }
    }

    override fun onMinimiseChat(){
        activity?.runOnUiThread {
            channel.invokeMethod("onChatMinimise", null)
        }
    }

    override fun requirePermissions(status: Boolean) {
        activity?.runOnUiThread {
            channel.invokeMethod("requirePermission", status)
        }
    }

    override fun canAppHandleUrl(url: String): Boolean {
        var resultValue = false
        val latch = java.util.concurrent.CountDownLatch(1)

        val map = hashMapOf("url" to url)
        activity?.runOnUiThread {
            channel.invokeMethod("onLinkTapped", map, object : MethodChannel.Result {
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
        }
        latch.await()
        return resultValue
    }

    override fun onChatEndedBy(name: String) {
        val map = hashMapOf("endedBy" to name)
        activity?.runOnUiThread {
            channel.invokeMethod("onChatEnded", map)
        }
    }

    override fun onDisconnectedToChat() {
        activity?.runOnUiThread {
            channel.invokeMethod("onDisconnected", null)
        }
    }

    override fun onAddToBasket(productId: String, skuId: String) {
        val map = hashMapOf("productId" to productId, "skuId" to skuId)
        activity?.runOnUiThread {
            channel.invokeMethod("onAddToBasket", map)
        }
    }

    override fun onViewProductDetails(productId: String, skuId: String?) {
        val map = hashMapOf("productId" to productId, "skuId" to skuId)
        activity?.runOnUiThread {
            channel.invokeMethod("onViewProductDetails", map)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        activity?.runOnUiThread {
            channel.setMethodCallHandler(null)
        }
    }

    // Attachment handler
    fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) {
        insideClient.onActivityResult(requestCode, resultCode, intent)
    }
}

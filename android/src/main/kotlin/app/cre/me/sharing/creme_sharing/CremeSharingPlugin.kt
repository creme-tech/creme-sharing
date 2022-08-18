package app.cre.me.sharing.creme_sharing

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** CremeSharingPlugin */
class CremeSharingPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  var activity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "creme_sharing")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "whatsappIsAvailableToShare" -> {
          result.success(appIsAvailableToShare("com.whatsapp"))
        }
        "twitterIsAvailableToShare" -> {
          result.success(appIsAvailableToShare("com.twitter.android"))
        }
        "instagramIsAvailableToShare" -> {
          result.success(appIsAvailableToShare("com.instagram.android"))
        }
        "shareTextToWhatsapp" -> {
          val text = call.argument<String?>("message")
          shareTextToWhatsapp(text)
          result.success(null)
        }
      "shareTextToTwitter" -> {
        val text = call.argument<String?>("message")
        shareTextToTwitter(text)
        result.success(null)
      }
        else -> {
          result.notImplemented()
        }
    }
  }

  private fun shareTextToTwitter(text: String?) {
    val tweetIntent = Intent(Intent.ACTION_SEND)
    tweetIntent.putExtra(Intent.EXTRA_TEXT, text)
    tweetIntent.type = "text/plain"
    tweetIntent.`package` = "com.twitter.android"
    tweetIntent.setClassName("com.twitter.android", "com.twitter.composer.ComposerActivity")
    activity?.startActivity(tweetIntent)
  }

  private fun shareTextToWhatsapp(text: String?) {
    val whatsappIntent = Intent(Intent.ACTION_SEND)
    whatsappIntent.putExtra(Intent.EXTRA_TEXT, text)
    whatsappIntent.type = "text/plain"
    whatsappIntent.`package` = "com.whatsapp"
    activity?.startActivity(whatsappIntent)
  }

  private fun appIsAvailableToShare(packageName: String): Boolean {
    return try {
      val packageManager = activity?.applicationContext?.packageManager
      packageManager?.getPackageInfo(packageName, 0)
      true
    } catch (e: PackageManager.NameNotFoundException) {
      false
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}

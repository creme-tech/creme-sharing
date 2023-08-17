package app.cre.me.sharing.creme_sharing

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.io.File

/** CremeSharingPlugin */
class CremeSharingPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var shareToInstagramStoriesResult: Result? = null
    private var shareToInstagramFeedResult: Result? = null
    private val instagramStoriesRequestCode: Int = 0xc0c3
    private val instagramFeedRequestCode: Int = 0xc0ce


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "creme_sharing")
        channel.setMethodCallHandler(this)
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == instagramStoriesRequestCode) {
            shareToInstagramStoriesResult?.success(null)
            shareToInstagramStoriesResult = null
            return true
        }
        if (requestCode == instagramFeedRequestCode) {
            shareToInstagramFeedResult?.success(null)
            shareToInstagramFeedResult = null
            return true
        }
        return false
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "shareToInstagramFeed" -> {
                val imageAssetPath = call.argument<String>("imageAssetPath")
                val imageAssetType = call.argument<String>("imageAssetType")
                if (imageAssetPath != null && imageAssetType != null) {
                    shareToInstagramFeed(
                        imageAssetPath = imageAssetPath,
                        imageAssetType = imageAssetType,
                        result = result,
                    )
                } else {
                    result.success(null)
                }
            }
            "shareToInstagramStories" -> {
                val backgroundAssetPath = call.argument<String>("backgroundAssetPath")
                val backgroundAssetType = call.argument<String>("backgroundAssetType")
                val topBackgroundColor = call.argument<String>("topBackgroundColor")
                val bottomBackgroundColor = call.argument<String>("bottomBackgroundColor")
                val sourceApplication = call.argument<String>("sourceApplication")
                val interactiveAssetPath = call.argument<String?>("interactiveAssetPath")
                if (backgroundAssetPath != null
                    && backgroundAssetType != null
                    && topBackgroundColor != null
                    && bottomBackgroundColor != null
                    && sourceApplication != null
                ) {
                    shareToInstagramStories(
                        backgroundAssetPath = backgroundAssetPath,
                        backgroundAssetType = backgroundAssetType,
                        topBackgroundColor = topBackgroundColor,
                        bottomBackgroundColor = bottomBackgroundColor,
                        sourceApplication = sourceApplication,
                        interactiveAssetPath = interactiveAssetPath,
                        result = result,
                    )
                } else {
                    result.success(null)
                }
            }
            "whatsappIsAvailableToShare" -> {
                result.success(appIsAvailableToShare("com.whatsapp"))
            }
            "twitterIsAvailableToShare" -> {
                result.success(appIsAvailableToShare("com.twitter.android"))
            }
            "instagramIsAvailableToShare" -> {
                result.success(appIsAvailableToShare("com.instagram.android"))
            }
            "shareTextToInstagramDirect" -> {
                val text = call.argument<String?>("message")
                shareTextToInstagramDirect(text)
                result.success(null)
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

    private fun shareToInstagramFeed(
        imageAssetType: String,
        imageAssetPath: String,
        result: Result,
    ) {
        val activityCopy = activity
        if (activityCopy != null) {
            val imageAssetFile = File(imageAssetPath)
            val imageAssetUri = FileProvider.getUriForFile(
                activityCopy,
                activityCopy.packageName + ".social.share.fileprovider",
                imageAssetFile
            )
            val intent = Intent(Intent.ACTION_SEND)
            intent.type = imageAssetType
            intent.putExtra(Intent.EXTRA_STREAM, imageAssetUri)
            intent.setPackage("com.instagram.android")
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            val chooser = Intent.createChooser(intent, "Share to")
            val resInfoList = activityCopy.packageManager.queryIntentActivities(
                chooser,
                PackageManager.MATCH_DEFAULT_ONLY
            )
            for (resolveInfo in resInfoList) {
                val packageName = resolveInfo.activityInfo.packageName
                activityCopy.grantUriPermission(
                    packageName,
                    imageAssetUri,
                    Intent.FLAG_GRANT_READ_URI_PERMISSION
                )
            }
            if (activityCopy.packageManager.resolveActivity(intent, 0) != null) {
                activityCopy.startActivityForResult(intent, instagramFeedRequestCode)
                shareToInstagramFeedResult = result
            }
        } else {
            result.success(null)
        }

    }

    private fun shareToInstagramStories(
        backgroundAssetPath: String,
        backgroundAssetType: String,
        topBackgroundColor: String,
        bottomBackgroundColor: String,
        sourceApplication: String,
        interactiveAssetPath: String?,
        result: Result,
    ) {
        val activityCopy = activity
        if (activityCopy != null) {
            val backgroundAssetFile = File(backgroundAssetPath)
            val backgroundAssetUri = FileProvider.getUriForFile(
                activityCopy,
                activityCopy.packageName + ".social.share.fileprovider",
                backgroundAssetFile
            )
            val intent = Intent("com.instagram.share.ADD_TO_STORY")
            intent.setDataAndType(backgroundAssetUri, backgroundAssetType)
            intent.putExtra("source_application", sourceApplication)
            intent.putExtra("top_background_color", topBackgroundColor)
            intent.putExtra("bottom_background_color", bottomBackgroundColor)
            if (interactiveAssetPath != null) {
                val interactiveAssetFile = File(interactiveAssetPath)
                val interactiveAssetUri = FileProvider.getUriForFile(
                    activityCopy,
                    activityCopy.packageName + ".social.share.fileprovider",
                    interactiveAssetFile
                )
                intent.putExtra("interactive_asset_uri", interactiveAssetUri)
                val resInfoList = activityCopy.packageManager.queryIntentActivities(
                    intent,
                    PackageManager.MATCH_DEFAULT_ONLY
                )
                for (resolveInfo in resInfoList) {
                    val packageName = resolveInfo.activityInfo.packageName
                    activityCopy.grantUriPermission(
                        packageName,
                        interactiveAssetUri,
                        Intent.FLAG_GRANT_READ_URI_PERMISSION
                    )
                }
            }
            intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION
            if (activityCopy.packageManager.resolveActivity(intent, 0) != null) {
                activityCopy.startActivityForResult(intent, instagramStoriesRequestCode)
                shareToInstagramStoriesResult = result
            }
        } else {
            result.success(null)
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

    private fun shareTextToInstagramDirect(text: String?) {
        val instagramIntent = Intent(Intent.ACTION_SEND)
        instagramIntent.putExtra(Intent.EXTRA_TEXT, text)
        instagramIntent.type = "text/plain"
        instagramIntent.`package` = "com.instagram.android"
        activity?.startActivity(instagramIntent)
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
        binding.addActivityResultListener(this)
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        binding.addActivityResultListener(this)
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}

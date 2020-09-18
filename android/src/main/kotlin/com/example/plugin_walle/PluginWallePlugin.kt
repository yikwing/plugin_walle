package com.example.plugin_walle

import android.content.Context
import androidx.annotation.NonNull
import com.meituan.android.walle.WalleChannelReader
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** PluginWallePlugin */
class PluginWallePlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "plugins.yikwing.com/flutter_walle_plugin")

        context = flutterPluginBinding.applicationContext

        channel.setMethodCallHandler(this)
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getWalleChannel") {
            getWalleChannel(result)
        } else if (call.method == "getWalleChannelInfo") {
            getWalleChannelInfo(result)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    fun getWalleChannel(result: Result) {
        val channel = WalleChannelReader.getChannel(context)
        result.success(channel)
    }

    fun getWalleChannelInfo(result: Result) {
        val channelInfo = WalleChannelReader.getChannelInfo(context)
        if (channelInfo != null) {
            val channel = channelInfo.channel
            val extraInfo = channelInfo.extraInfo
            extraInfo["channel"] = channel
            result.success(extraInfo)
        } else {
            result.success(null)
        }
    }
}

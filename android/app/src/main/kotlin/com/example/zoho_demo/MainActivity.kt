package com.example.zoho_demo

import com.zoho.desk.asap.api.ZDPortalCallback.SetUserCallback
import com.zoho.desk.asap.api.ZDPortalException
import com.zoho.desk.asap.api.ZohoDeskPortalSDK
import com.zoho.desk.asap.asap_tickets.ZDPortalTickets

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private lateinit var channel: MethodChannel
    private var CHANNEL_NAME = "ZOHO_DESK"
    private var ACTION_NAME = "ZOHO_DESK/OPEN_TICKETS"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler { call, result ->
            if (call.method == ACTION_NAME) {
                val arguments = call.arguments as Map<*, *>
                val userToken = arguments["jwt"] as? String ?: ""
                var apiProvider: ZohoDeskPortalSDK? = null
                ZohoDeskPortalSDK.Logger.enableLogs()
                apiProvider = ZohoDeskPortalSDK.getInstance(applicationContext)
                apiProvider.initDesk(772007754, "edbsn0aa30d069760e8835119870f3942b335e4ae9493a6bb327a1b355ddb0a4d24cb", ZohoDeskPortalSDK.DataCenter.US)
                apiProvider.setUserToken(
                    userToken,
                    object : SetUserCallback {
                        override fun onUserSetSuccess() {
                            println("Success login")
                            ZDPortalTickets.show(this@MainActivity)
                        }

                        override fun onException(e: ZDPortalException) {
                            println("error: " + e.message)
                        }
                    },
                    true
                )
                result.success(true)
            }
        }

        super.configureFlutterEngine(flutterEngine)
    }
}
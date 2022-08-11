package com.example.alquranapp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterShellArgs

class MainActivity: FlutterActivity() {
    override fun getFlutterShellArgs(): FlutterShellArgs {
        //Log.d("Main Activity", "getFlutterShellArgs: false")
        return FlutterShellArgs(arrayOf("--enable-skparagraph=false"))
    }
}

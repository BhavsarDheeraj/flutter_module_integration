package com.dheerajbhavsar.flutterpoc

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

private const val FLUTTER_ENGINE_ID = "flutter_engine"

class MainActivity : AppCompatActivity() {

    lateinit var flutterEngine : FlutterEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache
            .getInstance()
            .put(FLUTTER_ENGINE_ID, flutterEngine)


        val flutterAppButton = findViewById<Button>(R.id.button)
        flutterAppButton.setOnClickListener {
            startActivity(
                FlutterActivity
                    .withCachedEngine(FLUTTER_ENGINE_ID)
                    .build(this)
            )

            val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.dheerajbhavsar.flutter_poc/data")
            val json = JSONObject()
            json.put("message", "Hello from Android \uD83D\uDC4B\uD83C\uDFFB")
            methodChannel.invokeMethod("fromHostToClient", json.toString())
        }
    }
}
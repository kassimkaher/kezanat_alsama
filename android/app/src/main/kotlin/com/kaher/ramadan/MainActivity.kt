
package  com.kaher.ramadan
import android.app.Activity
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.ContentResolver
import android.content.Context
import android.graphics.BitmapFactory
import android.media.AudioAttributes
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import com.kaher.ramadan.R
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "ramadan_method_chanall"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)



        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->

            if (call.method == "pushIosNotification") {

                var title: String? = call.argument("title");
                var body: String? = call.argument("body");
                var id: Int? = call.argument("id");

push(this,id!!,title!!,body!!)


            }
        }
    }




    fun push(context: Context, id:Int, title:String, body:String) {




//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            val name = "channelId_1_3_52"
//            val descriptionText = "channelId_1_3_52"
//            val importance = NotificationManager.IMPORTANCE_DEFAULT
//            val channel = NotificationChannel("channelId_1_3_51", name, importance).apply {
//                description = descriptionText
//
//                // Register the channel with the system
//                val notificationManager: NotificationManager =
//                    getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
//                notificationManager.createNotificationChannel(channel)
//
//
//                val sound =
//                    Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + "://" + context.getPackageName() + "/" + R.raw.athan) //Here is FILE_NAME is the name of file that you want to play
//
//                val attributes = AudioAttributes.Builder()
//                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
//                    .build()
//
//
//                channel.enableVibration(true)
//                channel.setSound(sound, attributes)
//
//
//                val builder =
//                    Notification.Builder(context, "channelId_1_3_5").setContentTitle(title)
//                        .setContentText(body)
//
//                notificationManager.notify(id, builder.build())
//            }
//        }
//



    }


}

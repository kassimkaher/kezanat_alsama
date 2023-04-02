import UIKit
import Flutter

import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate  {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
//      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
//        GeneratedPluginRegistrant.register(with: registry)
//    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

     // UNUserNotificationCenter.current().delegate = self
let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "ramadan_method_chanall",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        
        
        if call.method == "cancelAllNotification" {
            
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            result("cancelAllNotification done")
        }
      
if call.method == "pushIosNotification" {

     
      guard let args = call.arguments else {
        return
      }
    let data = args as? [String: Any]

     let title  = data?["title"] as? String
      let body  = data?["body"] as? String
       let sound  = data?["sound"] as? String
  let year  = data?["year"] as? Int
   let month  = data?["month"] as? Int
    let day  = data?["day"] as? Int
     let hour  = data?["hour"] as? Int
      let minuts  = data?["minuts"] as? Int
    let second  = data?["second"] as? Int
 
    
    
    do {
        self.pushNotification(title: title!, body: body!, year: year!, month: month!, day: day!, hour: hour!, minuts: minuts!,second: second!, sound: sound!,result:result)
       
       } catch {
           result("pushNotification error")
       }
    
    
 
}


    })
   
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func pushNotification(title:String,body:String,year:Int, month:Int,day:Int,hour:Int,minuts:Int,second:Int, sound:String,result: @escaping FlutterResult){
 
    let content = UNMutableNotificationContent()
    content.title = title
  
    content.subtitle = body
      content.sound = .default
  
  content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: sound))
    var comps = DateComponents() // <1>
    comps.day = day
    comps.month = month
    comps.year = year
    comps.hour = hour
    comps.minute = minuts
      comps.second = second
 

    
    let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
   
   
    let request = UNNotificationRequest(identifier:"rmadan_ios_id_\(year)_\(month)_\(day)_\(hour)_\(minuts)", content: content, trigger: trigger)
      UNUserNotificationCenter.current().add(request){ (error : Error?) in
          if let theError = error {
              print(theError.localizedDescription)
              result(theError.localizedDescription)
          }
          else{
              result("pushNotification done")
          }
      }
}
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.sound,.banner])
        } else {
            // Fallback on earlier versions
        }
    }
 
}

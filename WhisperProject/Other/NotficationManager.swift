//
//  NotficationManager.swift
//  SwfitfulThinkingPart 2
//
//  Created by Abdelrahman Shera on 25/10/2023.
//

import SwiftUI
import UserNotifications


class NotficationManager {
    static let shared = NotficationManager()
    
    func requestAuthorizatoin(){
        let options : UNAuthorizationOptions = [.alert , .badge , .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error : \(error)")
            } else {
                print("success")
            }
        }
    }
    
    func scheduleNotification(title: String , body : String , subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = body
        content.subtitle = subtitle
        content.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:0.1, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        
        
// README
        /*
         Triggers Types:
         1 ) time
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
         2) calender
                         var dateComponents = DateComponents()
                         dateComponents.hour = 20
                         dateComponents.minute = 60
                         let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
         
         3) location
                         let coordinates = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
                         let region = CLCircularRegion(center: coordinates,
                                                       radius: 100,
                                                       identifier: UUID().uuidString
                         let trigger = UNLocationNotificationTrigger(region: , repeats: true)
                         
                                                       region.notifyOnEntry = true
         Note to clear badge number on icon
         .onAppear{
             UIApplication.shared.applicationIconBadgeNumber = 0
         }
         
         
         call functions
         NotficationManager.instance.requestAuthorizatoin()
         NotficationManager.instance.scheduleNotification()
         */
  
        
    }
    
    
}

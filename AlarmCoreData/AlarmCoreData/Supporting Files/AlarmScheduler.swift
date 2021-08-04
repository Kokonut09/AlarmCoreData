//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Andrew Saeyang on 8/3/21.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: AnyObject {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler{
    func scheduleUserNotifications(for alarm: Alarm){
        let content = UNMutableNotificationContent()
        content.title = "Lets go"
        content.body = "Your alarm named \(alarm.title!) is going off!"
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.month, .day, .year, .hour, .minute, .second], from: alarm.fireDate!)
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid!, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Error scheudling local user notifications \(error.localizedDescription) : \(error)")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm){
        guard let id = alarm.uuid else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}

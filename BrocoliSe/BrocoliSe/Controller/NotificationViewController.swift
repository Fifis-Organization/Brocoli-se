//
//  NotificationViewController.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 13/10/21.
//

import UIKit
import UserNotifications

class NotificationViewController {
    
    func schenduleNotificationMorning(trigger: UNNotificationTrigger) {
            
        let center = UNUserNotificationCenter.current()
              
        let content = UNMutableNotificationContent()
        content.title = "Bom dia"
        content.body = "Não vamos perder o foco, cada dia é um avanço importante!"
        content.sound = .default

        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

        center.add(request) { (error) in
            if error != nil {
                print("erro")
            }
        }
    }
    
    func schenduleNotificationNight(trigger: UNNotificationTrigger) {
            
        let center = UNUserNotificationCenter.current()
              
        let content = UNMutableNotificationContent()
        content.title = "Boa noite"
        content.body = "Lembre-se de marcar os item que você não consumiu hoje!"
        content.sound = .default

        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

        center.add(request) { (error) in
            if error != nil {
                print("erro")
            }
        }
    }
}

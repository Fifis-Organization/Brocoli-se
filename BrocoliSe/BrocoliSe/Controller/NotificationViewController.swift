//
//  NotificationViewController.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 13/10/21.
//

import UIKit
import UserNotifications

enum MessagesMorning: String, CaseIterable {
    case morning = "Não vamos perder o foco, cada dia é um avanço importante!"
}
enum MessagesNight: String, CaseIterable {
    case night = "Lembre-se de marcar os item que você não consumiu hoje!"
}

enum Title: String, CaseIterable {
    case morning = "Bom dia"
    case night = "Boa noite"
}

class NotificationViewController {
    
    func schenduleNotificationMorning(trigger: UNNotificationTrigger) {
            
        let center = UNUserNotificationCenter.current()
              
        let content = UNMutableNotificationContent()
        content.title = Title.morning.rawValue
        content.body = {
            switch content.title {
            case Title.morning.rawValue:
                let text = MessagesMorning.allCases.randomElement()!.rawValue
                return text
            default:
                let text = "Não vamos perder o foco, cada dia é um avanço importante!"
                return text
            }
        }()
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
        content.title = Title.night.rawValue
        content.body = {
            switch content.title {
            case Title.night.rawValue:
                let text = MessagesNight.allCases.randomElement()!.rawValue
                return text
            default:
                let text = "Lembre-se de marcar os item que você não consumiu hoje!"
                return text
            }
        }()
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

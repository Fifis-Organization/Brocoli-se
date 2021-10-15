//
//  NotificationViewController.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 13/10/21.
//

import UIKit
import UserNotifications

enum MessageReceita: String, CaseIterable {
    case text1 = "Que tal conhecer novos substitutos de carne?"
    case text2 = "Que tal conhecer novos substitutos de leite?"
    case text3 = "Larissa chata pra krl, mds reclama demaaaaaiiiis!!!!"
    case text4 = "Que tal conhecer novos substitutos de manteiga?"
   
}

enum MessageSubstituto: String, CaseIterable {
    case text1 = "Vamos conhecer mais uma receita hoje?"
}

enum Title: String, CaseIterable {
    case text1 = "Substituto"
    case text2 = "Novas Receitas"
}

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func schenduleNotification() {
            
        let center = UNUserNotificationCenter.current()
              
        let content = UNMutableNotificationContent()
        content.title = Title.allCases.randomElement()!.rawValue
        content.body = {
            switch content.title {
            case Title.text1.rawValue:
                let text = MessageReceita.allCases.randomElement()!.rawValue
                return text
            case Title.text2.rawValue:
                let text = MessageSubstituto.allCases.randomElement()!.rawValue
                return text
            default:
                let text = "erro"
                return text
            }
        }()
        content.sound = .default
              
//        let date = Date().addingTimeInterval(43200) //43200 segundos = 12 horas
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
//        Add image
//        guard let path = Bundle.main.path(forResource: "brocolis-animado", ofType: "png") else {return}
//        let imageUrl = URL(fileURLWithPath: path)
//
//        do {
//            let attachment = try UNNotificationAttachment(identifier: "brocolis-animado", url: imageUrl, options: nil)
//            content.attachments = [attachment]
//        } catch {
//            print("The attachment could not be loaded")
//        }
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

//        dateComponents.weekday = 6  // Friday
        dateComponents.hour = 10    // 10:00 hours
//        dateComponents.minute = 00
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // -------- Create the request ------------
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
              
        // -------- Register the request -----------
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

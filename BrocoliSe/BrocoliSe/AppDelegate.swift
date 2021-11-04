//
//  AppDelegate.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    let notification = NotificationViewController()
    let persistentService = PersistenceService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // UserDefaults.standard.set(true, forKey: "First Launch")
        if !persistentService.getKeyValue(udKey: .firstLaunch) {
            self.persistentService.persist(udKey: .vibrations, value: true)
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound]) { authorization, error  in
                    self.persistentService.persist(udKey: .notifications, value: authorization)
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 9
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        var dateComponents2 = DateComponents()
        dateComponents2.calendar = Calendar.current
        dateComponents2.hour = 21
        
        let trigger2 = UNCalendarNotificationTrigger(
            dateMatching: dateComponents2, repeats: true)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        notification.schenduleNotificationMorning(trigger: trigger)
        notification.schenduleNotificationNight(trigger: trigger2)
        persistentService.persist(udKey: .firstLaunch, value: true)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

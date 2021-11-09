//
//  SiriUtil.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 05/11/21.
//

import IntentsUI

class SiriUtil {
    
    private static func recoverVoiceShortcut(whenMatchWith shortcut: INShortcut,  completion: @escaping (INVoiceShortcut?) -> () ) {
        // recover all the shortcuts added to siri (voicesShortcuts)
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (voicesShortcuts, error) in
            // if there is an eerror, we gonna only do nothing (return)
            if error != nil {
                return
            }
            // get the first voiceShortcut that the activityType matches with our shortcut
            let voiceShortcut = voicesShortcuts?.first(where: { (voiceShort) -> Bool in
                return voiceShort.shortcut.userActivity?.activityType == shortcut.userActivity?.activityType
            })
            completion(voiceShortcut)
        }
    }
    
    static func openShortcutViewController(caller: UIViewController, shortcut: INShortcut, open: @escaping (UIViewController) -> Void ) {
        var addShortcutVC: INUIAddVoiceShortcutViewController?
        var editShortcutVC: INUIEditVoiceShortcutViewController?
        
        //calls our auxiliary func to recover the voiceShortcut that matches with the shortcut received
        self.recoverVoiceShortcut(whenMatchWith: shortcut) { (voiceShortcut) in
            // if the shortcut isn't already added it will be nil
            if voiceShortcut == nil {
                // init an instance of the modal to add shortcut set its delegate and call the open
                addShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcut)
                addShortcutVC?.delegate = (caller as! INUIAddVoiceShortcutViewControllerDelegate)
                open(addShortcutVC!)
            } else {
                // init an instance of the modal to edit shortcut set its delegate and call the open
                editShortcutVC = INUIEditVoiceShortcutViewController(voiceShortcut: voiceShortcut!)
                editShortcutVC?.delegate = (caller as! INUIEditVoiceShortcutViewControllerDelegate)
                open(editShortcutVC!)
            }
            
        }
    }
}


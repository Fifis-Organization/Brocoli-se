//
//  SiriActivities.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 05/11/21.
//

import UIKit
import Intents
import CoreSpotlight
import MobileCoreServices

class SiriActivities {
    public static func openSecondVCActivity(thumbnail: UIImage?) -> NSUserActivity {
        // create an activity with our activityType (that is used as an identifier)
        let activity = NSUserActivity(activityType: SiriActivitiesType.openSecondVCActivity.rawValue)
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(SiriActivitiesType.openSecondVCActivity.rawValue)
        
        // turn it activity elegible to be found by siri's search
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        
        // format the shortcut card
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        activity.title = "Open second view controller"
        attributes.thumbnailData = thumbnail?.jpegData(compressionQuality: 1.0)
        activity.suggestedInvocationPhrase = "siri test"
        activity.contentAttributeSet = attributes
        
        return activity
    }
}

enum SiriActivitiesType: String  {
    case openSecondVCActivity = "com.brocolise.checklist"
}


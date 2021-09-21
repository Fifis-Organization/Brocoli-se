import Foundation
import UIKit

enum TabBarPage {
    case diary
    case album

    init?(index: Int) {
        switch index {
        case 0:
            self = .diary
        case 1:
            self = .album
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .diary:
            return "Diário"
        case .album:
            return "Álbum"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .diary:
            return 0
        case .album:
            return 1
        }
    }
    
    func pageIcon() -> UIImage {
        switch self {
        case .diary:
            return UIImage(named: "daily-icon") ?? UIImage()
        case .album:
            return UIImage(named: "album-icon") ?? UIImage()
        }
    }
    
}

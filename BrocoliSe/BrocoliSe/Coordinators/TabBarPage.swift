//
//  TabBarPage.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 14/09/21.
//

import Foundation

enum TabBarPage {
    case daily
    case album

    init?(index: Int) {
        switch index {
        case 0:
            self = .daily
        case 1:
            self = .album
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .daily:
            return "Diário"
        case .album:
            return "Álbum"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .daily:
            return 0
        case .album:
            return 1
        }
    }
}

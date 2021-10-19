//
//  AlbumSceneMock.swift
//  BrocoliSeTests
//
//  Created by Samuel Sales on 13/10/21.
//

import Foundation
@testable import BrocoliSe

class AlbumSceneMock: AlbumSceneDelegate {
    var controller: AlbumViewController?
    var user: User?
    var reload: Bool = false
    
    func setController(controller: AlbumViewController) {
        self.controller = controller
    }
    
    func setUser(user: User?) {
        self.user = user
    }
    
    func setupDatas() {
        controller?.fetchUser()
    }
    
    func reloadCollection() {
        self.reload = true
    }
    
}

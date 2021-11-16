//
//  AlbumViewController.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 20/09/21.
//

import Foundation
import UIKit
import Intents
import IntentsUI

protocol AlbumSceneDelegate: AnyObject {
    func setController(controller: AlbumViewController)
    func setUser(user: User?)
    func setupDatas()
    func reloadCollection()
}

class AlbumViewController: UICollectionViewController {
    
    private let siriButton = INUIAddVoiceShortcutButton(style: .automatic)
    private var scene: AlbumSceneDelegate?
    private var coreDataManager: CoreDataManagerProtocol?
    var tabCoordinator: TabCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.scene?.reloadCollection()
        tabCoordinator?.configTabBar(color: .white.withAlphaComponent(0.08))
    }
    
    func setAlbumScene(_ scene: AlbumSceneDelegate) {
        self.scene = scene
        self.scene?.setController(controller: self)
        self.view = scene as? UIView
    }
    
    func setCoreDataManager(_ aCoreData: CoreDataManagerProtocol) {
        self.coreDataManager = aCoreData
    }
    
    func fetchUser() {
        guard let coreDataManager = coreDataManager else { return }
        let user: [User] = coreDataManager.fetch()
        scene?.setUser(user: user.first)
    }
    
    func reload() {
        self.scene?.reloadCollection()
    }
}

extension AlbumViewController: INUIAddVoiceShortcutViewControllerDelegate {
    // 1
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    // 2
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension AlbumViewController: INUIEditVoiceShortcutViewControllerDelegate {
    
    // When the edit option is to update the shortcut
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    // When the edit option is to delete the shortcut
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // When modal Cancel button is tapped
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

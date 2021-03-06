import Foundation
import UIKit

struct FactoryControllers {
    static func createDiaryViewController() -> DiaryViewController {
        let diaryScene = DiaryScene()
        let diaryVC = DiaryViewController()
        diaryVC.setCoreDataManager(CoreDataManager())
        diaryVC.setDiaryScene(diaryScene)
        diaryScene.setupDatas()
        
        return diaryVC
    }
    
    static func createAlbumViewController() -> AlbumViewController {
        let albumScene = AlbumScene(frame: UIScreen.main.bounds)
        let albumVC = AlbumViewController()
        albumVC.setCoreDataManager(CoreDataManager())
        albumVC.setAlbumScene(albumScene)
        albumScene.setupDatas()
        
        return albumVC
    }
    
    static func createProfileViewController() {
        
    }
    
    static func createOnboardingViewController() -> OnboardingViewController {
        let onboardingVC = OnboardingViewController()
        onboardingVC.setCoreDataManager(CoreDataManager())
        return onboardingVC
    }
}

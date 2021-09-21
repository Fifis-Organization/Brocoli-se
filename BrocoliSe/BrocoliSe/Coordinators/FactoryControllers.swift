import Foundation

struct FactoryControllers {
    static func createDiaryViewController() -> ViewController {
        let diaryVC = ViewController()
        diaryVC.setCoreDataManager(CoreDataManager())
        diaryVC.setDiaryScene(DiaryScene())
        return diaryVC
    }
    
    static func createAlbumViewController() {
        
    }
    
    static func createProfileViewController() {
        
    }
    
    static func createOnboardingViewController() {
        
    }
}

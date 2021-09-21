import Foundation

struct FactoryControllers {
    static func createDiaryViewController() -> DiaryViewController {
        let diaryVC = DiaryViewController()
        diaryVC.setCoreDataManager(CoreDataManager())
        diaryVC.setDiaryScene(DiaryScene())
        return diaryVC
    }
    
    static func createAlbumViewController() -> AlbumViewController {
        return AlbumViewController()
    }
    
    static func createProfileViewController() {
        
    }
    
    static func createOnboardingViewController() -> OnboardingViewController {
        let onboardingVC = OnboardingViewController()
        onboardingVC.setCoreDataManager(CoreDataManager())
        return onboardingVC
    }
}

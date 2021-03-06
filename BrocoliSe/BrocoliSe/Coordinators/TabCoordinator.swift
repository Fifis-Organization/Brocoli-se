import Foundation
import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    func selectPage(_ page: TabBarPage)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
    func configTabBar(color: UIColor)
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? 
    var type: CoordinatorType { .tabBar }
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPage] = [.diary, .album]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.diary.pageOrderNumber()
        tabBarController.tabBar.tintColor = UIColor.greenMedium
    
        navigationController.viewControllers = [tabBarController]
    }
    
    func configTabBar(color: UIColor) {
        tabBarController.tabBar.backgroundColor = color
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = color
            
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = self.tabBarController.tabBar.standardAppearance
        }
    }
      
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageIcon(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .diary:
            let diaryVC = FactoryControllers.createDiaryViewController()
            diaryVC.tabCoordinator = self
            navController.navigationBar.isHidden = true
            navController.navigationBar.barStyle = .black
            navController.pushViewController(diaryVC, animated: false)
        case .album:
            let albumVC = FactoryControllers.createAlbumViewController()
            albumVC.tabCoordinator = self
            albumVC.title = "??lbum"
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.graviolaRegular(size: 34) ?? UIFont.systemFont(ofSize: 34)
            ]
            navController.navigationBar.barStyle = .black
            navController.navigationItem.largeTitleDisplayMode = .always
            navController.navigationBar.prefersLargeTitles = true
            navController.navigationBar.largeTitleTextAttributes = attrs
            navController.pushViewController(albumVC, animated: true)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
    }

}

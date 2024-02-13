import UIKit

final class TabBarController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        self.tabBar.layer.shadowColor = UIColor(red: 0.118, green: 0.11, blue: 0.11, alpha: 0.15).cgColor
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.shadowRadius = 11
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 23
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    private func setTabBarAppearance(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        setTabBarItemsColor(appearance.stackedLayoutAppearance)
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
    
    private func setTabBarItemsColor(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
         
        itemAppearance.selected.iconColor = .systemBlue
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    }
}

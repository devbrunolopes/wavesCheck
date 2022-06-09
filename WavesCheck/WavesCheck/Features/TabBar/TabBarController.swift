//
//  TabBarController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let item01 = CheckForecastViewController()
        let item02 = ChooseForecastViewController()
        let item03 = ReportsViewController()
        let item04 = ProfileViewController()
        
        setViewControllers([item01, item02, item03, item04], animated: false)
        tabBar.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        tabBar.barTintColor = .gray
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        
        guard let items = tabBar.items else {return}
        
        items[0].title = "Maps"
        items[0].image = UIImage(systemName: "globe.americas.fill")
        
        items[1].title = "Forecast"
        items[1].image = UIImage(systemName: "leaf.circle")
        
        items[2].title = "Reports"
        items[2].image = UIImage(systemName: "camera.fill")
        
        items[3].title = "Profile"
        items[3].image = UIImage(systemName: "person.fill")
    }
}

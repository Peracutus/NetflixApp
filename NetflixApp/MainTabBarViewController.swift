//
//  MainTabBarViewController.swift
//  NetflixApp
//
//  Created by Roman on 30.09.2022.
//

import UIKit

public final class MainTabBarViewController: UITabBarController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {

        let homeVC = createNavController(vc: HomeViewController(), itemTitle: "Home Page", itemImage: "house.fill")
        let upcomingVC = createNavController(vc: UpcomingViewController(), itemTitle: "Coming soon", itemImage: "play.square.fill")
        let downloadsVC = createNavController(vc: DownloadsViewController(), itemTitle: "Downloads", itemImage: "magnifyingglass.circle.fill")
        let searchVC = createNavController(vc: SearchViewController(), itemTitle: "Search", itemImage: "capslock.fill")
        
        setViewControllers([searchVC, upcomingVC, homeVC, downloadsVC], animated: true)
    }
    
    private func createNavController(vc: UIViewController, itemTitle: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemTitle, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        //navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        tabBar.tintColor = UIColor(named: "RedColor")
        return navController
    }
}

//
//  AppDelegate+WindowsViewController.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import Foundation
import UIKit
extension UITabBarController {
    var home:UINavigationController {
        let viewCon = UINavigationController(rootViewController: HomeViewController())
        let itemBar = UITabBarItem(title: "需求", image: UIImage(named: "icon_home_default"), selectedImage: UIImage(named: "icon_home_selected"))
        viewCon.tabBarItem = itemBar
        return viewCon
    }
}
extension AppDelegate {
    func configWindows(){
        let window = UIWindow()
        self.window = window
        window.makeKeyAndVisible()
        configNavi()
    }
    func configNavi(){
        let tab = UITabBarController()
        let home = tab.home
        tab.viewControllers = [home]
        self.window?.rootViewController = tab
    }
}
extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.viewColor
    }
}

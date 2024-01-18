//
//  TabBarViewController.swift
//  TZ1
//
//  Created by Даниил on 2024/01/18.
//

import UIKit

class TabBarViewController: UITabBarController {
    private let mainTile = "VKUSSOVET"
    private let fontName = "Impact"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTopBar()
        setupRightTopBar()
    }
    
    private func setupTopBar() {
        let button = UIButton(type: .system)
        button.setTitle(mainTile, for: .normal)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: 27)
        button.setTitleColor(.white, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2.5, right: 0)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    private func setupRightTopBar() {
        let systemImage = UIImage(systemName: "phone.circle")
        let button = UIButton(type: .system)
        button.setImage(systemImage, for: .normal)
        button.tintColor = .white
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .black
        tabBar.tintColor = .yellow
        tabBar.unselectedItemTintColor = .white
    }
}

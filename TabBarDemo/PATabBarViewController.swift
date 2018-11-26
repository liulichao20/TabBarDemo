//
//  PATabBarViewController.swift
//  TabBarDemo
//
//  Created by lichao_liu on 2018/11/23.
//  Copyright © 2018年 com.pa.com. All rights reserved.
//

import UIKit

class PATabBarViewController: UITabBarController{
    
    var customTabBar: PATabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar = PATabBar(frame: tabBar.frame)
        
        //选中item的文字 图片的颜色
        customTabBar.tintColor = UIColor.red
        
        //隐藏顶部黑线
        customTabBar.backgroundImage = UIImage()
        customTabBar.shadowImage = UIImage()
        //设置阴影
        customTabBar.layer.shadowColor = UIColor.lightGray.cgColor
        customTabBar.layer.shadowOpacity = 0.2
        customTabBar.layer.shadowOffset = CGSize.init(width: 0, height: -3)
        //tabBar背景色
        //        customTabBar.barTintColor = UIColor.black
        
        customTabBar.isTranslucent = false
        customTabBar.plusBtnBlock = {
            [weak self] in
            self?.rotateAnimation()
            self?.selectedIndex = 2
        }
        setValue(customTabBar, forKey: "tabBar")
        
        delegate = self
        configControllers()
    }
    
    func configControllers() {
        let nav1 = addController(normalImageName: "tab0", selectedImageName: nil, title: "我的")
        let nav2 = addController(normalImageName: "tab1", selectedImageName: nil, title: "发现")
        let nav3 = addController(normalImageName: nil, selectedImageName: nil, title: "展现")
        let nav4 = addController(normalImageName: "tab3", selectedImageName: nil, title: "抽奖")
        let nav5 = addController(normalImageName: "tab4", selectedImageName: nil, title: "切换")
        viewControllers = [nav1,nav2,nav3,nav4,nav5]
    }
    
    func addController(normalImageName: String?, selectedImageName: String?, title: String?)-> PANavigationController {
        let controller = ViewController()
        if let image = normalImageName {
            controller.tabBarItem.image = UIImage(named: image)
        }
        if let image = selectedImageName {
            controller.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        }
        controller.title = title
        return PANavigationController(rootViewController: controller)
    }
    
    func rotateAnimation() {
        customTabBar.tabBarImageAnimation(view: customTabBar.plusBtn)
    }
}

extension PATabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if selectedIndex == 2 {
            rotateAnimation()
        }else {
            customTabBar.plusBtn.layer.removeAllAnimations()
        }
    }
}

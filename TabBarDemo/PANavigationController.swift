//
//  PANavigationController.swift
//  TabBarDemo
//
//  Created by lichao_liu on 2018/11/23.
//  Copyright © 2018年 com.pa.com. All rights reserved.
//

import UIKit

class PANavigationController: UINavigationController,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //去掉navigationbar底部黑线
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        //改变navBar的背景颜色
//        navigationBar.barTintColor = UIColor.red
        print("did load")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //可以自定义返回按钮 不建议将 hidesBottomBarWhenPushed 放在这里
        if viewController.navigationItem.leftBarButtonItem == nil , viewControllers.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backAction))
        }
        
        super.pushViewController(viewController, animated: animated)
        
        //iphone x可能出现tabbar上移 处理方法 最新ios 12 未出现此问题
        if let frame = tabBarController?.tabBar.frame {
            tabBarController?.tabBar.frame.origin.y = UIScreen.main.bounds.height - frame.size.height
        }
    }
    
   @objc func backAction() {
        popViewController(animated: true)
    }
}

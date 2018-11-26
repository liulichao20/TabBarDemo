//
//  ViewController.swift
//  TabBarDemo
//
//  Created by lichao_liu on 2018/11/23.
//  Copyright © 2018年 com.pa.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        let btn = UIButton(type: .custom)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(whenBtnClicked), for: .touchUpInside)
        btn.frame = CGRect.init(x: 0, y: 0, width: 150, height: 80)
        btn.center = view.center
        btn.setTitle("clicked me", for: .normal)
        view.addSubview(btn)
    }
    
    @objc func whenBtnClicked() {
        let controller = SecondViewController()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}



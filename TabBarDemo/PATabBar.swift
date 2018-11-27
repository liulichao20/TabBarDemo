//
//  PATabBar.swift
//  TabBarDemo
//
//  Created by lichao_liu on 2018/11/23.
//  Copyright © 2018年 com.pa.com. All rights reserved.
//

import UIKit

typealias PABaseBlock = ()->Void
class PATabBar: UITabBar {

    var plusBtn:UIButton = UIButton(type: .custom)
    var plusBtnBlock:PABaseBlock?
    var isAddAction: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)        
        let image = UIImage(named: "post_default")!
        plusBtn.setImage(image, for: .normal)
        plusBtn.adjustsImageWhenHighlighted = false 
        plusBtn.frame = CGRect(x: (UIScreen.main.bounds.width-image.size.width)/2, y: -image.size.height/2, width: image.size.width, height: image.size.height)
        plusBtn.addTarget(self, action: #selector(whenBtnClicked), for: .touchUpInside)
        addSubview(plusBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func whenBtnClicked() {
        plusBtnBlock?()
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isHidden {
           let convertPoint = plusBtn.convert(point, from: self)
            if plusBtn.bounds.contains(convertPoint) {
                return plusBtn
            }
        }
       return super.hitTest(point, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isAddAction {
            return
        }else {
            isAddAction = true
        }
        for tabBarButton in subviews {
            if NSStringFromClass(tabBarButton.classForCoder) == "UITabBarButton",tabBarButton is UIControl {
                (tabBarButton as! UIControl).addTarget(self, action: #selector(whenBarButtonClicked(sender:)), for: .touchUpInside)
            }
        }
    }
    
    @objc func whenBarButtonClicked(sender:UIControl) {
        for imageView in sender.subviews {
            if NSStringFromClass(imageView.classForCoder) == "UITabBarSwappableImageView"{
                tabBarImageAnimation(view: imageView)
                break
            }
        }
    }
 
    func tabBarImageAnimation(view:UIView) {
        let scaleAnimation = CAKeyframeAnimation()
        scaleAnimation.keyPath = "transform.scale"
        scaleAnimation.duration = 0.5
        scaleAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        scaleAnimation.calculationMode = .cubic
        view.layer.add(scaleAnimation, forKey: nil)
    }
    
    func addBadge(atIndex index: Int,value:String?, badgeOffset: UIOffset = UIOffset(horizontal: 6.0, vertical: -22.0)) {
        guard let value = value else {
            if let badgeView = viewWithTag(1000 + index) as? PATabBarItemBadgeView {
                badgeView.removeFromSuperview()
            }
            return
        }
        
        if let badgeView = viewWithTag(1000 + index) as? PATabBarItemBadgeView {
            badgeView.badgeValue = value
            updateLayout(index: index,badgeView: badgeView,badgeOffset: badgeOffset)
        }else {
            let badgeView = PATabBarItemBadgeView()
            badgeView.isUserInteractionEnabled = false
            badgeView.badgeValue = value
            badgeView.tag = 1000 + index
            addSubview(badgeView)
            updateLayout(index: index, badgeView: badgeView, badgeOffset: badgeOffset)
        }
    }
    
    func updateLayout(index: Int, badgeView: UIView, badgeOffset: UIOffset) {
        let w = UIScreen.main.bounds.width/5
        let h = self.frame.size.height
        let itemSize = CGSize(width: w, height: h)
        let size = badgeView.sizeThatFits(itemSize)
        badgeView.frame = CGRect(origin: CGPoint(x:w*CGFloat(index) + w / 2.0 + badgeOffset.horizontal, y: h / 2.0 + badgeOffset.vertical), size: size)
        badgeView.setNeedsLayout()
    }
}

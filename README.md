# TabBarDemo
最近比较空闲，将之前做的tabBar功能做成小demo,功能具体为tabBarItem 点击动画，中间tabBarItem凸起

## 前沿
用过多个app后，会发现tabbar中间添加凸起按钮，点击按钮各种动画，页面跳转要么是push 或者present 或各种自定义动画。查看系统控件发现，直接用系统tabBar无法完成功能，所以通过继承tabBar，通过kvc 替换controller中的tabBar,通过响应链处理超出tabBar部分按钮点击事件。

![效果图.gif](![图一.png](https://github.com/liulichao20/TabBarDemo/blob/master/video.gif))

## 需求分析
* tabbar有5个item，每个对应一个页面
* 中间item为凸起按钮
* 按钮点击有动画

## 效果实现
* 自定义tabBar 
继承UITabBar 创建PATabBar，添加中间凸出按钮,定义一个block 响应按钮点击事件。按钮需设置adjustsImageWhenHighlighted = false 去掉系统按下效果，设置按钮居中显示
```
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

```
通过对tabBar子视图层次分析，item 对应于UITabBarButton，由于init方法时对应barButton获取为空，只能在layoutSubviews方法中获取barButton添加点击动画效果
注意：由于layoutSubViews会执行2遍，所以添加isAddAction用于标示。超出部分响应链处理请百度。

```
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
}

```

* KVC设置tabBar

```
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
```

* 其他
然后就是各种视图添加配置。

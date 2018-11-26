# TabBarDemo
最近比较空闲，将之前做的tabBar功能做成小demo,功能具体为tabBarItem 点击动画，中间tabBarItem凸起

##前沿
用过多个app后，会发现tabbar中间添加凸起按钮，点击按钮各种动画，页面跳转要么是push 或者present。查看系统控件发现，
直接用系统tabBar无法完成功能，所以通过继承tabBar，通过kvc 替换controller中的tabBar,通过响应链处理超出tabBar部分按钮点击事件。






---
#OpenEyesDemo
-------------
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
             )](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-ObjC-brightgreen.svg?style=flat)](https://developer.apple.com/Objective-C)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
> 关于**OpenEyesDemo**灵感来自于[开眼App](http://www.kaiyanapp.com)

###备注： 
* 此demo完全模仿[每日开眼](https://itunes.apple.com/app/apple-store/id978591579?pt=118114084&ct=Web-Landing-Modal-QR-Link&mt=8)App

* demo将完全开源

###预览：
* `载入模仿   `    

![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/Resources/开眼-载入MOV.gif)
* `下拉刷新模仿`    

![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/Resources/开眼-下拉刷新.gif)
* `转场动画模仿`    

![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/Resources/开眼-转场动画.gif)
* `转场动画模仿`    

![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/Resources/视频详情-更多.gif)
* `发现界面   `    

![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/Resources/开眼-发现.gif)
* `发现更多   `       

![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/Resources/开眼-发现详情.gif)

###说明：
* demo依赖的一些三方库：
`ZYBannerView`
                    
`YDSlider`
                     
`ZCAnimatedLabel`
                     
`FXBlurView`
                     
`AFNetworking`
                     
`YYKit`
                     
`MD360Player4iOS`
                     
`VIMVideoPlayer`
非常感谢这些优秀开源库，让某些功能实现的非常简单。

* 所有的自定义转场动画均在`HyInteractiveTransition`类中实现，具体参考源码。
* `NetworkRequestManage`类负责了所有的网络请求人物。
* `HyHelper`提供了一些非常方便的`宏`以及一些实用的方法。
* 项目采用`XIB`、`StoryBoard`构建界面。
* 本demo完善程度为5个界面+动画效果。分别为`精选`、`视频详情`、`视频播放(包括VR视频)` 、`发现`、`发现更多`

###注意：
* demo建议使用真机查看运行效果。模拟器有些不可描述的问题导致demo运行会异常，但是真机测试完全没有问题。
* demo机型适配`iPhone 5`可能效果不是最佳，（因为我没有iPhone5 滑稽）
* 先到这里~

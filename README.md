---
#OpenEyesDemo
-------------
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
             )](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-ObjC-brightgreen.svg?style=flat)](https://developer.apple.com/Objective-C)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
> 关于**OpenEyesDemo**灵感来自于[开眼App](http://www.kaiyanapp.com)

###说明： 
* 此demo完全模仿[每日开眼](https://itunes.apple.com/app/apple-store/id978591579?pt=118114084&ct=Web-Landing-Modal-QR-Link&mt=8)App

###预览：
* `载入模仿 `      ![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/开眼-载入MOV.gif)
* `下拉刷新模仿`    ![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/开眼-下拉刷新.gif)
* `转场动画模仿`    ![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/开眼-转场动画.gif)
* `转场动画模仿`    ![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/视频详情-更多.gif)
* `发现界面`       ![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/开眼-发现.gif)
* `发现更多`       ![image](https://github.com/wwdc14/OpenEyesDemo/blob/master/开眼-发现详情.gif)

###说明：
* demo依赖的一些三方库：`ZYBannerView`  
                     `YDSlider` 
                     `ZCAnimatedLabel` 
                     `FXBlurView` 
                     `AFNetworking` 
                     `YYKit` 
                     `MD360Player4iOS`
                     `VIMVideoPlayer` 非常感谢这些优秀开源的第三方库，让某些功能实现的非常简单。
* 本demo支持VR视频播放，类似开眼360°视频。 视频播放功能完善。
* 项目采用MVC设计模式。每个`Controller`都有`model``Views``Controller`三个文件夹，由于开眼官方API返回的数据格式大多大同小异，所以主要数据模型都放在`HoemController`里。

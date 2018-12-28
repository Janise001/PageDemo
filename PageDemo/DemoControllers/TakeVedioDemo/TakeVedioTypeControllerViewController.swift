//
//  TakeVedioTypeControllerViewController.swift
//  PageDemo
//  视频获取类型选择
//  Created by 吴丽娟 on 2018/12/24.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit
import MobileCoreServices
import ReplayKit
class TakeVedioTypeControllerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RPPreviewViewControllerDelegate {

    /// 本地获取视频
    lazy var systemAlbumVideoBtn: UIButton = {
        let button = UIButton()
        button.setTitle("系统视频获取", for: .normal)
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.tinColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        return button
    }()
    /// app拍摄视频
    lazy var takeAppVideoBtn: UIButton = {
        let button = UIButton()
        button.setTitle("app视频拍摄", for: .normal)
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.tinColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        return button
    }()
    /// app录屏
    lazy var takeScreenVideoBtn: UIButton = {
        let button = UIButton()
        button.setTitle("app录屏", for: .normal)
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.tinColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        return button
    }()
    /// 计时器
    var time: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.view.addSubview(self.systemAlbumVideoBtn)
        self.view.addSubview(self.takeAppVideoBtn)
        self.view.addSubview(self.takeScreenVideoBtn)
        self.systemAlbumVideoBtn.addTarget(self, action: #selector(getSystemVideo), for: .touchUpInside)
        self.takeAppVideoBtn.addTarget(self, action: #selector(takeAppVideo), for: .touchUpInside)
        self.takeScreenVideoBtn.addTarget(self, action: #selector(takeScreenVideo), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.systemAlbumVideoBtn.frame = CGRect(x: 20, y: 100, width: self.view.bounds.width-40, height: 0)
        self.systemAlbumVideoBtn.sizeToFit()
        self.takeAppVideoBtn.frame = CGRect(x: 20, y: 180, width: self.view.bounds.width-40, height: 0)
        self.takeAppVideoBtn.sizeToFit()
        self.takeScreenVideoBtn.frame = CGRect(x: 20, y: 260, width: self.view.bounds.width-40, height: 0)
        self.takeScreenVideoBtn.sizeToFit()
        
    }
    /// 展示录屏工具栏视图
    @objc func takeScreenVideo() {
        if !self.takeScreenVideoBtn.isSelected {
            let replayVideoView = ReplayVideoToolView(frame: CGRect(x: 20, y: self.view.bounds.height-100, width: self.view.bounds.width-40, height: 50))
            //使用block代替在view中编写关闭方法，添加对“app录屏”按钮的选中状态设置
            replayVideoView.closeBlock = { () in
                replayVideoView.removeFromSuperview()
                self.takeScreenVideoBtn.isSelected = !self.takeScreenVideoBtn.isSelected
            }
            replayVideoView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragFunction)))
            replayVideoView.actionBlock = {
                self.startRecordingScreen(replayVideoView)
                replayVideoView.closeButton.isHidden = replayVideoView.actionButton.isSelected
            }
            let window = UIApplication.shared.keyWindow
            window!.addSubview(replayVideoView)
            self.takeScreenVideoBtn.isSelected = !self.takeScreenVideoBtn.isSelected
        }
    }
    // Janise: 设置拖动手势（可用于拖动控件后设置控件依赖位置，此处只设置可在y轴方向上移动）
    @objc func dragFunction(_ pan: UIPanGestureRecognizer) {
        let point = pan.translation(in: view)
        if let v = pan.view {
            //设置移至顶部和底部时不可移动
            if (v.frame.origin.y > 64 && point.y < 0)
                || (v.frame.origin.y + v.frame.height < (UIApplication.shared.keyWindow?.frame.height)! && point.y > 0) {
                v.center.y = v.center.y + point.y
            }
            pan.setTranslation(.zero, in: view)
        }
    }
    /// 获取系统相册视频
    @objc func getSystemVideo() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [ kUTTypeMovie as String]
            self.present(imagePicker, animated: true, completion: nil)
        }else {
            print("相册访问失败")
        }
    }
    /// app拍摄视频
    @objc func takeAppVideo() {
        let viewCon = TakeAppVideoController()
        self.navigationController?.pushViewController(viewCon, animated: true)
    }
}
extension TakeVedioTypeControllerViewController {
    // Janise:  开始录制屏幕
    @objc func startRecordingScreen(_ toolView: ReplayVideoToolView) {
        // 检测设备是否支持录屏功能
        if RPScreenRecorder.shared().isAvailable && systemVersionAvaliable()  {
            //录屏按钮是否选中
            if toolView.actionButton.isSelected {
                //停止计时
                self.time?.invalidate()
                self.time = nil
                toolView.seconds = 0
                //选中状态下停止录制
                RPScreenRecorder.shared().stopRecording { (previewCon, error) in
                    if let errors = error {
                        print(errors)
                    }
                    if let controller = previewCon {
                        controller.previewControllerDelegate = self
                        UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
                    }
                }
                toolView.actionButton.isSelected = false
                toolView.removeFromSuperview()
                self.takeScreenVideoBtn.isSelected = !self.takeScreenVideoBtn.isSelected
                return
            }else {
                //开始计时
                self.time = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                    toolView.seconds += 1
                })
                //未选中状态下开始录屏
                RPScreenRecorder.shared().startRecording { (err) in
                    if let error = err {
                        print(error)
                    }
                }
                toolView.actionButton.isSelected = true
            }
        }else {
            //正式编写时需将两种提示分开展示，权限与版本两个不可t合二为一
            let alert = UIAlertController(title: "提示", message: "请先授予app录屏权限，系统版本低于9.0不支持录屏功能，请升级版本后使用该功能", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        //关闭视频预览
        previewController.dismiss(animated: true, completion: nil)
    }
    /// 判断系统版本是否可以使用录屏功能,系统版本需要再9.0以上才可使用录屏功能
    func systemVersionAvaliable() -> Bool {
        let version = UIDevice.current.systemVersion
        if (Double(version) ?? 0.0) >= Double(9.0) {
            return true
        }
        return false
    }
    
}

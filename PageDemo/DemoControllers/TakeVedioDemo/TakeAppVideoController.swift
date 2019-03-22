//
//  TakeAppVideoController.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/12/25.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Photos

class TakeAppVideoController: UIViewController,AVCaptureFileOutputRecordingDelegate {
    
    /// 视频捕捉会话
    var videoSession = AVCaptureSession()
    /// 拍摄展示框
    var actionViewLayer: AVCaptureVideoPreviewLayer?
    /// 视频录入（摄像头）
    var camera: AVCaptureDevice?
    /// 音频录入（麦克风）
    var audio = AVCaptureDevice.default(for: .audio)
    /// 顶部工具栏
    var topView: VideoTopToolView = VideoTopToolView()
    /// 操作栏
    var bottomView: VideoBottomToolView?
    /// 拍摄动作参数（默认为未操作）
    var actionParam: ShootType = ShootType.noShoot
    /// 拍摄视频输出
    var fileOut = AVCaptureMovieFileOutput()
    /// 计时工具
    var timer: Timer?
    /// 保存路径
    var fileOutPath: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        //设置初始绘画
        self.setSession()
        // 添加顶部工具栏
        self.view.addSubview(self.topView)
        // 添加底部工具栏
        let bottomViewFrame = CGRect(x: 0, y: self.view.bounds.height-100, width: self.view.bounds.width, height: 100)
        self.bottomView = VideoBottomToolView(frame: bottomViewFrame)
        self.view.addSubview(self.bottomView ?? UIView())
        self.bottomView?.shootStackView.isHidden = false
        self.bottomView?.operateStackView.isHidden = true
        //设置上下工具栏中的事件
        self.setAction()
    }
    /// 初始化设置会话
    func setSession() {
        //设置初始摄像头
        camera = chooseDeviceSize(position: AVCaptureDevice.Position.back)
        //设置清晰度调节
        self.videoSession.sessionPreset = AVCaptureSession.Preset.vga640x480
        //视频录入
        if let videoInput = try? AVCaptureDeviceInput(device: camera!) {
            self.videoSession.addInput(videoInput)
        }
        //音频录入
        if self.audio != nil,let audioInput = try? AVCaptureDeviceInput(device: audio!) {
            self.videoSession.addInput(audioInput)
        }
        //设置输出
        self.videoSession.addOutput(fileOut)
        //设置展示框
        self.setLayer()
        self.videoSession.startRunning()
    }
    /// 初始化展示框
    func setLayer() {
        let vedioLayer = AVCaptureVideoPreviewLayer(session: self.videoSession)
        vedioLayer.frame = self.view.bounds
        vedioLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(vedioLayer)
        actionViewLayer = vedioLayer
    }
    
    /// 设置
    func setAction() {
        //顶部工具栏
        //镜头切换功能
        self.topView.changeSideButton.addTarget(self, action: #selector(changDevoiceSide), for: .touchUpInside)
        //闪光灯开关功能
        self.topView.flashButton.addTarget(self, action: #selector(changeFlash), for: .touchUpInside)
        //底部工具栏
        //拍摄按钮
        self.bottomView?.actionButton.addTarget(self, action: #selector(videoOperation), for: .touchUpInside)
        //取消按钮（当前拍摄状态为停止状态时设置为未操作状态，隐藏cancelButton和sureButton视图）
        self.bottomView?.cancelButton.addTarget(self, action: #selector(cancelFun), for: .touchUpInside)
        //确认按钮（设置当前拍摄状态为未操作状态）
        self.bottomView?.sureButton.addTarget(self, action: #selector(sureFun), for: .touchUpInside)
    }
    //切换摄像头
    @objc func changDevoiceSide() {
        //设置按钮选中状态，停止摄影会话
        self.topView.changeSideButton.isSelected = !self.topView.changeSideButton.isSelected
        self.videoSession.stopRunning()
        //移除视频和麦克风输入
        for input in self.videoSession.inputs {
            self.videoSession.removeInput(input)
        }
        //执行切换摄像头动画
        self.changeDeviceSideTransition()
        //重新将视频和麦克风输入
        if self.audio != nil ,let audioInput = try? AVCaptureDeviceInput(device: audio!) {
            self.videoSession.addInput(audioInput)
        }
        if self.topView.changeSideButton.isSelected {
            self.camera = chooseDeviceSize(position: .front)
            //设置前置摄像头时必须将闪光灯关闭
            self.topView.flashButton.isSelected = false
        }else {
            self.camera = chooseDeviceSize(position: .back)
        }
        if let camera = try? AVCaptureDeviceInput(device: camera!) {
            self.videoSession.addInput(camera)
        }
    }
    /// 设置摄像头翻转时的动画
    func changeDeviceSideTransition() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.delegate = self
        transition.type = "oglFlip" //非公开动画可直接写成字符串格式
        transition.subtype = kCATransitionFromRight
        self.actionViewLayer?.add(transition, forKey: "changeAnimate")
    }
    /// 变换闪光灯
    @objc func changeFlash() {
        //如摄像头当前为前摄像头，return
        if self.camera?.position == AVCaptureDevice.Position.front {
            return
        }
        //后摄像头模式
        let torchMode = self.camera?.torchMode
        if torchMode == AVCaptureDevice.TorchMode.on {
            //关闭失败情况
            do {
                try self.camera?.lockForConfiguration()     //闪光灯使用必须获得设备独占所有权
            }catch{
                print("关闭闪光灯失败")
            }
            self.camera?.torchMode = AVCaptureDevice.TorchMode.off
            self.camera?.flashMode = AVCaptureDevice.FlashMode.off
        }else {
            do {
                try? self.camera?.lockForConfiguration()
            }catch {
                print("开启闪光灯失败")
            }
            self.camera?.torchMode = AVCaptureDevice.TorchMode.on
            self.camera?.flashMode = AVCaptureDevice.FlashMode.on
        }
        self.camera?.unlockForConfiguration()
        self.topView.flashButton.isSelected = !self.topView.flashButton.isSelected
        
    }
    /// 选择摄像头
    ///
    /// - Parameter position: 摄像头位置（前/后）
    /// - Returns: 摄像设备（摄像头）
    func chooseDeviceSize(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let sides = AVCaptureDevice.devices(for: AVMediaType.video)
        for side in sides {
            if side.position == position {
                return side
            }
        }
        return nil
    }
    @objc func videoOperation() {
        //判断当前拍摄状态
        let type = self.actionParam
        //未拍摄状态->变更为拍摄状态（隐藏cancelButton和sureButton视图），开始计时，视频编码输出，变更拍摄按钮点击状态
        if type == .noShoot {
            //顶部工具栏设置摄像头变化按钮、闪光灯开关按钮隐藏
            self.topView.changeSideButton.isHidden = true
            self.topView.flashButton.isHidden = true
            //底部工具栏设置保存、取消按钮隐藏
            self.bottomView?.operateStackView.isHidden = true
            self.bottomView?.shootStackView.isHidden = false
            self.startVideo()
        }else if type == .shoot {
            //拍摄中状态->变更为停止状态（显示cancelButton和sureButton视图），计时器停止计时，编码输出停止，变更拍摄按钮点击状态
            //底部工具栏设置保存、取消按钮隐藏
            self.bottomView?.operateStackView.isHidden = false
            self.bottomView?.shootStackView.isHidden = true
            self.stopVideo()
        }
    }
    /// 拍摄视频
    func startVideo(){
        //开始计时，修改显示时间，开启会话，设置保存位置，开启视频编码输出
        self.topView.seconds = 0
        self.bottomView?.actionButton.isSelected = true
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeTime), userInfo: nil, repeats: true)
        self.actionParam = .shoot
        self.videoSession.startRunning()
        //设置保存路径
        let manager = FileManager.default
        let path = manager.urls(for: .documentDirectory, in: .userDomainMask)
        var documentDirectory = path[0].absoluteString
        let index = documentDirectory.index(documentDirectory.startIndex, offsetBy: 7)
        documentDirectory = documentDirectory.substring(from: index)
        let filePath = "\(documentDirectory)\(Date()).mp4"
        let fileUrl = URL(fileURLWithPath: filePath)
        self.fileOut.startRecording(to: fileUrl, recordingDelegate: self)
    }
    /// 停止拍摄视频
    func stopVideo() {
        self.actionParam = .stopShoot
        self.bottomView?.actionButton.isSelected = false
        self.topView.flashButton.isSelected = false
        self.timer?.invalidate()
        self.timer = nil
        self.videoSession.stopRunning()
        self.fileOut.stopRecording()
    }
    /// 取消按钮方法
    @objc func cancelFun() {
        self.actionParam = .noShoot
        self.topView.seconds = 0
        self.videoSession.startRunning()
        self.topView.isHidden = false
        //删除拍摄的视频
        guard let filePath = fileOutPath else { return }
        deleteFileFromPath(filePath)
        //顶部工具栏设置摄像头变化按钮、闪光灯开关按钮隐藏
        self.topView.changeSideButton.isHidden = false
        self.topView.flashButton.isHidden = false
        //底部工具栏设置保存、取消按钮隐藏
        self.bottomView?.operateStackView.isHidden = true
        self.bottomView?.shootStackView.isHidden = false
    }
    /// 确认按钮方法
    @objc func sureFun() {
        guard let url = self.fileOutPath else { return }
        //使用AVPlayerViewController播放视频
        playTheVideo(url,controller: self)
//        saveVideoToAlbum(url)
        //使用ZFPlayer播放视频
        
        
    }
    /// 视图中时间变化
    @objc func changeTime() {
        self.topView.seconds += 1
    }
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        self.fileOutPath = outputFileURL
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.topView.frame = CGRect(x: self.view.bounds.width/2-90, y: 100, width: 200, height: 50)
        
    }
}
extension TakeAppVideoController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        self.videoSession.startRunning()
    }
    
    /// 拍摄状态类型
    ///
    /// - noShoot: 未拍摄
    /// - shoot: 拍摄中
    /// - stopShoot: 拍摄停止
    enum ShootType {
        case noShoot
        case shoot
        case stopShoot
    }
}

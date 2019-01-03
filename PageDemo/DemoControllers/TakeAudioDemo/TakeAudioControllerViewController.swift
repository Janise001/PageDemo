//
//  TakeAudioViewController.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2019/1/2.
//  Copyright © 2019年 Janise·Wu. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
class TakeAudioViewController: UIViewController {
    /// 底部视频录制按钮视图
    var audioView: AudioView?
    
    /// 话筒视图
    var pressView: LongPressView?
    
    /// 撤销视图
    var cancelView: RemoveAwayView?
    
    /// 信息列表
    var messageList: MessageTableViewController = MessageTableViewController()
    /// 音频会话
    var session = AVAudioSession.sharedInstance()
    /// 音频信息输出
    var fileOutput: AVAudioRecorder?
    /// 录音状态
    var status: CurrentStatus = .end
    /// 保存路径
    var url:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        //设置底部录音视图及响应事件
        self.audioView = AudioView(frame: CGRect(x: 0, y: self.view.bounds.height-50, width: self.view.bounds.width, height: 50))
        self.view.addSubview(self.audioView!)
        self.setAudioFunction()
        //刷新table
        self.view.addSubview(self.messageList)
        // 设置会话
        self.setupSession()
        // 查找音频文件
        self.reloadTableView()
    }
    /// 设置会话
    func setupSession() {
        do {
            try self.session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }catch {
            print("类型设置失败\(error.localizedDescription)")
        }
        do {
            try self.session.setActive(true)
        }catch {
            print("初始化失败\(error.localizedDescription)")
        }
    }
    /// 开始录音
    func start() {
        //设置保存路径
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/\(Date()).wma")
        let fileUrl = URL(fileURLWithPath: filePath ?? "")
        self.url = fileUrl
        //设置
        let recordSetting: [String: Any] = [AVSampleRateKey: NSNumber(value: 16000),//采样率
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),//音频格式
            AVLinearPCMBitDepthKey: NSNumber(value: 16),//采样位数
            AVNumberOfChannelsKey: NSNumber(value: 1),//通道数
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)//录音质量
        ]
        do {
            self.fileOutput = try AVAudioRecorder(url: fileUrl, settings: recordSetting)
            self.fileOutput!.prepareToRecord()
            self.fileOutput!.record()
        }catch {
            print("开启失败\(error.localizedDescription)")
        }
    }
    /// 停止录音
    func stop() {
        if let recorder = self.fileOutput {
            //如有需求必要此处加上录音状态判断,无论在不在录音状态都停止录音
            //            if recorder.isRecording {
            //
            //            }else {
            //
            //            }
            self.fileOutput!.stop()
            //此处重置,文件名称为日期显示，每次新建文件需要更新
            self.fileOutput = nil
        }
        
    }
    /// 设置录音事件
    func setAudioFunction() {
        // 长按按钮
        self.audioView!.audioBtn.addTarget(self, action: #selector(audioTouchDown), for: .touchDown)
        // 按钮区域以外弹起事件
        self.audioView!.audioBtn.addTarget(self, action: #selector(audioTouchUpOutside), for: .touchUpOutside)
        // 滑动至按钮以外区域发生事件
        self.audioView!.audioBtn.addTarget(self, action: #selector(audioTouchDragExit), for: .touchDragExit)
        // 按钮区域以内弹起事件
        self.audioView!.audioBtn.addTarget(self, action: #selector(audioTouchUpInside), for: .touchUpInside)
        // 从区域以外滑动至区域以内事件
        self.audioView!.audioBtn.addTarget(self, action: #selector(audioTouchDragEnter), for: .touchDragEnter)
    }
    /// 长时间按下按钮->展示录音view
    @objc func audioTouchDown() {
        pressView = LongPressView(frame: CGRect(x: self.view.bounds.width/2-90, y: self.view.bounds.height/2-115, width: 180, height: 230))
        self.view.addSubview(pressView!)
        self.start()
    }
    /// 按钮区域外按下弹起事件->隐藏撤销视图
    @objc func audioTouchUpOutside() {
        self.cancelView?.isHidden = true
        // 停止录音并删除当前音频文档
        self.stop()
        deleteFileFromPath(url ?? URL(fileURLWithPath: ""))
        self.reloadTableView()
    }
    /// 从按钮区域内部滑动至区域外部->隐藏录音view，展示撤销view
    @objc func audioTouchDragExit() {
        //移除话筒视图后添加撤销视图
        self.pressView?.isHidden = true
        cancelView = RemoveAwayView(frame: CGRect(x: self.view.bounds.width/2-90, y: self.view.bounds.height/2-115, width: 180, height: 230))
        self.view.addSubview(cancelView!)
    }
    /// 从按钮内部区域弹起->隐藏录音view
    @objc func audioTouchUpInside() {
        self.pressView?.isHidden = true
        self.stop()
        self.reloadTableView()
    }
    /// 从按钮区域以外滑动至区域内部->隐藏撤销view，展示录音view
    @objc func audioTouchDragEnter() {
        self.cancelView?.isHidden = true
        self.pressView?.isHidden = false
    }
    /// 获取app录音文件，刷新录音文件展示列表
    func reloadTableView() {
        let manager = FileManager.default
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        do {
            let fileNames = try manager.contentsOfDirectory(atPath: documentDirectory ?? "")
            var models: [AudioModel] = []
            fileNames.forEach { (name) in
                let model: AudioModel = AudioModel()
                let path = "\(documentDirectory!)/\(name)"
                model.fileName = name
                model.filePath = path
                models.append(model)
            }
            self.messageList.modelData = models
        }catch {
            print("\(error.localizedDescription)")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.messageList.frame = CGRect(x: 0, y: 80, width: self.view.bounds.width, height: self.view.bounds.height-64-60)
    }
}

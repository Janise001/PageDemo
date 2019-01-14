//
//  MessageTableViewController.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2019/1/2.
//  Copyright © 2019年 Janise·Wu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVKit
import AVFoundation

class MessageTableViewController: UITableView,UITableViewDelegate,UITableViewDataSource {
    /// 获取播放UIImageView
    var playBlock: (()->())?
    var player:AVAudioPlayer?
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = Color.tinColor
        self.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageTableViewCell")
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
    }
    var modelData:[AudioModel] = [] {
        didSet {
            self.reloadData()
        }
    }
    /// 获取到播放动画
    var playImageView: UIImageView? {
        didSet {
            //播放动画
            self.playAnimation()
        }
    }
    /// 播放动画
    func playAnimation() {
        self.playImageView?.animationImages = [UIImage(named: "audio_play_1"),
                                               UIImage(named: "audio_play_2"),
                                               UIImage(named: "audio_play_3")] as? [UIImage]
        self.playImageView?.animationDuration = 1
        self.playImageView?.startAnimating()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        // 语音按钮
        let playButton: UIButton = cell.viewWithTag(200) as! UIButton
        playButton.setTitle(String(indexPath.row), for: .normal)
        
        playButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        cell.returnPlayImgeBlock = { (imageView) in
            self.playImageView = imageView
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    /// 播放
    @objc func playAudio(_ sender: UIButton) {
        let index = sender.titleLabel?.text ?? "0"
        let path = self.modelData[Int(index) ?? 0].filePath
        do {
            let url = URL(fileURLWithPath: path ?? "")
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player!.play()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MessageTableViewController: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("录音播放完成")
        self.playImageView?.stopAnimating()
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print(error?.localizedDescription)
    }
    
}

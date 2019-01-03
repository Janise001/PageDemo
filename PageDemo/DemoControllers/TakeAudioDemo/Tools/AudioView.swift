//
//  AudioView.swift
//  PageDemo
//  点击录制音频文件
//  Created by 吴丽娟 on 2019/1/2.
//  Copyright © 2019年 Janise·Wu. All rights reserved.
//

import UIKit

class AudioView: UIView {
    /// 录音按钮
    lazy var audioBtn: UIButton = {
        let button = UIButton()
        button.setTitle("按住 说话", for: .normal)
        button.setTitleColor(Color.gray, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = Color.gray.cgColor
        button.layer.borderWidth = 0.3
        button.backgroundColor = Color.viewBackgroundColor
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.viewBackgroundColor
        self.layer.shadowColor = Color.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowOpacity = 0.5
        self.audioBtn.frame = CGRect(x: 20, y: 10, width: self.bounds.width-40, height: 30)
        self.addSubview(audioBtn)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

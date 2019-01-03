//
//  RemoveAwayView.swift
//  PageDemo
//  从录音按钮移开展示视图（模仿微信语音录制）
//  Created by 吴丽娟 on 2019/1/2.
//  Copyright © 2019年 Janise·Wu. All rights reserved.
//

import UIKit

class RemoveAwayView: UIView {
    /// 图片展示
    lazy var microphoneImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "audio_cancel_icon")
        return image
    }()
    /// 提示语句
    let tipTitle: UILabel = {
        let label = UILabel()
        label.text = "松开手指，取消发送"
        label.textColor = Color.white
        label.backgroundColor = Color.red
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.black
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.alpha = 0.3
        self.configLayout()
    }
    /// 视图布局
    func configLayout() {
        let stackView: UIStackView = {
            let view = UIStackView()
            view.addArrangedSubview(self.microphoneImg)
            view.addArrangedSubview(self.tipTitle)
            view.spacing = 10
            view.axis = .vertical
            return view
        }()
        self.addSubview(stackView)
        stackView.frame = CGRect(x: 20, y: 20, width: frame.width-40, height: frame.height-40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

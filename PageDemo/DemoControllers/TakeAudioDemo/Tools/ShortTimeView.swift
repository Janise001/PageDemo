//
//  ShortTimeView.swift
//  PageDemo
//  对按钮的按压少于2秒钟时展示该视图
//  Created by 吴丽娟 on 2019/1/8.
//  Copyright © 2019年 Janise·Wu. All rights reserved.
//

import UIKit

class ShortTimeView: UIView {

    /// 提醒图片
    let warningImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "audio_warning_icon")
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        return imageView
    }()
    /// 提醒语句
    let warningLabel: UILabel = {
       let label = UILabel()
        label.text = "录音时间太短"
        label.textColor = Color.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = Color.clear
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.black
        self.alpha = 0.3
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.configLayout(frame)
    }
    func configLayout(_ frame: CGRect) {
        let contentStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.addArrangedSubview(self.warningImageView)
            view.addArrangedSubview(self.warningLabel)
            return view
        }()
        self.addSubview(contentStackView)
        contentStackView.frame = CGRect(x: 20, y: 20, width: frame.width-40, height: frame.height-40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

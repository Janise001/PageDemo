//
//  VideoTopToolView.swift
//  PageDemo
//  闪光灯、计时器显示、摄像头翻转 视图
//  Created by 吴丽娟 on 2018/12/25.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class VideoTopToolView: UIView {
    //摄像头变换按钮
    var changeSideButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "change_side_back_icon"), for: .normal)
        button.setBackgroundImage(UIImage(named: "change_side_front_icon"), for: .selected)
        return button
    }()
    //时长显示文本
    var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = Color.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    //闪光灯开启关闭按钮
    var flashButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "change_flash_close_icon"), for: .normal)
        button.setBackgroundImage(UIImage(named: "change_flash_open_icon"), for: .selected)
        return button
    }()
    /// 计时秒数
    var seconds: Int = 0 {
        didSet {
            self.timeLabel.text = timeString(seconds)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0.5
        self.backgroundColor = Color.black
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        let stackView: UIStackView = {
            let view = UIStackView()
            view.addArrangedSubview(self.changeSideButton)
            view.addArrangedSubview(self.timeLabel)
            view.addArrangedSubview(flashButton)
            view.axis = .horizontal
            view.spacing = 10
            view.alignment = .center
            view.distribution = .equalCentering
            return view
        }()
        self.addSubview(stackView)
        stackView.frame = CGRect(x: 10, y: 0, width: 180, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

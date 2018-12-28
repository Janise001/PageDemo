//
//  VideoBottomToolView.swift
//  PageDemo
//  拍摄按钮、取消保存按钮 视图
//  Created by 吴丽娟 on 2018/12/25.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class VideoBottomToolView: UIView {
    /// 取消保存拍摄内容按钮
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "video_cancel_icon"), for: .normal)
        return button
    }()
    /// 拍摄状态按钮
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "video_stop_icon"), for: .normal)
        button.setBackgroundImage(UIImage(named: "video_start_icon"), for: .selected)
        return button
    }()
    /// 保存拍摄内容按钮
    lazy var sureButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "video_sure_icon"), for: .normal)
        return button
    }()
    var operateStackView: UIStackView = UIStackView()
    var shootStackView: UIStackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0.5
        self.backgroundColor = Color.black
        operateStackView = {
            let view = UIStackView()
            view.addArrangedSubview(cancelButton)
            view.addArrangedSubview(sureButton)
            view.axis = .horizontal
            view.alignment = .center
            view.distribution = .equalCentering
            view.spacing = 100
            return view
        }()
        shootStackView = {
            let view = UIStackView()
            view.addArrangedSubview(actionButton)
            view.axis = .horizontal
            view.alignment = .center
            view.distribution = .equalCentering
            view.spacing = 100
            return view
        }()
        let allStackView: UIStackView = {
            let view = UIStackView()
            view.addArrangedSubview(operateStackView)
            view.addArrangedSubview(shootStackView)
            view.axis = .vertical
            view.alignment = .center
            view.distribution = .fillProportionally
            return view
        }()
        allStackView.frame = CGRect(x: 20, y: 0, width: frame.width-40, height: frame.height)
        self.addSubview(allStackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

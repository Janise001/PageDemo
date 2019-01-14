//
//  MessageTableViewCell.swift
//  
//
//  Created by 吴丽娟 on 2019/1/2.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    var returnPlayImgeBlock: ((UIImageView)->())?
    /// 头像
    let headPortrait: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "head_portrait")
        imageView.tag = 100
        return imageView
    }()
    /// 播放按钮
    var playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "audio_dialog")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 6, 0, 9), resizingMode: .stretch)
        button.setBackgroundImage(image, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 0)
        button.tag = 200
        return button
    }()
    /// 播放图片
    var playImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "audio_stop")
        imageView.tag = 300
        return imageView
    }()

    /// 时间显示
    var timeShowLabel: UILabel = {
        let label = UILabel()
//        label.text
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Color.clear
        self.configLayout()
        self.playButton.addTarget(self, action: #selector(playAnimation), for: .touchUpInside)
    }
    
    func configLayout() {
        self.headPortrait.frame = CGRect(x: self.bounds.width-70, y: 10, width: 50, height: 50)
        self.addSubview(headPortrait)
        self.playButton.frame = CGRect(x: self.bounds.width-280, y: 10, width: 200, height: 50)
        self.addSubview(self.playButton)
        self.playImageView.frame = CGRect(x: 160, y: 10, width: 30, height: 30)
        self.playButton.addSubview(self.playImageView)
    }
    @objc func playAnimation() {
        self.returnPlayImgeBlock?(self.playImageView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

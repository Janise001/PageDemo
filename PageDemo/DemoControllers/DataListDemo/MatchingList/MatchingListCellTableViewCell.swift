//
//  MatchingListCellTableViewCell.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/12/18.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class MatchingListCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configLayout()
    }
    let phoneStrLabel:UILabel = UILabel()
    func configLayout() {
        self.phoneStrLabel.frame = CGRect(x: 20, y: 10, width: self.bounds.width-20, height: 30)
        self.phoneStrLabel.tag = 100
        self.addSubview(self.phoneStrLabel)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Color.gray.cgColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

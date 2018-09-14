//
//  ContentView.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class ContentView: UIView {

   
    let button:UIButton = {
       let button = UIButton()
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.tinColor
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 5.0
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.button)
        self.button.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ContentView.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class ContentView: UIView {

    var titleStr:String = ""
    let button:UIButton = {
       let button = UIButton()
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.blue
        button.layer.cornerRadius = 5.0
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.button.setTitle(self.titleStr, for: .normal)
        self.addSubview(self.button)
        self.button.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

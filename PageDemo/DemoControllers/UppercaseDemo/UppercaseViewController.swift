//
//  UppercaseViewController.swift
//  PageDemo
//  价格自动转换大写demo
//  Created by 吴丽娟 on 2018/12/17.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class UppercaseViewController: UIViewController {

    // 价格textField
    let priceInput: UITextField = UITextField()
    // 大写label
    var uppercaseLabel: UILabel = UILabel()
    // 转换按钮
    var transferButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uppercaseLabel.numberOfLines = 0
        self.priceInput.placeholder = "请输入价格"
        self.priceInput.layer.borderWidth = 0.5
        self.priceInput.layer.borderColor = Color.gray.cgColor
        self.priceInput.keyboardType = .decimalPad
        self.uppercaseLabel.text = "大写："
        self.view.addSubview(self.priceInput)
        self.view.addSubview(self.uppercaseLabel)
        self.transferButton.setTitle("大写转换", for: .normal)
        self.transferButton.setTitleColor(Color.white, for: .normal)
        self.transferButton.backgroundColor = Color.tinColor
        self.view.addSubview(self.transferButton)
        self.transferButton.addTarget(self, action: #selector(transferShowing), for: .touchUpInside)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.priceInput.frame = CGRect(x: 20, y: 150, width: self.view.bounds.width-40, height: 50)
        self.transferButton.frame = CGRect(x: 20, y: 250, width: self.view.bounds.width-40, height: 0)
        self.transferButton.sizeToFit()
        self.uppercaseLabel.frame = CGRect(x: 20, y: 300, width: self.view.bounds.width-40, height: 200)
    }
    @objc func transferShowing() {
        self.uppercaseLabel.text = "大写：" + uppercase(self.priceInput.text)
    }
}

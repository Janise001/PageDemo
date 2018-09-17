//
//  BannerViewController.swift
//  BannerApp
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    var banner:Banner = Banner(frame: CGRect(x: 20, y: 100, width: 0, height: 0))
    let textField:UITextField = {
        let view = UITextField()
        view.placeholder = "请网络图片地址..."
        view.layer.borderWidth = 1
        view.layer.borderColor = Color.gray.cgColor
        view.clearButtonMode = .always
        return view
    }()
    let submitButton:UIButton = {
        let button = UIButton()
        button.setTitle("提交", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.red
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        banner.imgUrlArrs = ["http://b-ssl.duitang.com/uploads/item/201506/23/20150623184608_kj45n.jpeg",
                             "http://www.4gbizhi.com/uploads/allimg/150316/144Ha0M-0.jpg",
                             "http://img3.duitang.com/uploads/item/201504/06/20150406H2227_nTYsK.thumb.700_0.jpeg"]
        banner.frame.size.height = 100
        banner.frame.size.width = 100
        self.view.addSubview(self.banner)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.submitButton)
        self.submitButton.addTarget(self, action: #selector(addImages), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textField.frame = CGRect(x: 0, y: 620, width: self.view.bounds.width, height: 30)
        self.submitButton.frame = CGRect(x: 0, y: 650, width: 0, height: 0)
        self.submitButton.sizeToFit()
    }
    @objc func addImages(){
        guard let url = self.textField.text else {
            return
        }
        self.banner.imgUrlArrs.insert(url, at: 0)
    }

}


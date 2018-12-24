//
//  CacheDataListController.swift
//  PageDemo
//  输入框多次输入的数据在输入框聚焦后以列表的形式展示出来，点击列表中的一行数据后赋值给列表，输入状态时自动匹配并展示列表
//  Created by 吴丽娟 on 2018/12/18.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public let user: UserDefaults = UserDefaults.standard
class CacheDataListController: UIViewController,UITextFieldDelegate {
    //电话号码输入框
    let inputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入价格"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = Color.gray.cgColor
        textField.clearButtonMode = .always
        return textField
    }()
    //登录按钮（无登录接口，此处只做手机号码输入记录）
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.red
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        return button
    }()
    //手机号码列表
    var mobileList: MatchingListController = MatchingListController()
    //手机号码Data
    var mobileData: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputField.delegate = self
        self.view.addSubview(self.inputField)
        self.view.addSubview(self.loginButton)
        self.loginButton.addTarget(self, action: #selector(addNumber), for: .touchUpInside)
        self.mobileData = user.stringArray(forKey: "mobiles") ?? []
        mobileList.selectBlock = {(mobile) in
            self.inputField.text = mobile
        }
        mobileList.cleanBlock = { (numbers) in
            self.mobileData = numbers
        }
        //设置手机号码列表数据
        setMobileListData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.inputField.frame = CGRect(x: 20, y: 240, width: self.view.bounds.width-40, height: 50)
        self.loginButton.frame = CGRect(x: 20, y: 150, width: self.view.bounds.width-40, height: 50)
        self.mobileList.frame = CGRect(x: 20, y: 290, width: self.view.bounds.width-40, height: 200)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.addSubview(self.mobileList)
        self.mobileList.isHidden = (self.mobileData?.count)! <= 0
        self.setMobileListData()
    }
    /// 添加数据
    @objc func addNumber() {
        if var moblieArr = self.mobileData {
            if (self.inputField.text?.count)! > 0 {
                if !moblieArr.contains(self.inputField.text!) {
                    moblieArr.append(self.inputField.text!)
                    self.mobileData = moblieArr
                    user.set(moblieArr, forKey: "mobiles")
                }
            }
        }else {
            var arr: [String] = []
            if (self.inputField.text?.count)! > 0  {
                arr.append(self.inputField.text!)
                self.mobileData = arr
                user.set(arr, forKey: "mobiles")
            }
        }
        self.setMobileListData()
    }
    /// 设置列表数据
    func setMobileListData() {
        let moblieArrs = self.mobileData
        guard let mobiles = moblieArrs else { return }
        var models: [PhoneNumber] = []
        mobiles.forEach { (mobile) in
            let model = PhoneNumber()
            model.phone = mobile
            models.append(model)
        }
        self.mobileList.configData(models.reversed())
    }
}

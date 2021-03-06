//
//  BannerViewController.swift
//  BannerApp
//  轮播控件
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
class BannerViewController: UIViewController {

    var banner:Banner = Banner(frame: CGRect(x: 20, y: 70, width: 0, height: 0))
    let addTextField:UITextField = {
        let view = UITextField()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Color.gray.cgColor
        view.layer.cornerRadius = 5
        view.keyboardType = .numberPad
        view.clearButtonMode = .always
        return view
    }()
    let addTextView:UITextView  = {
        let view = UITextView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Color.gray.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    let addButton:UIButton = {
        let button = UIButton()
        button.setTitle("添加", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.red
        return button
    }()
    let deleteButton:UIButton = {
        let button = UIButton()
        button.setTitle("删除", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitleColor(Color.white, for: .normal)
        button.backgroundColor = Color.red
        return button
    }()
    let deleteTextField:UITextField = {
        let view = UITextField()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Color.gray.cgColor
        view.layer.cornerRadius = 5
        view.keyboardType = .numberPad
        view.clearButtonMode = .always
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.white
        banner.imgUrlArrs = [
        "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1815461481,372626589&fm=26&gp=0.jpg",
        "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2250404023,1376030781&fm=26&gp=0.jpg",
        "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1263410211,1482917137&fm=26&gp=0.jpg",
        "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1815461481,372626589&fm=26&gp=0.jpg",
        "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2250404023,1376030781&fm=26&gp=0.jpg",
        "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1263410211,1482917137&fm=26&gp=0.jpg"]
        banner.frame.size.height = 400
        banner.frame.size.width = 200
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
//            let time = Date().timeIntervalSince1970
//            for i in 0...1000 {
//                self.banner.frame.size.height += 0.1
//                self.banner.frame.size.width += 0.2
//                self.banner.setNeedsLayout()
//                self.banner.layoutIfNeeded()
//                if i == 1000 {
//                    print(Date().timeIntervalSince1970 - time)
//                }
//            }
//        })
        self.view.addSubview(self.banner)
        self.view.addSubview(self.addTextField)
        self.view.addSubview(self.addButton)
        self.view.addSubview(self.addTextView)
        self.view.addSubview(self.deleteButton)
        self.view.addSubview(self.deleteTextField)
        self.addButton.addTarget(self, action: #selector(addImages), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.addButton.frame = CGRect(x: 0, y: 490, width: 0, height: 0)
        self.addButton.sizeToFit()
        self.addTextField.frame = CGRect(x: 70, y: 490, width: 50, height: 30)
        self.addTextView.frame = CGRect(x: 70, y: 530, width: self.view.bounds.width-70, height: 60)
        self.deleteButton.sizeToFit()
        self.deleteButton.frame.origin = CGPoint(x: 0, y: 600)
        self.deleteTextField.frame = CGRect(x: 70, y: 600, width: 50, height: 30)
    }
    @objc func addImages(){
        guard let url = self.addTextView.text else {
            return
        }
        let insertNum = self.addTextField.text == "" ? 0 : Int(self.addTextField.text!)
        if insertNum! > self.banner.imgUrlArrs.count {
            self.banner.imgUrlArrs.insert(url, at: self.banner.imgUrlArrs.count)
//            let alert = UIAlertController(title:"", message: "请输入正确数字", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }else {
            self.banner.imgUrlArrs.insert(url, at: insertNum!)
        }
    }
    @objc func deleteImage(){
        let deleteNum = self.deleteTextField.text! == "" ? 1 : Int(self.deleteTextField.text!)
        if deleteNum! > self.banner.imgUrlArrs.count {
            let alert = UIAlertController(title:"", message: "请输入正确数字", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            self.banner.imgUrlArrs.remove(at: (deleteNum!-1))
        }
    }

}


//
//  HomeViewController.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit
class HomeViewController: UIViewController,UIScrollViewDelegate {

    let scrollView:UIScrollView = UIScrollView()
    let dir:[String:UIViewController] = ["":PageViewController()]
    let flexView:UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: 0, height: self.dir.count * 50)
        self.view.addSubview(self.scrollView)
        
        // Do any additional setup after loading the view.
    }
    func addChildViews(){
        if self.dir.count > 0 {
            for i in 0..<self.dir.count {
                let obj = self.dir[i]
                let contentView:ContentView = ContentView()
                contentView.titleStr = self.dir[i].key
                contentView.button.addTarget(self, action: #selector(pushToController), for: .touchUpInside)
                contentView.frame = CGRect(x: 10, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            }
        }
    }
    //跳转至指定controller
    @objc func pushToController(_ conView:UIViewController){
        self.navigationController?.pushViewController(conView, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.frame = self.view.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

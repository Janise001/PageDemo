//
//  HomeViewController.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit
import FlexLayout
class HomeViewController: UIViewController,UIScrollViewDelegate {

    let scrollView:UIScrollView = UIScrollView()
    let dir:[String:UIViewController] = ["写一个banner,class Banner:UIView 抛出属性 var imageUrlArray:[String] = []":BannerViewController(),
                                         "2018.08.03 继承自UIControl,内部不能通过创建UIView的方式实现，通过CALayer实现":PageViewController()]
    let flexView:UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: 0, height: self.dir.count * 50)
        self.view.addSubview(self.scrollView)
        self.addChildViews()
        // Do any additional setup after loading the view.
    }
    func addChildViews(){
        if self.dir.count > 0 {
            for obj in self.dir {
                let contentView:ContentView = ContentView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width-10, height: 40))
                let titleStr = obj.key
                contentView.button.setTitle(titleStr, for: .normal)
                contentView.button.addTarget(self, action: #selector(self.pushToController), for: .touchUpInside)
                self.scrollView.flex.addItem(contentView).width(self.view.bounds.width-10).height(40)
            }
        }
    }
    //跳转至指定controller
    @objc func pushToController(_ sender:UIButton){
        let viewCon = self.dir[sender.titleLabel?.text ?? ""]
        self.navigationController?.pushViewController(viewCon!, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        self.scrollView.flex.layout()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//
//  GradientColorViewController.swift
//  PageDemo
//  颜色渐变demo
//  Created by 吴丽娟 on 2018/12/14.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class GradientColorViewController: UIViewController {

    var gradientLayer: CAGradientLayer!
    var gradientView: UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gradientView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        self.view.addSubview(self.gradientView)
        self.addGradientColor()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    /// 添加渐变色layer
    func addGradientColor() {
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.gradientView.frame.size)
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        self.gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.gradientLayer.colors = [Color.yellow.cgColor,Color.red.cgColor]
        print(self.gradientLayer.frame)
        self.gradientView.layer.addSublayer(self.gradientLayer)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

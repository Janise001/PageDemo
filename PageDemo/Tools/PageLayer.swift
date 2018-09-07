//
//  PageLayer.swift
//  PageDemo
//
//  Created by Janise·Wu on 2018/8/7.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class PageLayer: CALayer {
    var currentPage:Int = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var count:Int = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var pageIndicatorTintColor:UIColor = UIColor.blue
    var currentPageIndicatorTintColor:UIColor = UIColor.gray
    override func draw(in ctx: CGContext) {
        
        for i in 0..<self.count {
            if i == self.currentPage {
                ctx.setFillColor(self.currentPageIndicatorTintColor.cgColor)
            }else{
                ctx.setFillColor(self.pageIndicatorTintColor.cgColor)
            }
            ctx.addEllipse(in: CGRect(x: i*20, y: 0, width: 8, height: 8))
            ctx.fillPath()
        }
    }
    
}

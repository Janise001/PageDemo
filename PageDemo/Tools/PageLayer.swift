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
    //分页每个圆的颜色
    var pageIndicatorTintColor:UIColor = UIColor.blue
    //当前页的圆颜色
    var currentPageIndicatorTintColor:UIColor = UIColor.gray
    //分页每个圆的大小
    var pageIndicatorSize:CGSize = CGSize(width: 7, height: 7)
    //当前页的圆大小
    var currentPageIndicatorSize:CGSize = CGSize(width: 7, height: 7)
    //分页之间的间隔
    var space:CGFloat = 10
    var pagePointX: CGFloat = 0
    override func draw(in ctx: CGContext) {
        
        for i in 0..<self.count {
            if i == self.currentPage {
                ctx.setFillColor(self.currentPageIndicatorTintColor.cgColor)
                ctx.addEllipse(in: CGRect(x: self.pagePointX, y: 0, width: self.currentPageIndicatorSize.width, height: self.currentPageIndicatorSize.height))
                self.pagePointX = pagePointX+self.currentPageIndicatorSize.width + self.space
            }else{
                ctx.setFillColor(self.pageIndicatorTintColor.cgColor)
                ctx.addEllipse(in: CGRect(x: self.pagePointX, y: 0, width: self.pageIndicatorSize.width, height: self.pageIndicatorSize.height))
                self.pagePointX = pagePointX+self.pageIndicatorSize.width + self.space
            }
            if i == self.count - 1 {
                self.pagePointX = 0
            }
//            ctx.addEllipse(in: CGRect(x: i*20, y: 0, width: 8, height: 8))
            ctx.fillPath()
        }
    }
    
}

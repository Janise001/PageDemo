//
//  PageControl.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/9/3.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit
protocol A {
    var v:Int {get}
}
open class PageControl: UIControl {
    
    var pageLayer:PageLayer {
        return self.layer as! PageLayer
    }
    open override class var layerClass: AnyClass {
        return PageLayer.self
    }
    
//    public required override init(frame: CGRect) {
//        self.layer.addSublayer(self.pageLayer)
//        self.pageLayer.frame = frame
//    }
    
    //    open override func draw(_ rect: CGRect) {required
//
//    }
//    open override func draw(_ layer: CALayer, in ctx: CGContext) {
//        <#code#>
//    }
    
    
//        open var numberOfPages: Int = 0 { get }
//    open var currentPage: Int = 0  { get }
//    open var hidesForSinglePage: Bool { get }
//    open func size(forNumberOfPages pageCount: Int) -> CGSize
//    open var pageIndicatorTintColor: UIColor? { get }
//    open var currentPageIndicatorTintColor: UIColor? { get }
    open var numberOfPages:Int = 0 {
        didSet {
            update()
        }
    }
    open var currentPage:Int = 0 {
        didSet {
          self.pageLayer.currentPage = self.currentPage
            self.pageLayer.setNeedsDisplay()
        }
    }
    open var hidesForSinglePage:Bool = true {
        didSet {
            update()
        }
    }
    open var pageIndicatorTintColor:UIColor? {
        didSet {
            guard let color = self.pageIndicatorTintColor else {
                return
            }
             self.pageLayer.pageIndicatorTintColor = color
            self.pageLayer.setNeedsDisplay()
        }
    }
    open var currentPageIndicatorTintColor:UIColor? {
        didSet {
            guard let color = self.currentPageIndicatorTintColor else {
                return
            }
            self.pageLayer.currentPageIndicatorTintColor = color
            self.pageLayer.setNeedsDisplay()
        }
    }
    func update() {
        self.pageLayer.count = self.numberOfPages
        if self.numberOfPages == 1 && self.hidesForSinglePage == true {
            self.pageLayer.isHidden = true
        }else {
            self.pageLayer.isHidden = false
        }
        self.pageLayer.setNeedsDisplay()
    }
}
extension PageControl {
    //返回控件的宽高数值
    open func size(forNumberOfPages pageCount:Int) -> CGSize {
        var size:CGSize = CGSize(width: 0, height: 10)
        size.width = CGFloat(20*pageCount+8)
        return size
    }
    
}

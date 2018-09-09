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
    open var currentPageIndicatorSize:CGSize = CGSize(width: 7, height: 7) {
        didSet{
            self.pageLayer.currentPageIndicatorSize = self.currentPageIndicatorSize
            self.pageLayer.setNeedsDisplay()
        }
    }
    open var pageIndicatorSize:CGSize = CGSize(width: 7, height: 7) {
        didSet{
            self.pageLayer.pageIndicatorSize = self.pageIndicatorSize
            self.pageLayer.setNeedsDisplay()
        }
    }
    //实现当页数为1的时候更新控件的显示和隐藏
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
        var size:CGSize = CGSize(width: 0, height: 0)
        size.width = CGFloat(20*pageCount+8)
        size.height = max(self.currentPageIndicatorSize.height,self.pageIndicatorSize.height)
        return size
    }
    //返回某个点的尺寸
    open func sizeOfIndex(_ index:Int) -> CGSize {
        if self.currentPage == index {
            return self.currentPageIndicatorSize
        }
        return self.pageIndicatorSize
    }
    //返回当前页面所在点的尺寸
    open func sizeOfCurrentIndex() -> CGSize {
        var result:CGSize = CGSize(width: 0, height: 0)
        result = self.sizeOfIndex(self.currentPage)
        return result
    }
    
    func max(_ param1:CGFloat,_ param2:CGFloat) -> CGFloat {
        
        if param1 > param2 {
            return param1
        }
        return param2
    }
}

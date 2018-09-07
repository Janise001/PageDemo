//
//  ViewController.swift
//  PageDemo
//
//  Created by Janise·Wu on 2018/8/7.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
//    let pageControl:PageLayer = PageLayer()
//    let scrollView:UIScrollView = UIScrollView()
//    
//    var vw:CGFloat = 0.0
//    var currentPage:Int = 0
//    var count:Int = 3
    
    //滚动控件
    let scrollView:UIScrollView = UIScrollView()
    //分页控件
    let pageControl:PageControl = PageControl()
    let uiPageControl:PageController = PageController()
    //分页控件信息
    let count = 4
    var currentPage:Int = 0
    
    var wh:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wh = self.view.frame.width
//        pageControl.count = self.count
//        pageControl.currentPage = self.currentPage
//        pageControl.contentsScale = UIScreen.main.scale
//        let pageView:UIView = UIView()
//        pageView.layer.addSublayer(self.pageControl)
//        self.scrollView.delegate = self
//        self.scrollView.backgroundColor = UIColor.cyan
//        self.scrollView.isPagingEnabled = true
//        self.scrollView.frame = CGRect(x: 20, y: 150, width: self.wh-40, height: 150)
//        pageView.frame = CGRect(x: (self.wh-40)*0.5-24, y: 270, width: 48, height: 20)
//        self.scrollView.contentSize.width = CGFloat(pageControl.count) * self.scrollView.frame.width
//        self.view.addSubview(self.scrollView)
//        self.view.addSubview(pageView)
        
        self.scrollView.delegate = self
        self.scrollView.backgroundColor = UIColor.cyan
        self.scrollView.isPagingEnabled = true
        self.scrollView.frame = CGRect(x: 20, y: 150, width: self.wh-40, height: 150)
        self.scrollView.contentSize.width = CGFloat(count) * self.scrollView.frame.width
        self.view.addSubview(self.scrollView)
        
        self.uiPageControl.currentPage = self.currentPage
        self.uiPageControl.numberOfPages = self.count
        self.uiPageControl.currentPageIndicatorTintColor = UIColor.red
        self.uiPageControl.pageIndicatorTintColor = UIColor.blue
        self.uiPageControl.backgroundColor = UIColor.yellow
        self.uiPageControl.frame = CGRect(x: self.wh*0.5-50, y: 170, width: 0, height: 0)
        self.uiPageControl.sizeToFit()
        self.view.addSubview(self.uiPageControl)
        
        
        self.pageControl.currentPage = self.currentPage
        self.pageControl.numberOfPages = self.count
        self.pageControl.backgroundColor = UIColor.yellow
        self.pageControl.hidesForSinglePage = false
        let size = self.pageControl.size(forNumberOfPages: self.count)
        self.pageControl.frame = CGRect(origin: CGPoint(x: self.wh*0.5-size.width*0.5, y: 270), size: size)
        self.view.addSubview(self.pageControl)
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        pageControl.frame = CGRect(x: 0, y: 0, width: 48, height: 20)
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.pageControl.setNeedsDisplay()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offSetX = scrollView.contentOffset.x
            self.currentPage = Int(offSetX/(self.wh-40))
            self.pageControl.currentPage = self.currentPage
            self.pageControl.setNeedsDisplay()
            self.uiPageControl.currentPage = self.currentPage
        }
    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView == self.scrollView {
//            let offSetX = scrollView.contentOffset.x
//            self.currentPage = Int(offSetX/(self.wh-40))
//            self.pageControl.currentPage = self.currentPage
//            self.pageControl.setNeedsDisplay()
//        }
//    }
}

class PageController:UIPageControl{
    override func size(forNumberOfPages pageCount: Int) -> CGSize {
//        var size:CGSize = CGSize(width: 0, height: 0)
//        size.width = CGFloat(pageCount * 10)
//        size.height = 10
        return CGSize(width: 10, height: 10)
    }
}


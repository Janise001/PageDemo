//
//  Banner.swift
//  BannerApp
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
import Kingfisher
class Banner: UIView,UIScrollViewDelegate {
    //记录初始设置UIImageView的数量
    var firstCount:Int = 0
    //记录变化之后的UIImageView的数量
    var secondCount:Int = 0
    //图片地址数组
    var imgUrlArrs = [String](){
        didSet {
//            for view in self.scrollView.subviews {
//                view.removeFromSuperview()
//            }
            self.secondCount = self.imgUrlArrs.count
            self.setImageViewsCount(self.secondCount)
//            self.scrollView.contentSize.width = self.frame.size.width * CGFloat(self.imgUrlArrs.count)
//            self.addImagesToScrollView()
            self.pageControl.numberOfPages = self.imgUrlArrs.count
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    //滚动视图
    let scrollView:UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = Color.blue
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    let pageControl:UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.hidesForSinglePage = false
        view.pageIndicatorTintColor = Color.darkGray
        view.currentPageIndicatorTintColor = Color.lightGray
        return view
    }()
    //宽度
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.firstCount = self.imgUrlArrs.count
        self.addSubview(self.scrollView)
        self.scrollView.delegate = self
        self.addSubview(self.pageControl)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.scrollView.contentSize.width = self.frame.size.width * CGFloat(self.imgUrlArrs.count)
        
        for (i,imageView) in self.scrollView.subviews.enumerated() {
            imageView.frame = CGRect(x: CGFloat(i)*self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            let url = URL(string: imgUrlArrs[i])
            let view = imageView as! UIImageView
            view.kf.setImage(with: url)
            view.contentMode = .scaleAspectFit
        }
        self.pageControl.frame = CGRect(x: 100, y: 400, width: 0, height: 0)
        self.pageControl.sizeToFit()
        self.pageControl.frame.origin.x = frame.width/2-self.pageControl.frame.width/2
        self.pageControl.frame.origin.y = frame.height-self.pageControl.frame.height
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offSetX = scrollView.contentOffset.x
            self.pageControl.currentPage = Int(offSetX/self.frame.size.width)
        }
    }
    //设置图片数量并添加至滚动视图中去
    func setImageViewsCount(_ count:Int) {
        //少加
        if count > self.firstCount {
            let changCount = count - self.firstCount
            for i in 0..<changCount {
                let imageView = UIImageView()
                self.scrollView.addSubview(imageView)
            }
        }else if count < self.firstCount {
            //多减
            for (i,imageView) in self.scrollView.subviews.enumerated() {
                if i > self.firstCount - 2 {
                    imageView.removeFromSuperview()
                }
            }
        }
        self.firstCount = self.secondCount
    }
//    //添加图片到滚动视图中
//    func addImagesToScrollView(){
//        guard self.imgUrlArrs.count > 0 else {
//            return
//        }
//        for imageURL in self.imgUrlArrs {
//            let imageView = UIImageView()
//            let url = URL(string: imageURL)
//            imageView.kf.setImage(with: url)
//            imageView.contentMode = .scaleAspectFit
//            self.scrollView.addSubview(imageView)
//        }
//    }
}

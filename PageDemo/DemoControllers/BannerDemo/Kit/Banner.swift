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
    
    //图片地址数组
    var imgUrlArrs = [String](){
        didSet {
            self.samplifyCount(self.imgUrlArrs)
        }
    }
    var imageViewArrs = [UIImageView](){
        didSet {
            if self.scrollView.subviews.count > self.imageViewArrs.count {
                let changCount = self.scrollView.subviews.count - imageViewArrs.count
                for (i,imageView) in self.scrollView.subviews.enumerated() {
                    if i > changCount {
                        imageView.removeFromSuperview()
                    }
                }
            }else if self.scrollView.subviews.count < self.imageViewArrs.count {
                let changCount = imageViewArrs.count - self.scrollView.subviews.count
                for i in 0..<changCount {
                    self.scrollView.addSubview(self.imageViewArrs[i])
                }
            }
            self.updateImages()
            self.setNeedsLayout()
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
        }
        self.pageControl.sizeToFit()
        self.pageControl.frame.origin.x = frame.width/2-self.pageControl.frame.width/2
        self.pageControl.frame.origin.y = frame.height-self.pageControl.frame.height
        self.pageControl.numberOfPages = self.imgUrlArrs.count
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
    func samplifyCount(_ urlArr:[String]) {
        //少加
        if urlArr.count > imageViewArrs.count {
            let changCount = urlArr.count - imageViewArrs.count
            var changeArr:[UIImageView] = []
            for _ in 0..<changCount {
                let imageView = UIImageView()
                changeArr.append(imageView)
            }
            self.imageViewArrs.append(contentsOf: changeArr)
        }else if urlArr.count < imageViewArrs.count {
            //多减
            let changeCount = imageViewArrs.count - urlArr.count
            imageViewArrs.removeLast(changeCount)
        }
    }
    //更新图片数据
    func updateImages(){
        for (i,imageView) in self.scrollView.subviews.enumerated() {
            let url = URL(string: imgUrlArrs[i])
            let view = imageView as! UIImageView
            view.kf.setImage(with: url)
            view.contentMode = .scaleAspectFit
        }
    }
}

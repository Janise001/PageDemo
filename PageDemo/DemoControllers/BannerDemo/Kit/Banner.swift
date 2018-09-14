//
//  Banner.swift
//  BannerApp
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class Banner: UIView,UIScrollViewDelegate {
    //图片地址数组
    var imgUrlArrs = [String](){
        didSet {
            for view in self.scrollView.subviews {
                view.removeFromSuperview()
            }
            self.scrollView.contentSize.width = self.imageWidth * CGFloat(self.imgUrlArrs.count)
            self.addImagesToScrollView()
            self.pageControl.numberOfPages = self.imgUrlArrs.count
        }
    }
    
    //滚动视图
    let scrollView:UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = Color.blue
        view.isPagingEnabled = true
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
    //图片宽度
    var imageWidth:CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.scrollView)
        self.scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.pageControl.frame = CGRect(x: 100, y: 400, width: 0, height: 0)
        self.pageControl.sizeToFit()
        self.pageControl.frame.origin.x = self.bounds.width/2-self.pageControl.frame.width/2
        self.addSubview(self.pageControl)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let offSetX = scrollView.contentOffset.x
            self.pageControl.currentPage = Int(offSetX/self.imageWidth)
        }
    }
    //添加图片到滚动视图中
    func addImagesToScrollView(){
        if self.imgUrlArrs.count != 0 {
            for i in 0...self.imgUrlArrs.count-1 {
                let imageView:UIImageView = {
                    let view = UIImageView()
                    view.frame.size = self.bounds.size
                    return view
                }()
                let url = URL(string: self.imgUrlArrs[i])
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data)
                imageView.image = image
                imageView.frame = CGRect(x: CGFloat(i)*self.imageWidth, y: 0, width: self.bounds.width, height: self.bounds.height)
                self.scrollView.addSubview(imageView)
            }
        }
    }
}

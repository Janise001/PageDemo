//
//  Banner.swift
//  BannerApp
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit

class Banner: UIViewController,UIScrollViewDelegate {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageWidth = self.view.bounds.width
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: 0, height: 500)
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        self.pageControl.frame = CGRect(x: 100, y: 400, width: 0, height: 0)
        self.pageControl.sizeToFit()
        self.pageControl.frame.origin.x = self.view.bounds.width/2-self.pageControl.frame.width/2
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
                    view.frame.size = self.view.bounds.size
                    return view
                }()
                let url = URL(string: self.imgUrlArrs[i])
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data)
                imageView.image = image
                imageView.frame = CGRect(x: CGFloat(i)*self.imageWidth, y: 0, width: self.imageWidth, height: self.view.bounds.height)
                self.scrollView.addSubview(imageView)
            }
        }
    }
}

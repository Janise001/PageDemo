//
//  Banner.swift
//  BannerApp
//
//  Created by 吴丽娟 on 2018/9/13.
//  Copyright © 2018年 Janise. All rights reserved.
//

import UIKit
import Kingfisher
open class Banner: UIView,UIScrollViewDelegate {
    /// 图片地址数组
    public var imgUrlArrs:[String] = [] {
        didSet {imgUrlArrsChanged()}
    }
    private var imageViewArrs:[UIImageView] = [] {
        didSet {imageViewArrChanged()}
    }
    /// 滚动视图
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
    // MARK: -
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configInit()
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configInit() {
        addChildView()
        self.scrollView.delegate = self
    }
    func addChildView() {
        self.addSubview(self.scrollView)
        self.addSubview(self.pageControl)
    }
    // MARK: -
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateScrollViewLayout()
        updatePageControlLayout()
    }
    func updateScrollViewLayout() {
        self.scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.scrollView.contentSize.width = self.frame.size.width * CGFloat(self.imgUrlArrs.count)
        _ = self.imageViewArrs.reduce(0) { (last, imageView) -> CGFloat in
            imageView.frame.size = self.frame.size
            imageView.frame.origin.y = 0
            imageView.frame.origin.x = last
            return imageView.frame.maxX
        }
    }
    func updatePageControlLayout() {
        self.pageControl.sizeToFit()
        self.pageControl.frame.origin.x = frame.width/2-self.pageControl.frame.width/2
        self.pageControl.frame.origin.y = frame.height-self.pageControl.frame.height
    }
    // MARK: -
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offSetX = scrollView.contentOffset.x
        self.pageControl.currentPage = Int(offSetX/self.frame.size.width)
    }
    // MARK: -
    func imgUrlArrsChanged() {
        samplifyImageViewCount(imgUrlArrs)
    }
    func imageViewArrChanged() {
        self.pageControl.numberOfPages = self.imgUrlArrs.count
        self.updateImages()
        self.setNeedsLayout()
    }
    /// 设置图片数量并添加至滚动视图中去
    func samplifyImageViewCount(_ urlArr:[String]) {
        let newCount = urlArr.count
        var _imageViewArrs = self.imageViewArrs
        while _imageViewArrs.count < newCount {
            let imageView = createImageView()
            _imageViewArrs.append(imageView)
            self.scrollView.addSubview(imageView)
        }
        while _imageViewArrs.count > newCount {
            let last = _imageViewArrs.removeLast()
            last.removeFromSuperview()
        }
        self.imageViewArrs = _imageViewArrs
    }
    func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    /// 更新图片数据
    func updateImages() {
        for (offset,imageView) in self.imageViewArrs.enumerated() {
            let url = URL(string: imgUrlArrs[offset])
            imageView.kf.setImage(with: url)
        }
    }
}

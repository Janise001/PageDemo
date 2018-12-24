//
//  MatchingListController.swift
//  PageDemo
//
//  Created by 吴丽娟 on 2018/12/18.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class MatchingListController: UITableView,UITableViewDelegate,UITableViewDataSource {
    //选中行block
    var selectBlock:((String)->())?
    //清除数据block
    var cleanBlock:(([String])->())?
    //设置清除缓存
    let cleanButton: UIButton = {
        let button = UIButton()
        button.setTitle("清除所有号码", for: .normal)
        button.setTitleColor(Color.black, for: .normal)
        button.backgroundColor = Color.white
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return button
    }()
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.register(MatchingListCellTableViewCell.self, forCellReuseIdentifier: "MatchingListCellTableViewCell")
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = Color.white
        self.showsVerticalScrollIndicator = false
        cleanButton.frame.size = CGSize(width: self.bounds.width, height: 50)
        self.tableFooterView = cleanButton
        cleanButton.addTarget(self, action: #selector(cleanData), for: .touchUpInside)
    }
    @objc func cleanData() {
        user.set(nil, forKey: "mobiles")
        self.phoneModels = []
        self.cleanBlock?([])
        self.isHidden = true
    }
    func configData(_ models: [PhoneNumber]) {
        self.phoneModels = models
    }
    private var phoneModels: [PhoneNumber]? = nil {
        didSet {
            self.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let models = self.phoneModels else {
            return 0
        }
        return models.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let models = self.phoneModels {
            self.selectBlock?(models[indexPath.row].phone ?? "")
            self.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchingListCellTableViewCell", for: indexPath)
        let phoneNumberLabel: UILabel = cell.viewWithTag(100) as! UILabel
        phoneNumberLabel.text = self.phoneModels![indexPath.row].phone
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

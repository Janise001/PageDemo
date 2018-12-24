//
//  UppercaseKit.swift
//  PageDemo
//  将数字价格转换为大写价格文字（未添加Price，此处暂不严格要求转换展示）
//  Created by 吴丽娟 on 2018/12/17.
//  Copyright © 2018年 Janise·Wu. All rights reserved.
//

import Foundation
func uppercase(_ numberPrice: String?) -> String {
    guard let numberText = numberPrice else {
        return "零圆"
    }
    guard let number = Double(numberText) else {
        return ""
    }
    let numberFormat = NumberFormatter()
    numberFormat.locale = Locale.init(identifier: "zh_CN")
    numberFormat.minimumIntegerDigits = 1
    numberFormat.maximumFractionDigits = 2
    numberFormat.minimumFractionDigits = 0
    numberFormat.numberStyle = .spellOut
    let CNUppercaseString = numberFormat.string(from: NSNumber(value: number)) ?? "〇"
    //判断是否为整数
    let numberSplit = numberText.components(separatedBy: ".")
    //获取小数部分，如无小数部分，设置为nil
    let decimal = numberSplit.count > 1 ? Double("0."+numberSplit.last!) : nil
    let isInt = decimal == nil || decimal! < 0.01
    return transderCNToTraditional(CNUppercaseString,isInt)
}
func transderCNToTraditional(_ text: String,_ isInt: Bool) -> String {
    let format = text.replacingOccurrences(of: "一", with: "壹")
                        .replacingOccurrences(of: "二", with: "贰")
                        .replacingOccurrences(of: "三", with: "叁")
                        .replacingOccurrences(of: "四", with: "肆")
                        .replacingOccurrences(of: "五", with: "伍")
                        .replacingOccurrences(of: "六", with: "陆")
                        .replacingOccurrences(of: "七", with: "柒")
                        .replacingOccurrences(of: "八", with: "捌")
                        .replacingOccurrences(of: "九", with: "玖")
                        .replacingOccurrences(of: "〇", with: "零")
                        .replacingOccurrences(of: "十", with: "拾")
                        .replacingOccurrences(of: "百", with: "佰")
                        .replacingOccurrences(of: "千", with: "仟")
    //处理小数部分
    let splitArr = format.components(separatedBy: "点")
    //整数部分截取
    let intString = splitArr[0]
    if isInt {
        return intString.appending("圆整")
    }else {
        let decimalString = splitArr[1]
        //判断是否带分和角单位
        if decimalString.count > 1 {
            return intString.appending("圆").appending("\(decimalString.first!)角\(decimalString.last!)分")
        }else {
            return intString.appending("圆").appending("\(decimalString.first!)角")
        }
    }
}

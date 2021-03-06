//
//  RFCategoryBottomView.swift
//  DanTangSwift
//
//  Created by rocky on 16/8/30.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

import UIKit

protocol RFCategoryBottomViewDelegate: NSObjectProtocol {
    func bottomviewButtonDidClicked(button: UIButton)
}

class RFCategoryBottomView: UIView {

    weak var delegate: RFCategoryBottomViewDelegate?
    var outGroups = [AnyObject]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 分类界面
        RFNetworkTool.shareNetworkTool.loadCategoryGroup { (outGroups) in
            self.outGroups = outGroups
            self.setupUI()
        }
    }
    
    
    private func setupUI(){
        let topGroups = outGroups[0] as! NSArray
        let bottomGroups = outGroups[1] as! NSArray
        
        // 风格
        let topView = UIView()
        topView.width = SCREENW
        topView.backgroundColor = UIColor.whiteColor()
        addSubview(topView)
        let styleLabel = setupLabel("风格")
        topView.addSubview(styleLabel)
        
        for index in 0..<topGroups.count {
            let group = topGroups[index] as! RFGroup
            let button = setupButton(index, group: group)
            topView.addSubview(button)
            if index == topGroups.count - 1 {
                topView.height = CGRectGetMaxY(button.frame) + kMargin
            }
        }
        
        // 品类
        let bottomView = UIView()
        bottomView.width = SCREENW
        bottomView.y = CGRectGetMaxY(topView.frame) + kMargin
        bottomView.backgroundColor = UIColor.whiteColor()
        addSubview(bottomView)
        let categoryLabel = setupLabel("品类")
        bottomView.addSubview(categoryLabel)
        
        for index in 0..<bottomGroups.count{
            let group = bottomGroups[index] as! RFGroup
            let button = setupButton(index, group: group)
            bottomView.addSubview(button)
            if index == bottomGroups.count - 1{
                bottomView.height = CGRectGetMaxY(button.frame) + kMargin
            }
        }
    }
    
    private func setupLabel(title: String) -> UILabel{
        let styleLabel = UILabel(frame:CGRectMake(10, 0, SCREENW - 10, 40))
        styleLabel.text = title
        styleLabel.textColor = RFColor(0, g: 0, b: 0, a: 0.6)
        styleLabel.font = UIFont.systemFontOfSize(16)
        return styleLabel
    }
    
    private func setupButton(index: Int, group: RFGroup) -> RFVerticalButton{
        let buttonW: CGFloat = SCREENW / 4
        let buttonH: CGFloat = buttonW
        let styleLabelH: CGFloat = 40
        
        let button = RFVerticalButton()
        button.width = buttonW
        button.height = buttonH
        button.x = buttonW * CGFloat(index % 4)
        button.y = buttonH * CGFloat(index / 4) + styleLabelH
        if index > 3 {
            button.y = buttonH * CGFloat(index / 4) + styleLabelH + kMargin
        }
        button.tag = group.id!
        button.addTarget(self, action: #selector(groupButonClick(_:)), forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(RFColor(0, g: 0, b: 0, a: 0.6), forState: .Normal)
        button.kf_setImageWithURL(NSURL(string: group.icon_url!), forState: .Normal)
        button.setTitle(group.name, forState: .Normal)
        return button
        
    }
    
    func groupButonClick(button: UIButton) {
        delegate?.bottomviewButtonDidClicked(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
























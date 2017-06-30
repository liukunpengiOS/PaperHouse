//
//  PHPaperPreview.swift
//  PaperHouse
//
//  Created by kunpeng on 2017/6/19.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

import UIKit
import SwiftHEXColors

class PHPaperPreview: UIView {
    
    let padding: CGFloat = 5
    var unflodButton: UIButton?
    var actorImv: UIImageView?
    var nameLabel: UILabel?
    var genderLabel: UILabel?
    var ageLabel: UILabel?
    var pictureLabel: UILabel?
    var attributeLabel: UILabel?
    var filmLabel: UILabel?
    var timeLabel: UILabel?
    var titleLabel: UILabel?
    var contentLabel: UILabel?
    var newFrame: CGRect!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        newFrame = frame
        configElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func configElements () {
        
        configActorImv()
        configNameLabel()
        configGenderLabel()
        configAgeLabel()
        configContentLabel()
        configUnflodButton()
        configAttributeLabel("图 x1", self.ageLabel!)
        configAttributeLabel("影 x1", self.attributeLabel!)
        configTimeLabel()
    }
}

extension PHPaperPreview {
    
     func configActorImv() {
        
        let hegiht = newFrame.size.height - (padding * 2)
        actorImv = UIImageView()
        actorImv?.backgroundColor = UIColor.white
        self.addSubview(actorImv!)
        actorImv!.mas_makeConstraints({ (make) in
            
            make?.top.offset()(self.padding)
            make?.left.offset()(self.padding)
            make?.width.height().offset()(hegiht)
        })
    }
    
     func configNameLabel() {
        
        nameLabel = UILabel()
        nameLabel?.text = "姓名"
        nameLabel?.font = .systemFont(ofSize: 15)
        nameLabel?.textColor = .white
        self.addSubview(nameLabel!)
        nameLabel!.mas_makeConstraints({ (make) in
            
            make?.top.equalTo()(self.actorImv)?.offset()(self.padding)
            make?.left.equalTo()(self.actorImv?.mas_right)?.offset()(self.padding)
        })
    }
    
    private func configGenderLabel() {
        
        genderLabel = UILabel()
        genderLabel?.text = "男"
        genderLabel?.font = .systemFont(ofSize: 10)
        genderLabel?.textColor = .white
        self.addSubview(genderLabel!)
        genderLabel!.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(self.nameLabel?.mas_right)?.offset()(self.padding)
            make?.bottom.equalTo()(self.nameLabel)?.offset()(-1)
        }
    }
    
     func configAgeLabel() {
        
        ageLabel = UILabel()
        ageLabel?.text = "28"
        ageLabel?.textColor = .white
        ageLabel?.font = .systemFont(ofSize: 10)
        self.addSubview(ageLabel!)
        ageLabel!.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(self.genderLabel?.mas_right)?.offset()(self.padding)
            make?.bottom.equalTo()(self.genderLabel)
        }
    }
    
     func configContentLabel() {
        
        contentLabel = UILabel()
        contentLabel?.text = "我是标题，爱咋咋地"
        contentLabel?.textColor = .white
        contentLabel?.font = .systemFont(ofSize: 15)
        self.addSubview(contentLabel!)
        contentLabel!.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(self.actorImv?.mas_right)?.offset()(self.padding)
            make?.bottom.equalTo()(self.actorImv)
        }
    }
    
     func configTimeLabel(){
        
        timeLabel = UILabel()
        timeLabel?.text = "26min"
        timeLabel?.textColor = .white
        timeLabel?.font = .systemFont(ofSize: 13)
        self.addSubview(timeLabel!)
        timeLabel!.mas_makeConstraints { (make) in
            
            make?.right.equalTo()(-50)
            make?.bottom.equalTo()(self.nameLabel)
        }
    }
    
     func configUnflodButton() {
        
        let hegiht = newFrame.size.height - 2
        unflodButton = UIButton(type: .system)
        unflodButton?.setTitle("开", for: .normal)
        unflodButton?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        unflodButton?.setTitleColor(.white, for: .normal)
        unflodButton?.backgroundColor = UIColor(hexString: "#6666ff")
        self.addSubview(unflodButton!)
        unflodButton!.mas_makeConstraints({ (make) in
            
            make?.top.offset()(1)
            make?.right.offset()(-1)
            make?.height.offset()(hegiht)
            make?.width.offset()(30)
        })
    }
}

extension PHPaperPreview {
    
    func configAttributeLabel (_ typeString: String,_ label: UILabel) {
        
        let padding: CGFloat = 5
        let mutableString = NSMutableAttributedString(string: typeString)
        let range1 = NSRange(location: 0, length: 1)
        mutableString.addAttributes([.foregroundColor:UIColor.white,
                                     .font:UIFont.systemFont(ofSize: 15)],
                                      range: range1)
        mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 10),
                                   range: NSRange(location: 2, length: 1))
        mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13),
                                   range: NSRange(location: 3, length: 1))
        attributeLabel = UILabel()
        attributeLabel?.sizeToFit()
        attributeLabel?.attributedText = mutableString
        attributeLabel?.textColor = .white
        self.addSubview(attributeLabel!)
        attributeLabel!.mas_makeConstraints({ (make) in
            
            make?.left.equalTo()(label.mas_right)?.offset()(padding)
            make?.bottom.equalTo()(self.nameLabel)
        })
    }
}

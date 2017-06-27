//
//  PHPaperPreview.swift
//  PaperHouse
//
//  Created by kunpeng on 2017/6/19.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

import UIKit

class PHPaperPreview: UIView {
    
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
    
    private func configElements () {
        
        configActorImv()
        configNameLabel()
        configGenderLabel()
        configAgeLabel()
        configAttributeLabel()
    }
}

extension PHPaperPreview {
    
    private func configActorImv() {
        
        let padding:CGFloat = 5
        let hegiht = newFrame.size.height - (padding * 2)
        actorImv = UIImageView()
        actorImv?.backgroundColor = UIColor.white
        self.addSubview(actorImv!)
        actorImv!.mas_makeConstraints({ (make) in
            
            make?.top.left().offset()(padding)
            make?.width.height().offset()(hegiht)
        })
    }
    
    private func configNameLabel() {
        
        let padding: CGFloat = 5
        nameLabel = UILabel()
        nameLabel?.text = "姓名"
        nameLabel?.font = .systemFont(ofSize: 15)
        nameLabel?.textColor = .white
        self.addSubview(nameLabel!)
        nameLabel!.mas_makeConstraints({ (make) in
            
            make?.top.offset()(padding)
            make?.left.equalTo()(self.actorImv?.mas_right)?.offset()(padding)
        })
    }
    
    private func configGenderLabel() {
        
        let padding: CGFloat = 5
        genderLabel = UILabel()
        genderLabel?.text = "男"
        genderLabel?.font = .systemFont(ofSize: 10)
        genderLabel?.textColor = .white
        self.addSubview(genderLabel!)
        genderLabel!.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(self.nameLabel?.mas_right)?.offset()(padding)
            make?.bottom.equalTo()(self.nameLabel)?.offset()(-1)
        }
    }
    
    private func configAgeLabel() {
        
        let padding: CGFloat = 5
        ageLabel = UILabel()
        ageLabel?.text = "28"
        ageLabel?.textColor = .white
        ageLabel?.font = .systemFont(ofSize: 10)
        self.addSubview(ageLabel!)
        ageLabel!.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(self.genderLabel?.mas_right)?.offset()(padding)
            make?.bottom.equalTo()(self.genderLabel)
        }
    }
}

extension PHPaperPreview {
    
    func configAttributeLabel () {
        
        let padding: CGFloat = 5
        let mutableString = NSMutableAttributedString(string: "图 X1")
        let range1 = NSRange(location: 0, length: 1)
        mutableString.addAttributes([.foregroundColor:UIColor.white,
                                     .backgroundColor:UIColor.orange,
                                     .font:UIFont.systemFont(ofSize: 15)],
                                      range: range1)
        mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 10),
                                   range: NSRange(location: 2, length: 1))
        mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13),
                                   range: NSRange(location: 3, length: 1))
        attributeLabel = UILabel()
        attributeLabel?.attributedText = mutableString
        attributeLabel?.textColor = .white
        self.addSubview(attributeLabel!)
        attributeLabel!.mas_makeConstraints({ (make) in
            
            make?.left.equalTo()(self.ageLabel?.mas_right)?.offset()(padding)
            make?.bottom.equalTo()(self.ageLabel)
        })
    }
}

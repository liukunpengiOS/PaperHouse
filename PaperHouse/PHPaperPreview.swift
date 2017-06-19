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
    var pictureLabel: UILabel?
    var filmLabel: UILabel?
    var timeLabel: UILabel?
    var titleLabel: UILabel?
    var contentLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

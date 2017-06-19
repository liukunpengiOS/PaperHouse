//
//  PHAnimation.swift
//  PaperHouse
//
//  Created by kunpeng on 2017/6/19.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

import Foundation

class PHAnimation {
    
    //声明一个单例
    static let animation = PHAnimation.init()
    private init(){}
    
    func showTransformAnimation(view: UIView) {
        
        UIView.animate(withDuration: 0.3,animations: {
                        
            view.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        }) { (completion) in
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                 view.alpha = 1
                 view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    func hidderTransformAnimation(view: UIView) {
        
        UIView.animate(withDuration: 0.23,animations: {
            
            view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }) { (completion) in
            
            UIView.animate(withDuration: 0.23, delay: 0, options: .curveEaseInOut, animations: {
                
                view.alpha = 0
                view.transform = CGAffineTransform.init(scaleX: 0.4, y: 0.4)
            }, completion: nil)
        }
    }
}

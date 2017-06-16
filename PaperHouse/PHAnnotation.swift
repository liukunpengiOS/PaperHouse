//
//  PHAnnotations.swift
//  PaperHouse
//
//  Created by DRex on 2017/6/15.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

import Foundation
import Alamofire

class PHAnnotation {
    
    //构造方法
    init() {
        
    }
    //获取数据之后封装成MAPointAnnotation并存入数组并返回
    class func getAnnotationsFormServer() -> Array<MAPointAnnotation>{
        
        var annotations = [MAPointAnnotation]()
        let pointAnnotation1 = MAPointAnnotation()
        pointAnnotation1.coordinate = CLLocationCoordinate2DMake(34.7511, 113.70)
        let pointAnnotation2 = MAPointAnnotation()
        pointAnnotation2.coordinate = CLLocationCoordinate2DMake(34.761, 113.71)
        let pointAnnotation3 = MAPointAnnotation()
        pointAnnotation3.coordinate = CLLocationCoordinate2DMake(34.77, 113.75)
        let pointAnnotation4 = MAPointAnnotation()
        pointAnnotation4.coordinate = CLLocationCoordinate2DMake(34.78, 113.78)
        let pointAnnotation5 = MAPointAnnotation()
        pointAnnotation5.coordinate = CLLocationCoordinate2DMake(34.66, 113.73)
        annotations.append(pointAnnotation1)
        annotations.append(pointAnnotation2)
        annotations.append(pointAnnotation3)
        annotations.append(pointAnnotation4)
        annotations.append(pointAnnotation5)
//        Alamofire.request("https://api.500px.com/v1/photos", method: .get).responseJSON {
//            response in
//            guard let JSON = response.result.value else { return }
//            print("JSON: \(JSON)")
//    }
        return annotations
    }
}

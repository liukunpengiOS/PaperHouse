//
//  ViewController.swift
//  PaperHouse
//
//  Created by kunpeng on 2017/6/8.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MAMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configAMap()
    }
    
    func configAMap() {
        
        //配置地图
        AMapServices.shared().apiKey = "2ba78a45598f61481a5f9f6239452cc8"
        AMapServices.shared().enableHTTPS = true
        //显示地图
        let mapView = MAMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        
        let representation = MAUserLocationRepresentation()
        representation.showsAccuracyRing = false
        representation.showsHeadingIndicator = true
        representation.fillColor = UIColor.red
        representation.strokeColor = UIColor.blue
        representation.lineWidth = 2
        representation.image = UIImage(named:"Location")
        mapView.update(representation)
        self.view.addSubview(mapView)
    }
}


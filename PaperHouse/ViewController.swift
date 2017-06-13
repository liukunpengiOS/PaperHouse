//
//  ViewController.swift
//  PaperHouse
//
//  Created by kunpeng on 2017/6/8.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

import UIKit

let userAnnotationIdentifer = "UserAnnotationIdentifer" //用户大头针复用标识

class ViewController: UIViewController {
    
    var mapView: MAMapView!
    var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configMAMapView()
        configLocationButton()
    }
    
  private  func configMAMapView() {
    
        //显示地图
        let mapRect = CGRect(x: 0, y: 64, width: view.bounds.size.width,
                                          height: view.bounds.size.height - 64)
        mapView = MAMapView(frame: mapRect)
        mapView.delegate = self
        mapView.zoomLevel = 18
        mapView.showsScale = false
        mapView.showsCompass = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        view.addSubview(mapView)
    }
    
    private  func configLocationButton () {
        
        locationButton = UIButton(frame: CGRect(x: 8, y: view.bounds.height - 68, width: 60, height: 60))
        locationButton.autoresizingMask = [UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin]
        locationButton.addTarget(self, action: #selector(actionLocation(sender:)), for: .touchUpInside)
        locationButton.setImage(UIImage(named:"nav_orientation"), for: .normal)
        locationButton.setImage(UIImage(named:"nav_orientation_highlight"), for: .highlighted)
        view.addSubview(locationButton)
    }
    
    @objc func actionLocation (sender: UIButton?) {
        
        if mapView.userTrackingMode == MAUserTrackingMode.follow {
            
            mapView.setUserTrackingMode(MAUserTrackingMode.none, animated: false)
        }else {
            
            mapView.setUserTrackingMode(MAUserTrackingMode.follow, animated: true)
        }
    }
}

extension ViewController: MAMapViewDelegate {
    //用户位置更新时
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        //获取大头针视图
        guard let userView = mapView.view(for: userLocation) else {
            return
        }
        //获取方向信息
        guard let userHeading = userLocation.heading else {
            return
        }
        //根据放心旋转箭头
        userView.rotateWithHeading(heading: userHeading)
    }
    
    //返回大头针视图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation is MAUserLocation {
            var userView = mapView.dequeueReusableAnnotationView(withIdentifier: userAnnotationIdentifer)
            if userView == nil {
                userView = MAAnnotationView(annotation: annotation,reuseIdentifier: userAnnotationIdentifer)
            }
            userView?.image = UIImage(named: "userPosition")
            return userView
        }
        return nil
    }
}

//MAAnnotationView扩展
extension MAAnnotationView {
    
    //根据heading信息旋转大头针视图
    //Parameter headding: 方向信息
    func rotateWithHeading (heading: CLHeading) {
        //将设备方向角度换算成弧度
        let headings = .pi * heading.magneticHeading / 180
        //创建不断旋转CALayer的transform属性的动画
        let rotateAnimation = CABasicAnimation(keyPath: "transform")
        //动画起始值
        let formValue = self.layer.transform
        rotateAnimation.fromValue = NSValue(caTransform3D: formValue)
        //绕z轴旋转heading弧度的变换矩阵
        let toValue = CATransform3DMakeRotation(CGFloat(headings), 0, 0, 1)
        //设置动画结束值
        rotateAnimation.toValue = NSValue(caTransform3D:toValue)
        rotateAnimation.duration = 0.35
        rotateAnimation.isRemovedOnCompletion = true
        //设置动画结束后的变换矩阵
        self.layer.transform = toValue
        //添加动画
        self.layer.add(rotateAnimation, forKey: nil)
    }
}


























//
//  ViewController.swift
//  PaperHouse
//
//  Created by kunpeng on 2017/6/8.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

import UIKit

let userAnnotationIdentifer = "UserAnnotationIdentifer" //用户大头针复用标识
let pointAnnotationIdentifier = "PointAnnotationIdentifier" //poi标注复用标识

class ViewController: UIViewController {
    
    var mapView: MAMapView!
    var locationButton: UIButton!
    var createPaperButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configElements()
    }
    
    //MARK: Config Elements
    private func configElements () {
        
        configMAMapView()
        configLocationButton()
        configPointAnnotations()
        configCreatePaperButton()
    }
    
    private func configMAMapView() {
        
        let mapRect = CGRect(x: 0, y: 64, width: view.bounds.size.width,
                                          height: view.bounds.size.height - 64)
        mapView = MAMapView(frame: mapRect)
        mapView.delegate = self
        mapView.zoomLevel = 12.5
        mapView.showsScale = false
        mapView.showsCompass = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        view.addSubview(mapView)
    }
    
    private func configPointAnnotations () {
        
        let annotations = PHAnnotation.getAnnotationsFormServer()
        mapView.addAnnotations(annotations)
    }
    
    private func configLocationButton () {
        
        locationButton = UIButton(frame: CGRect(x: 8, y: 68, width: 60, height: 60))
        locationButton.autoresizingMask = [UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin]
        locationButton.addTarget(self, action: #selector(actionLocation(sender:)), for: .touchUpInside)
        locationButton.setImage(UIImage(named:"nav_orientation"), for: .normal)
        locationButton.setImage(UIImage(named:"nav_orientation_highlight"), for: .highlighted)
        view.addSubview(locationButton)
    }
    
    private func configCreatePaperButton () {
        
        createPaperButton = UIButton(type: .system)
        createPaperButton.addTarget(self, action: #selector(createPaperAction(sender:)), for: .touchUpInside)
        createPaperButton.setTitle("写", for: .normal)
        createPaperButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        createPaperButton.backgroundColor = UIColor.purple
        createPaperButton.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(createPaperButton)
        
        createPaperButton.mas_makeConstraints { (make) in
            
            make?.bottom.offset()(-10)
            make?.left.offset()((SCREEN_WIDTH - 50)/2)
            make?.width.height().offset()(50)
        }
    }
    
    //MARK:Actions
    @objc func actionLocation (sender: UIButton?) {
        
        if mapView.userTrackingMode == MAUserTrackingMode.follow {
            
            mapView.setUserTrackingMode(MAUserTrackingMode.none, animated: false)
        }else {
            
            mapView.setUserTrackingMode(MAUserTrackingMode.follow, animated: true)
        }
    }
    
    @objc func createPaperAction (sender: UIButton?) {
        
    }
}

//MARK: Extensions
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
        if annotation is MAPointAnnotation {
            var pointView = mapView.dequeueReusableAnnotationView(withIdentifier: pointAnnotationIdentifier)
            if pointView == nil {
                pointView = MAAnnotationView(annotation: annotation,reuseIdentifier:pointAnnotationIdentifier)
            }
            pointView?.image = UIImage(named: "car")
            return pointView
        }
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        
        let bounceKeyFrameAnimation = CAKeyframeAnimation();
        bounceKeyFrameAnimation.keyPath = "position";
        bounceKeyFrameAnimation.duration = 0.5;
//        bounceKeyFrameAnimation.values = [YXEasing.calculateFrame(from: CGPoint(x:10,y:10),
//                                                                 to: CGPoint(x:20,y:20),
//                                                                 func: QuarticEaseInOut(0),
//                                                                 frameCount: 0.5 * 30)]
        
//        _shareView.center = CGPointMake(CGRectGetWidth(_shareView.frame)/2,Y);
//        [_shareView.layer addAnimation:bounceKeyFrameAmation forKey:nil];
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


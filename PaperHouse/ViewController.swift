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
    var paperPreview: PHPaperPreview!
    var locationButton: UIButton!
    var paperButton: UIButton!
    var fromPoint: CGPoint!
    var toPoint: CGPoint!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        fromPoint = CGPoint(x:(SCREEN_WIDTH - 50)/2 + 25,y:(SCREEN_HEIGHT - 35))
        toPoint = CGPoint(x:35,y:(SCREEN_HEIGHT - 35))
        configElements()
    }
    
    //MARK: Config Elements
    private func configElements () {
        
        configMAMapView()
        configLocationButton()
        configPointAnnotations()
        configPaperButton()
        configPaperPreview()
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
    
    private func configPaperButton () {
        
        let size = CGSize(width: 60, height: 60)
        let center = CGPoint(x:(SCREEN_WIDTH - 50)/2 + 25,y:(SCREEN_HEIGHT - 35))
        paperButton = UIButton(type: .system)
        paperButton.frame.size = size
        paperButton.center = center
        paperButton.addTarget(self, action: #selector(createPaperAction(sender:)), for: .touchUpInside)
        paperButton.setTitle("写", for: .normal)
        paperButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        paperButton.backgroundColor = UIColor.purple
        paperButton.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(paperButton)
    }
    
    private func configPaperPreview() {
        
        let frame = CGRect(x: 70, y: SCREEN_HEIGHT - 65, width: SCREEN_WIDTH - 75, height: 60)
        paperPreview = PHPaperPreview(frame: frame)
        paperPreview.alpha = 0
        paperPreview.backgroundColor = UIColor.purple
        view.addSubview(paperPreview)
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
    
    func mapView(_ mapView: MAMapView!, didSingleTappedAt coordinate: CLLocationCoordinate2D) {
        
        paperButtonAnimation(fromPoint: toPoint, toPoint: fromPoint)
        PHAnimation.animation.hidderTransformAnimation(view: paperPreview)
    }
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        
        paperButtonAnimation(fromPoint: fromPoint, toPoint: toPoint)
        PHAnimation.animation.showTransformAnimation(view: paperPreview)
    }
    
    func paperButtonAnimation(fromPoint: CGPoint,toPoint: CGPoint) {
        
        let duration = 0.25
        let easingValue          = EasingValue(withFunction: EasingFunction.sineEaseInOut, frameCount: Int(duration * 30.0))
        let keyAnimation         = CAKeyframeAnimation(keyPath: "position")
        keyAnimation.duration    = duration
        keyAnimation.values      = easingValue.pointValueWith(fromPoint: fromPoint, toPoint: toPoint)
        paperButton.center = toPoint
        paperButton.layer.add(keyAnimation, forKey: nil)
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


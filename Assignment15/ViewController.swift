//
//  ViewController.swift
//  Assignment15
//
//  Created by macbook  on 13.06.23.
//

import UIKit

class ViewController: UIViewController {
    
    var item: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBox()
    }
    
    func createBox() {
        let center = self.view.center
        item = UIView(frame: CGRect(
            x: center.x - 25,
            y: center.y - 25,
            width: 50,
            height: 50
        ))
        item?.backgroundColor = .red
        item?.isUserInteractionEnabled = true
        item?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        self.view.addSubview(item!)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        if let view = gesture.view {
            let translation = gesture.translation(in: view)
            view.center = CGPoint(
                x: view.center.x + translation.x,
                y: view.center.y + translation.y
            )
        
            gesture.setTranslation(CGPoint.zero, in: view)
        
            if gesture.state == .ended {
                itemWasPlaced(view)
            }
        }
    }
    
    func itemWasPlaced(_ view: UIView) {
        let center = self.view.center
        if view.center.y < center.y {
            if view.center.x < center.x {
                itemWasPlacedInTopLeft(view)
            } else {
                itemWasPlacedInTopRight(view)
            }
        } else {
            if view.center.x < center.x {
                itemWasPlacedInBottomLeft(view)
            } else {
                itemWasPlacedInBottomRight(view)
            }
        }
    }
    
    func itemWasPlacedInTopLeft(_ view: UIView) {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = CGFloat.pi
        animation.duration = 0.5
        
        view.layer.add(animation, forKey: "basic")
    }
    
    func itemWasPlacedInTopRight(_ view: UIView) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [1, 0.6, 1.8, 1]
        animation.keyTimes = [0, 0.2, 0.7, 1]
        animation.duration = 0.5
        
        view.layer.add(animation, forKey: "scale")
    }
    
    func itemWasPlacedInBottomLeft(_ view: UIView) {
        let animation = CABasicAnimation()
        animation.keyPath = "opacity"
        animation.fromValue = 1
        animation.toValue = 0
        animation.autoreverses = true
        
        view.layer.add(animation, forKey: "opacity")
    }
    
    func itemWasPlacedInBottomRight(_ view: UIView) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, -3, 0, 3, 0]
        animation.repeatCount = 5
        animation.duration = 0.1
        animation.isAdditive = true
        
        view.layer.add(animation, forKey: "shake")
    }
}


//
//  ViewController.swift
//  LinkedinPostReactAnimation
//
//  Created by Kadir Hocaoğlu on 3.09.2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UI Elements
    let bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "linkedinScreen") )
        return imageView
    }()
    
    let iconContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .red
        containerView.frame = CGRect(x: 0 , y: 0, width: 120, height: 40)
        
        return containerView
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(bgImageView)
        bgImageView.frame = view.frame
        setupLongPressGesture()
    }
    
    // MARK: - Properties
    override var prefersStatusBarHidden: Bool { return true }
    
    
    // MARK: - Functions
    
    fileprivate func setupLongPressGesture() {
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handLongpress)))
    }
    @objc func handLongpress(gesture: UILongPressGestureRecognizer) {
        print("Long Press", Date())
        if gesture.state == .began {
            view.addSubview(iconContainerView)
            let pressedLocation = gesture.location(in: self.view)
            iconConteinerAlphaAnimated(pressedLocation: pressedLocation)
        }else if gesture.state == .ended {
            iconContainerView.removeFromSuperview()
        }
    }
    func iconConteinerAlphaAnimated(pressedLocation: CGPoint) {
        iconContainerView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let centeredX = (self.view.frame.width - self.iconContainerView.frame.width)/2
            self.iconContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconContainerView.frame.height)
            self.iconContainerView.alpha = 1
        })
    }
    
    // MARK: - Actions

}


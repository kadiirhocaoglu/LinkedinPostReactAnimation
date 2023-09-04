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
        //MARK: - Elements
        let containerView = UIView()
      
        //MARK: - Constants
        let imageViewHeight: CGFloat = 35
        let imageViewWidth: CGFloat = 35
        let padding: CGFloat =  8
        let images = ["Linkedin-Like", "Linkedin-Celebrate", "Linkedin-Support", "Linkedin-Love", "Linkedin-Insightful", "linkedin-funny"]
        
        let arrangedSubviews = images.map({ (imageName) -> UIImageView in
            let i = UIImageView(image: UIImage(named: imageName))
            i.layer.cornerRadius = imageViewHeight / 2
            i.isUserInteractionEnabled = true
            return i
        })
        let numIcons = CGFloat(arrangedSubviews.count)
        let containerViewWitdh: CGFloat = numIcons * imageViewWidth + (numIcons + 1) * padding
        let containerViewHeight: CGFloat = imageViewHeight + 2 * padding
        
        //MARK: - Properties
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        containerView.backgroundColor = .white
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        containerView.addSubview(stackView)
        containerView.frame = CGRect(x: 0 , y: 0, width: containerViewWitdh, height: containerViewHeight)
        containerView.layer.cornerRadius = containerViewHeight / 5
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        stackView.frame = containerView.frame
        
        //MARK: - Return
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
        if gesture.state == .began {
            handleGestureBegan(gesture: gesture)
        }else if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut ,animations: {
                let stackView = self.iconContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                self.iconContainerView.transform = self.iconContainerView.transform.translatedBy(x: 0, y: 50)
                self.iconContainerView.alpha = 0
            }, completion: {(_) in
                self.iconContainerView.removeFromSuperview()
            })
        
                            
        }else if gesture.state == .changed{
            handleGestureChanged(gesture: gesture)
        }
    }

    fileprivate func handleGestureChanged(gesture: UILongPressGestureRecognizer){
        let pressedLocation = gesture.location(in: self.iconContainerView)
        
        let hitTestView = iconContainerView.hitTest(pressedLocation, with: nil)
        
        if hitTestView is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut ,animations: {
                let stackView = self.iconContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
            })
        }
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer){
        view.addSubview(iconContainerView)
        let pressedLocation = gesture.location(in: self.view)
        iconConteinerAlphaAnimated(pressedLocation: pressedLocation)
    }
    fileprivate func iconConteinerAlphaAnimated(pressedLocation: CGPoint) {
        let centeredX = (self.view.frame.width - self.iconContainerView.frame.width)/2
        iconContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        iconContainerView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconContainerView.frame.height)
            self.iconContainerView.alpha = 1
        })
    }
    // MARK: - Actions

}


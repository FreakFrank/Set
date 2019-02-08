//
//  Extensions.swift
//  Set
//
//  Created by Kareem Ismail on 2/5/19.
//  Copyright © 2019 Whatever. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125.0, y: self.view.frame.size.height/2.0-17.5, width: 250, height: 55))
        toastLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 25.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


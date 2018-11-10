//
//  UITextField+Utils.swift
//  RxLogin
//
//  Created by Aline Borges on 10/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit

extension UITextField {
    func setPadding(_ width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

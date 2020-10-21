//
//  UIViewExtension.swift
//  BeatyFile(ios)
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
public class RoundedUIView: UIView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth=1
        self.layer.cornerRadius = 5.0
//        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 255/255.0, green: 111/255.0, blue: 169/255.0, alpha: 1).cgColor
    }

}


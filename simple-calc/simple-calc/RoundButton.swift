//
//  RoundButton.swift
//  simple-calc
//
//  Created by Andre Nguyen on 1/28/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var roundButton:Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}

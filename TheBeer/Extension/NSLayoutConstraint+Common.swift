//
//  NSLayoutConstraint.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
  @IBInspectable var pixelConstant: Int {
    get {
      return Int(constant * UIScreen.main.scale)
    }
    set {
      constant = CGFloat(newValue) / UIScreen.main.scale
    }
  }
}


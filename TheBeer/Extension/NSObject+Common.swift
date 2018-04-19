//
//  NSObject+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

extension NSObject {
  class var className: String {
    return String(describing: self)
  }
  
  var className: String {
    return type(of: self).className
  }
}

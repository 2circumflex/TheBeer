//
//  FloatingPoint+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

extension FloatingPoint {
  var isInt: Bool {
    return floor(self) == self
  }
}

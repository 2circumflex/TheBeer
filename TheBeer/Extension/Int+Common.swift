//
//  Int+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

extension Int {
  func currencyFormatString() -> String {
    let num = NSNumber(value: self as Int)
    return NumberFormatter.localizedString(from: num, number: NumberFormatter.Style.decimal)
  }
  
  func bool() -> Bool {
    switch self {
    case 1:
      return true
    case 0:
      return false
    default:
      return true
    }
  }
}

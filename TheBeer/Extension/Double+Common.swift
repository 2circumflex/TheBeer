//
//  Double+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

extension Double {
  func currencyFormatString() -> String {
    let num = NSNumber(value: Int(self) as Int)
    return NumberFormatter.localizedString(from: num, number: NumberFormatter.Style.decimal)
  }
}

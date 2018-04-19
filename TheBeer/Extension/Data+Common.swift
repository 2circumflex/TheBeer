//
//  Data+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

extension Data {
  var hexString: String {
    return map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
  }
}

//
//  Bool+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

extension Bool {
  func upperCaseYN() -> String {
    if self {
      return "Y"
    } else {
      return "N"
    }
  }
  
  func lowerCaseYN() -> String {
    if self {
      return "y"
    } else {
      return "n"
    }
  }
  
  func int() -> Int {
    if self {
      return 1
    }
    return 0
  }
}

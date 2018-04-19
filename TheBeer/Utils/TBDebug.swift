//
//  TBDebug.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

class TBDebug {
  private struct Args: CustomStringConvertible, CustomDebugStringConvertible {
    let args: [Any]
    let separator: String
    var description: String {
      return args.map { "\($0)" }.joined(separator: separator)
    }
    var debugDescription: String {
      return args
        .map { ($0 as? CustomDebugStringConvertible)?.debugDescription ?? "\($0)" }
        .joined(separator: separator)
    }
  }
  
  class func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
      Swift.print(Args(args: items, separator: separator), separator: separator, terminator: terminator)
    #endif
  }
  
  class func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
      Swift.debugPrint(Args(args: items, separator: separator), separator: separator, terminator: terminator)
    #endif
  }
  
  class func dump<T>(_ value: T, name: String? = nil, indent: Int = 0, maxDepth: Int = Int.max, maxItems: Int = Int.max) -> T {
    #if DEBUG
      return Swift.dump(value, name: name, indent: indent, maxDepth: maxDepth, maxItems: maxItems)
    #else
      return value
    #endif
  }
}

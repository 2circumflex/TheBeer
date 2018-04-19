//
//  EnumCollectionProtocol.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

public protocol EnumCollectionProtocol: Hashable {
  static func cases() -> AnySequence<Self>
  static var allValues: [Self] { get }
}

public extension EnumCollectionProtocol {
  
  public static func cases() -> AnySequence<Self> {
    return AnySequence { () -> AnyIterator<Self> in
      var raw = 0
      return AnyIterator {
        let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
        guard current.hashValue == raw else {
          return nil
        }
        raw += 1
        return current
      }
    }
  }
  
  public static var allValues: [Self] {
    return Array(self.cases())
  }
}

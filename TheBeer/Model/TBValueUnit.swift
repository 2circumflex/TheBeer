//
//  TBValueUnit.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

import ObjectMapper

struct TBValueUnit: ImmutableMappable {
  let value: Double
  let unit: String
  
  init(map: Map) throws {
    self.value = try map.value("value")
    self.unit = try map.value("unit")
  }
}

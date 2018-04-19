//
//  TBHop.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

import ObjectMapper

struct TBHop: ImmutableMappable {
  let name: String
  let amount: TBValueUnit
  let add: String
  let attribute: String
  
  init(map: Map) throws {
    self.name = try map.value("name")
    self.amount = try map.value("amount")
    self.add = try map.value("add")
    self.attribute = try map.value("attribute")
  }
}

//
//  TBMalt.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

import ObjectMapper

struct TBMalt: ImmutableMappable {
  let name: String
  let amount: TBValueUnit
  
  init(map: Map) throws {
    self.name = try map.value("name")
    self.amount = try map.value("amount")
  }
}

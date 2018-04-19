//
//  TBFermentation.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

import ObjectMapper

struct TBFermentation: ImmutableMappable {
  let temperature: TBValueUnit
  
  init(map: Map) throws {
    self.temperature = try map.value("temp")
  }
}

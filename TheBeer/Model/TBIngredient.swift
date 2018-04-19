//
//  TBIngredient.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

import ObjectMapper

struct TBIngredient: ImmutableMappable {
  let malt: [TBMalt]?
  let hops: [TBHop]?
  let yeast: String?
  
  init(map: Map) throws {
    self.malt = try? map.value("malt")
    self.hops = try? map.value("hops")
    self.yeast = try? map.value("yeast")
  }
}

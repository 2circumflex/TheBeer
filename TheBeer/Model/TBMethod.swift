//
//  TBMethod.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

import ObjectMapper

struct TBMethod: ImmutableMappable {
  let mashTemp: [TBMashTemperature]
  let fermentation: TBFermentation
  let twist: String?
  
  init(map: Map) throws {
    self.mashTemp = try map.value("mash_temp")
    self.fermentation = try map.value("fermentation")
    self.twist = try map.value("twist")
  }
}

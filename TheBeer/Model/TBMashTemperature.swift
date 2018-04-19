//
//  TBMashTemperature.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

import ObjectMapper

struct TBMashTemperature: ImmutableMappable {
  let temperature: TBValueUnit
  let duration: Int?
  
  init(map: Map) throws {
    self.temperature = try map.value("temp")
    self.duration = try? map.value("duration")
  }
}

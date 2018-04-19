//
//  TBBeer.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

import ObjectMapper

struct TBBeer: ImmutableMappable {
  let id: Int
  let name: String
  let tagline: String
  let firstBrewed: Date?
  let description: String
  let imageUrl: String
  let abv: Double
  let ibu: Int
  let targetFg: Int
  let targetOg: Int
  let ebc: Int
  let srm: Int
  let ph: Double
  let attenuationLevel: Int
  let volume: TBValueUnit
  let boilVolume: TBValueUnit
  let method: TBMethod
  let ingredients: TBIngredient
  let foodPairing: [String]
  let brewersTips: String
  let contributedBy: String
  
  init(map: Map) throws {
    self.id = try map.value("id")
    self.name = try map.value("name")
    self.tagline = try map.value("tagline")
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "mm/yyyy"
    dateFormatter.timeZone = NSTimeZone.system
    let firstBrewedString: String = try map.value("first_brewed")
    self.firstBrewed = dateFormatter.date(from: firstBrewedString)
    
    self.description = try map.value("description")
    self.imageUrl = try map.value("image_url")
    self.abv = try map.value("abv")
    self.ibu = try map.value("ibu")
    self.targetFg = try map.value("target_fg")
    self.targetOg = try map.value("target_og")
    self.ebc = try map.value("ebc")
    self.srm = try map.value("srm")
    self.ph = try map.value("ph")
    self.attenuationLevel = try map.value("attenuation_level")
    self.volume = try map.value("volume")
    self.boilVolume = try map.value("boil_volume")
    self.method = try map.value("method")
    self.ingredients = try map.value("ingredients")
    self.foodPairing = try map.value("food_pairing")
    self.brewersTips = try map.value("brewers_tips")
    self.contributedBy = try map.value("contributed_by")
  }
}

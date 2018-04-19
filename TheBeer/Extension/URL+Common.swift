//
//  NSURL+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

extension URL {
  var queryItems: [String: String]? {
    var params = [String: String]()
    return URLComponents(url: self, resolvingAgainstBaseURL: false)?
      .queryItems?
      .reduce([:], { (_, item) -> [String: String] in
        params[item.name] = item.value
        return params
      })
  }
}

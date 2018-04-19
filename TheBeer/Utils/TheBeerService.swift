//
//  TheBeerService.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Moya

enum TheBeerService {
  case beer(id: Int)
  case beers(pagination: Pagination?, param: Param?)
  case random
}

extension TheBeerService {
  
  typealias BeerId = Int
  
  enum Constant {
    static let defaultLimit = 25
  }
  
  enum ResponseCode {
    static let success = 200
    static let errorNotFound = 404
    static let errorUnknown = 500
  }
  
  struct Pagination {
    let page: Int
    let perPage: Int
  }
  
  struct Param {
    var abvGreaterThan: Double?
    var abvLessThan: Double?
    var ibuGreaterThan: Int?
    var ibuLessThan: Int?
    var ebcGreaterThan: Int?
    var ebcLessThan: Int?
    var beerName: String?
    var yeast: String?
    var brewedBefore: Date?
    var brewedAfter: Date?
    var hops: String?
    var malt: String?
    var food: String?
    var ids: [BeerId]?
  }
}

extension TheBeerService: TargetType {
  var baseURL: URL {
    return URL(string: TBConstant.API.requestHostForProduction)!
  }
  
  var path: String {
    switch self {
    case let .beer(id):
      return "/beers/\(id)"
    case let .beers(pagination, param):
      let parameterString = self.beersParameters(pagination: pagination, param: param)
      return "/beers?\(parameterString)"
    case .random:
      return "/beers/random"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .beer, .beers, .random:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case .beer, .beers, .random:
      return .requestPlain
    }
  }
  
  var sampleData: Data {
    guard let file = Bundle.main.path(forResource: "beers", ofType: "json") else {
      return "".utf8Encoded
    }
    return file.utf8Encoded
  }
  
  var headers: [String : String]? {
    switch self {
    case .beer, .beers, .random:
      return nil
    }
  }
  
  private func beersParameters(pagination: Pagination?, param: Param?) -> String {
    var parameters: [String] = []
    
    if let pagination = pagination {
      parameters.append("page=\(pagination.page)")
      parameters.append("per_page=\(pagination.perPage)")
    }
    
    if let param = param {
      if let abvGreaterThan = param.abvGreaterThan {
        parameters.append("abv_gt=\(abvGreaterThan)")
      }
      if let abvLessThan = param.abvLessThan {
        parameters.append("abv_lt=\(abvLessThan)")
      }
      if let ibuGreaterThan = param.ibuGreaterThan {
        parameters.append("ibu_gt=\(ibuGreaterThan)")
      }
      if let ibuLessThan = param.ibuLessThan {
        parameters.append("ibu_lt=\(ibuLessThan)")
      }
      if let ebcGreaterThan = param.ebcGreaterThan {
        parameters.append("ebc_gt=\(ebcGreaterThan)")
      }
      if let ebcLessThan = param.ebcLessThan {
        parameters.append("ebc_lt=\(ebcLessThan)")
      }
      
      if let beerName = param.beerName {
        let beerNameString = beerName.replace(target: " ", withString: "_")
        parameters.append("beer_name=\(beerNameString)")
      }
      if let yeast = param.yeast {
        let yeastString = yeast.replace(target: " ", withString: "_")
        parameters.append("yeast=\(yeastString)")
      }
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "mm-yyyy"
      dateFormatter.timeZone = NSTimeZone.system
      if let brewedBefore = param.brewedBefore {
        let brewedBeforeString = dateFormatter.string(from: brewedBefore)
        parameters.append("brewed_before=\(brewedBeforeString)")
      }
      if let brewedAfter = param.brewedAfter {
        let brewedAfterString = dateFormatter.string(from: brewedAfter)
        parameters.append("brewed_after=\(brewedAfterString)")
      }
      
      if let hops = param.hops {
        let hopsString = hops.replace(target: " ", withString: "_")
        parameters.append("hops=\(hopsString)")
      }
      if let malt = param.malt {
        let maltString = malt.replace(target: " ", withString: "_")
        parameters.append("malt=\(maltString)")
      }
      if let food = param.food {
        let foodString = food.replace(target: " ", withString: "_")
        parameters.append("food=\(foodString)")
      }
      
      if let ids = param.ids {
        let value = ids.map({ String($0) }).joined(separator: "|")
        parameters.append("ids=\(value)")
      }
    }
    
    return parameters.joined(separator: "&")
  }
}

private extension String {
  var urlEscaped: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return self.data(using: .utf8)!
  }
}

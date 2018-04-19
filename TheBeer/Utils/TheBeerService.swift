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
    case .beers:
      return "/beers"
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
    case .beer, .random:
      return .requestPlain
    case let .beers(pagination, param):
      var parameters = [String: Any]()
      
      if let pagination = pagination {
        parameters["page"] = pagination.page
        parameters["per_page"] = pagination.perPage
      }
      
      if let param = param {
        if let abvGreaterThan = param.abvGreaterThan {
          parameters["abv_gt"] = abvGreaterThan
        }
        if let abvLessThan = param.abvLessThan {
          parameters["abv_lt"] = abvLessThan
        }
        if let ibuGreaterThan = param.ibuGreaterThan {
          parameters["ibu_gt"] = ibuGreaterThan
        }
        if let ibuLessThan = param.ibuLessThan {
          parameters["ibu_lt"] = ibuLessThan
        }
        if let ebcGreaterThan = param.ebcGreaterThan {
          parameters["ebc_gt"] = ebcGreaterThan
        }
        if let ebcLessThan = param.ebcLessThan {
          parameters["ebc_lt"] = ebcLessThan
        }
        
        if let beerName = param.beerName {
          let beerNameString = beerName.replace(target: " ", withString: "_")
          parameters["beer_name"] = beerNameString
        }
        if let yeast = param.yeast {
          let yeastString = yeast.replace(target: " ", withString: "_")
          parameters["yeast"] = yeastString
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm-yyyy"
        dateFormatter.timeZone = NSTimeZone.system
        if let brewedBefore = param.brewedBefore {
          let brewedBeforeString = dateFormatter.string(from: brewedBefore)
          parameters["brewed_before"] = brewedBeforeString
        }
        if let brewedAfter = param.brewedAfter {
          let brewedAfterString = dateFormatter.string(from: brewedAfter)
          parameters["brewed_after"] = brewedAfterString
        }
        
        if let hops = param.hops {
          let hopsString = hops.replace(target: " ", withString: "_")
          parameters["hops"] = hopsString
        }
        if let malt = param.malt {
          let maltString = malt.replace(target: " ", withString: "_")
          parameters["malt"] = maltString
        }
        if let food = param.food {
          let foodString = food.replace(target: " ", withString: "_")
          parameters["food"] = foodString
        }
        
        if let ids = param.ids {
          let value = ids.map({ String($0) }).joined(separator: "|")
          parameters["ids"] = value
        }
      }
      
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
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
}

private extension String {
  var urlEscaped: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return self.data(using: .utf8)!
  }
}

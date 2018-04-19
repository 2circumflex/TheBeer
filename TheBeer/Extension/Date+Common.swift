//
//  Date+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import Foundation

extension NSDate: Comparable {}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs as Date) == .orderedAscending
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs as Date) == .orderedDescending
}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs as Date) == .orderedSame
}

extension Date {
  
  static let defaultDateStringFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
  
  enum Time: TimeInterval {
    case second = 1
    case minute = 60
    case hour = 3600
    case day = 86400
    case week = 604800
  }
  
  public func getMinute() -> Int {
    return (Calendar.current as NSCalendar).component(.minute, from: self)
  }
  
  public func getHour() -> Int {
    return (Calendar.current as NSCalendar).component(.hour, from: self)
  }
  
  public func getDay() -> Int {
    return (Calendar.current as NSCalendar).component(.day, from: self)
  }
  
  public func added(second: Double) -> Date {
    return self.addingTimeInterval(second * Time.second.rawValue)
  }
  
  public func added(minute: Double) -> Date {
    return self.addingTimeInterval(minute * Time.minute.rawValue)
  }
  
  public func added(hour: Double) -> Date {
    return self.addingTimeInterval(hour * Time.hour.rawValue)
  }
  
  public func added(day: Double) -> Date {
    return self.addingTimeInterval(day * Time.day.rawValue)
  }
  
  public func added(week: Double) -> Date {
    return self.addingTimeInterval(week * Time.week.rawValue)
  }
  
  func dateString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Date.defaultDateStringFormat
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    return dateFormatter.string(from: self)
  }
}

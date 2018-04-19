//
//  String+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import UIKit

extension String {
  
  static let defaultDateStringFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
  
  func replace(target: String, withString: String) -> String {
    return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
  }
  
  var isEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
  
  var isHangul: Bool {
    let hangulRegEx = "^[ㄱ-ㅣ가-힣]*$"
    let hangulTest = NSPredicate(format:"SELF MATCHES %@", hangulRegEx)
    return hangulTest.evaluate(with: self)
  }
  
  var isEnglish: Bool {
    let englishRegEx = "^[a-zA-Z]*$"
    let englishTest = NSPredicate(format:"SELF MATCHES %@", englishRegEx)
    return englishTest.evaluate(with: self)
  }
  
  var isNumber: Bool {
    let numberRegEx = "^[0-9]*$"
    let numberTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
    return numberTest.evaluate(with: self)
  }
  
  func currencyFormatString() -> String {
    guard let intNum = Int(self) else {
      return ""
    }
    let num = NSNumber(value: intNum)
    return NumberFormatter.localizedString(from: num, number: NumberFormatter.Style.decimal)
  }
  
  func bool() -> Bool {
    switch self {
    case "True", "true", "yes", "1", "Y", "y":
      return true
    case "False", "false", "no", "0", "N", "n":
      return false
    default:
      return false
    }
  }
  
  func date() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = String.defaultDateStringFormat
    guard let gmtDate = dateFormatter.date(from: self) else {
      return nil
    }
    let localDate = Date(timeInterval: TimeInterval(NSTimeZone.system.secondsFromGMT()), since: gmtDate)
    return localDate
  }
  
  func size(with font: UIFont) -> CGSize {
    let attributes = [NSAttributedStringKey.font: font]
    let string = self as NSString
    return string.size(withAttributes: attributes)
  }
}

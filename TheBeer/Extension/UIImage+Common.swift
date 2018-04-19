//
//  UIImage+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import UIKit

public extension UIImage {
  convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.init(cgImage: (image?.cgImage!)!)
  }
}

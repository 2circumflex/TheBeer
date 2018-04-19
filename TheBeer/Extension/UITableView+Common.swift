//
//  UITableView+Common.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import UIKit

extension UITableView {
  func registerCell<T: UITableViewCell>(_ type: T.Type) {
    let className = type.className
    let nib = UINib(nibName: className, bundle: nil)
    register(nib, forCellReuseIdentifier: className)
  }
  
  func registerCells<T: UITableViewCell>(_ types: [T.Type]) {
    types.forEach { registerCell($0) }
  }
  
  func dequeueCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
  }
}

//
//  TBProgressHUD.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import UIKit

extension TBProgressHUD {
  
  enum Color {
    static let activityIndicatorView = UIColor(red: 1.0, green: 0.502, blue: 0.149, alpha: 1)
    static let background = UIColor.black.withAlphaComponent(0.3)
  }
}

class TBProgressHUD: UIView {
  
  let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
  
  // MARK: - View lifecycle
  
  deinit {
    TBDebug.print("\(self.className) deinitialization")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initializeView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializeView()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.activityIndicatorView.center = self.center
  }
  
  // MARK: - Private Function
  
  private func initializeView() {
    self.isUserInteractionEnabled = true
    self.backgroundColor = Color.background
    
    self.activityIndicatorView.color = Color.activityIndicatorView
    self.activityIndicatorView.startAnimating()
    self.addSubview(self.activityIndicatorView)
  }
  
  // MARK: - Internal Function
  
  // MARK: - Public Function
  
  // MARK: - IBAction
}

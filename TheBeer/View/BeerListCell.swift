//
//  BeerListCell.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import UIKit

class BeerListCell: UITableViewCell {
  
  @IBOutlet weak var beerImageView: UIImageView!
  @IBOutlet weak var beerNameLabel: UILabel!
  @IBOutlet weak var beerAbvLabel: UILabel!
  @IBOutlet weak var beerDescriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.beerImageView.image = nil
    self.beerNameLabel.text = "-"
    self.beerAbvLabel.text = "-"
    self.beerDescriptionLabel.text = "-"
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

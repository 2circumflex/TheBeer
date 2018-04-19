//
//  BeerDetailViewController.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import UIKit

import AlamofireImage

extension BeerDetailViewController {
  
  enum BeerDetailType: EnumCollectionProtocol {
    case name
    case tagline
    case firstBrewed
    case description
    case abv
    case ibu
    case srm
    case volume
    case boilVolume
    case malt
    case hops
    case yeast
    case foodPairing
    case brewersTips
    case contributedBy
  }
  
  enum Constant {
    static let sectionHeaderHeight: CGFloat = 200.0
    static let sectionFooterHeight: CGFloat = 0.01
    static let estimatedRowHeight: CGFloat = 100.0
  }
  
  enum Color {
    static let separatorColor = UIColor.clear
  }
}

class BeerDetailViewController: UIViewController {
  
  let beer: TBBeer
  let firstBrewedDateFormatter: DateFormatter = {
    let firstBrewedDateFormatter = DateFormatter()
    firstBrewedDateFormatter.dateFormat = "yyyy-mm"
    return firstBrewedDateFormatter
  }()
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - View lifecycle
  
  deinit {
    TBDebug.print("\(self.className) deinitialization")
  }
  
  required init(beer: TBBeer) {
    self.beer = beer
    super.init(nibName: BeerDetailViewController.className, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.initializeView()
  }
  
  // MARK: - Private Function
  
  private func initializeView() {
    self.navigationItem.title = NSLocalizedString("beer_detail_navigation_title", comment: "")
    
    let headerNib = UINib(nibName: BeerDetailHeaderView.className, bundle: nil)
    self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: BeerDetailHeaderView.className)
    self.tableView.registerCell(BeerDetailCell.self)
    self.tableView.separatorColor = Color.separatorColor
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = Constant.estimatedRowHeight
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  private func beerDetailCellTitle(from beerDetailType: BeerDetailType) -> String {
    switch beerDetailType {
    case .name:
      return NSLocalizedString("beer_detail_name", comment: "")
    case .tagline:
      return NSLocalizedString("beer_detail_tagline", comment: "")
    case .firstBrewed:
      return NSLocalizedString("beer_detail_firstBrewed", comment: "")
    case .description:
      return NSLocalizedString("beer_detail_description", comment: "")
    case .abv:
      return NSLocalizedString("beer_detail_abv", comment: "")
    case .ibu:
      return NSLocalizedString("beer_detail_ibu", comment: "")
    case .srm:
      return NSLocalizedString("beer_detail_srm", comment: "")
    case .volume:
      return NSLocalizedString("beer_detail_volume", comment: "")
    case .boilVolume:
      return NSLocalizedString("beer_detail_boilVolume", comment: "")
    case .malt:
      return NSLocalizedString("beer_detail_malt", comment: "")
    case .hops:
      return NSLocalizedString("beer_detail_hops", comment: "")
    case .yeast:
      return NSLocalizedString("beer_detail_yeast", comment: "")
    case .foodPairing:
      return NSLocalizedString("beer_detail_foodPairing", comment: "")
    case .brewersTips:
      return NSLocalizedString("beer_detail_brewersTips", comment: "")
    case .contributedBy:
      return NSLocalizedString("beer_detail_contributedBy", comment: "")
    }
  }
  
  private func beerDetailCellContent(from beerDetailType: BeerDetailType) -> String {
    let noInformationLocalizedString = NSLocalizedString("beer_detail_no_information", comment: "")
    switch beerDetailType {
    case .name:
      return self.beer.name
      
    case .tagline:
      return self.beer.tagline ?? noInformationLocalizedString
      
    case .firstBrewed:
      guard let firstBrewed = self.beer.firstBrewed else {
        return noInformationLocalizedString
      }
      return self.firstBrewedDateFormatter.string(from: firstBrewed)
      
    case .description:
      return self.beer.description ?? noInformationLocalizedString
      
    case .abv:
      guard let abv = self.beer.abv else {
        return noInformationLocalizedString
      }
      return String(abv)
      
    case .ibu:
      guard let ibu = self.beer.ibu else {
        return noInformationLocalizedString
      }
      return String(ibu)
      
    case .srm:
      guard let srm = self.beer.srm else {
        return noInformationLocalizedString
      }
      return String(srm)
      
    case .volume:
      guard let volume = self.beer.volume else {
        return noInformationLocalizedString
      }
      return "\(volume.value) \(volume.unit)"
      
    case .boilVolume:
      guard let boilVolume = self.beer.boilVolume else {
        return noInformationLocalizedString
      }
      return "\(boilVolume.value) \(boilVolume.unit)"
      
    case .malt:
      guard let maltList = self.beer.ingredients?.malt, maltList.count > 0 else {
        return noInformationLocalizedString
      }
      var contentList: [String] = []
      for malt in maltList {
        let contents = """
        \(malt.name)
        \(malt.amount.value) \(malt.amount.unit)
        """
        contentList.append(contents)
      }
      return contentList.joined(separator: "\n\n")
      
    case .hops:
      guard let hops = self.beer.ingredients?.hops, hops.count > 0 else {
        return noInformationLocalizedString
      }
      var contentList: [String] = []
      for hop in hops {
        let contents = """
        \(hop.name)
        \(hop.amount.value) \(hop.amount.unit)
        """
        contentList.append(contents)
      }
      return contentList.joined(separator: "\n\n")
      
    case .yeast:
      return self.beer.ingredients?.yeast ?? noInformationLocalizedString
      
    case .foodPairing:
      guard let foodPairing = self.beer.foodPairing else {
        return noInformationLocalizedString
      }
      return foodPairing.joined(separator: "\n")
      
    case .brewersTips:
      return self.beer.brewersTips ?? noInformationLocalizedString
      
    case .contributedBy:
      return self.beer.contributedBy ?? noInformationLocalizedString
    }
  }
  
  // MARK: - Internal Function
  
  // MARK: - Public Function
  
  // MARK: - IBAction
  
}

// MARK: - UITableViewDataSource

extension BeerDetailViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return BeerDetailType.allValues.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(BeerDetailCell.self, indexPath: indexPath)
    
    let beerDetailType = BeerDetailType.allValues[indexPath.row]
    cell.titleLabel.text = self.beerDetailCellTitle(from: beerDetailType)
    cell.contentLabel.text = self.beerDetailCellContent(from: beerDetailType)
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension BeerDetailViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // dummy
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return Constant.sectionHeaderHeight
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return Constant.sectionFooterHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let imageUrlString = beer.imageUrl ?? ""
    guard let imageUrl = URL(string: imageUrlString),
          let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BeerDetailHeaderView.className) as? BeerDetailHeaderView else {
      return nil
    }
    headerView.beerImageView.af_setImage(withURL: imageUrl)
    return headerView
  }
}

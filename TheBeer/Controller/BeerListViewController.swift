//
//  BeerListViewController.swift
//  TheBeer
//
//  Created by roy.lee on 2018. 4. 19..
//  Copyright © 2018년 roy.lee. All rights reserved.
//

import UIKit

import AlamofireImage
import Moya
import Moya_ObjectMapper

extension BeerListViewController {
  
  enum Constant {
    static let estimatedRowHeight: CGFloat = 106.0
    static let perPage = TheBeerService.Constant.defaultLimit
  }
  
  enum Color {
    static let separatorColor = UIColor(red: 0.6196, green: 0.6196, blue: 0.6196, alpha: 1)
  }
}

class BeerListViewController: UIViewController {
  
  lazy var progressHUD: TBProgressHUD = {
    let frame = CGRect(origin: CGPoint.zero, size: self.view.frame.size)
    let progressHUD = TBProgressHUD(frame: frame)
    return progressHUD
  }()
  
  var beers: [TBBeer] = []
  var isListBottom = false
  var page = 1
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - View lifecycle
  
  deinit {
    TBDebug.print("\(self.className) deinitialization")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.initializeView()
    
    self.requestBeers()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.progressHUD.frame.size = self.view.frame.size
  }
  
  // MARK: - Private Function
  
  private func initializeView() {
    self.navigationItem.title = NSLocalizedString("beer_list_navigation_title", comment: "")
    
    self.tableView.registerCell(BeerListCell.self)
    self.tableView.separatorColor = Color.separatorColor
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = Constant.estimatedRowHeight
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.progressHUD.isHidden = true
    self.view.addSubview(self.progressHUD)
  }
  
  private func requestBeers() {
    self.progressHUD.isHidden = false
    
    let theBeerService = MoyaProvider<TheBeerService>()
    let pagination = TheBeerService.Pagination(page: self.page, perPage: Constant.perPage)
    theBeerService.request(.beers(pagination: pagination, param: nil)) { [weak self] result in
      self?.progressHUD.isHidden = true
      
      guard let `self` = self else {
        return
      }
      
      switch result {
      case let .success(response):
        let statusCode = response.statusCode
        if statusCode == TheBeerService.ResponseCode.success {
          let beers = (try? response.mapArray(TBBeer.self)) ?? []
          
          if beers.count < Constant.perPage {
            self.isListBottom = true
          }
          
          if beers.count > 0 {
            self.beers.append(contentsOf: beers)
            DispatchQueue.main.async {
              self.tableView.reloadData()
            }
          }
        }
        
      case .failure:
        break
      }
    }
  }
  
  // MARK: - Internal Function
  
  // MARK: - Public Function
  
  // MARK: - IBAction
}

// MARK: - UITableViewDataSource

extension BeerListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.beers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(BeerListCell.self, indexPath: indexPath)
    
    let beer = self.beers[indexPath.row]
    
    // 맥주 이미지
    cell.beerImageView.image = nil
    let imageUrlString = beer.imageUrl ?? ""
    if let imageUrl = URL(string: imageUrlString) {
      cell.beerImageView.af_setImage(withURL: imageUrl,
                                     placeholderImage: nil,
                                     filter: nil,
                                     progress: nil,
                                     progressQueue: DispatchQueue.main,
                                     imageTransition: TBConstant.ImageTransition.crossDissolve,
                                     runImageTransitionIfCached: false,
                                     completion: nil)
    }
    
    // 맥주명
    cell.beerNameLabel.text = beer.name
    
    // 맥주 알콜도수
    let abvLocalizedString = NSLocalizedString("beer_list_abv", comment: "")
    let noInformationLocalizedString = NSLocalizedString("beer_list_no_information", comment: "")
    if let abv = beer.abv {
      cell.beerAbvLabel.text = "\(abvLocalizedString) : \(abv)"
    } else {
      cell.beerAbvLabel.text = "\(abvLocalizedString) : \(noInformationLocalizedString)"
    }
    
    // 맥주 설명
    cell.beerDescriptionLabel.text = beer.description ?? noInformationLocalizedString
    
    // 더보기
    if !self.isListBottom && indexPath.row != 0 && indexPath.row == (self.beers.count - 1) {
      self.page += 1
      self.requestBeers()
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension BeerListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let beer = self.beers[indexPath.row]
    let beerDetailViewController = BeerDetailViewController(beer: beer)
    self.navigationController?.pushViewController(beerDetailViewController, animated: true)
  }
}

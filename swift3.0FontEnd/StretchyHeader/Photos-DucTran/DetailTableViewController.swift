//
//  DetailTableViewController.swift
//  Photos-DucTran
//
//  Created by Jian Su on 3/8/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
  
  var image: UIImage?
  var category: String?
  let comments = Comment.allComments()
  
  private let tableHeaderViewHeight:CGFloat = 500.0
  private let tableHeaderViewCutaway: CGFloat = 40.0
  var headerView: DetailHeaderView!
  var headerMaskLayer: CAShapeLayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = category
    tableView.estimatedRowHeight = tableView.rowHeight
    tableView.rowHeight = UITableViewAutomaticDimension
    
    headerView = tableView.tableHeaderView as! DetailHeaderView
    headerView.image = image
    tableView.tableHeaderView = nil
    tableView.addSubview(headerView)
    tableView.contentInset = UIEdgeInsets(top: tableHeaderViewHeight, left: 0, bottom: 0, right: 0)
    tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderViewHeight + 64)
    //cut away the header view
    headerMaskLayer = CAShapeLayer()
    headerMaskLayer.fillColor = UIColor.black.cgColor
    headerView.layer.mask = headerMaskLayer
    
    let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway / 2
    tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
    tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
    
    updateHeaderView()
  }
  
  func updateHeaderView() {
    let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway / 2
    var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderViewHeight)
    
    if tableView.contentOffset.y < -effectiveHeight {
      headerRect.origin.y = tableView.contentOffset.y
      headerRect.size.height = -tableView.contentOffset.y + tableHeaderViewCutaway / 2
    }
    
    headerView.frame = headerRect
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: headerRect.width, y: 0))
    path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
    path.addLine(to: CGPoint(x: 0, y: headerRect.height - tableHeaderViewCutaway))
    headerMaskLayer?.path = path.cgPath
  }
}

// MARK: - UITableViewDataSource

extension DetailTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
    
    cell.comment = comments[indexPath.row]
    return cell
  }
}

extension DetailTableViewController {
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateHeaderView()
  }
}

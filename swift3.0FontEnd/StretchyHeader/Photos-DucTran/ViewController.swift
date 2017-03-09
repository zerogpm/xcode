//
//  ViewController.swift
//  StretchyHeaders
//
//  Created by Duc Tran on 5/28/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit

class ViewController: UITableViewController
{
    fileprivate let tableHeaderHeight: CGFloat = 300.0
    fileprivate let tableHeaderCutAway: CGFloat = 80.0
    
    fileprivate var headerView: UIView!
    fileprivate var headerMaskLayer: CAShapeLayer!
    
    fileprivate let items = NewsItem.allItems()
    
    // hide the status bar
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // so that we can manage the header as we wish
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        
        // add it to the table view to ensure it is in the view hierarchy
        tableView.addSubview(headerView)
        
        // we push the content of the table view down by the height of the header.
        // set the content off set downward by the same amount so we start off with the header view completely visible
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        
        // cut away the header view
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        
        headerView.layer.mask = headerMaskLayer
        
        // adjust the content in set of the table view so that the first cell is a little bit in the cut-away
        let effectiveHeight = tableHeaderHeight - tableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        updateHeaderView()
    }
    
    // handle updates to the headerView as the tableView scrolls
    // when the scroll view scrolls normally, we update the frame of the header view such that it is at the top of the table view (-tableHeaderHeight)
    // when we pull down beyond the top of the table view (the content offset is smaller than -tableHeaderHeight)
    // we position the header view right at the offset and extend the height of the header view
    // because we've set the image view to resize with the aspect will content mode, the header will look right at any size

    func updateHeaderView()
    {
        let effectiveHeight = tableHeaderHeight - tableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
        
        // bounds is the view's dimension in its own coordinate system
        // frame is the view's dimensions in its parent's coordinate system
        
        // create the header cut-away
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - tableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath
        
    
    }
    
}

// MARK: - UITableViewDataSource

extension ViewController
{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsItemCell
        cell.newsItem = items[indexPath.row]
        return cell
    }
}

extension ViewController
{
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}




















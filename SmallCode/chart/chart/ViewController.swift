//
//  ViewController.swift
//  chart
//
//  Created by Jian Su on 6/10/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

  @IBOutlet weak var barchart: BarChartView!
  var months: [String]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    
    setChart(months, values: unitsSold)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func setChart(dataPoints:[String], values:[Double]) {
    barchart.noDataText = "you need to provide data"
    var dataEntries:[BarChartDataEntry] = []
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
      dataEntries.append(dataEntry)
    }
    
    let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
    chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
    let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
    barchart.data = chartData
    barchart.descriptionText = ""
    barchart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


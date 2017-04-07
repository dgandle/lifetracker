//
//  ChartViewController.swift
//  lifetracker
//
//  Created by Benjamin Danzig on 12/9/16.
//  Copyright © 2016 Doug Gandle. All rights reserved.
//

import UIKit
import Charts

var days: [String]!
var valuesArr: [Double]!
var yAxisLabel: String = ""


class ChartViewController: UIViewController {

    
    @IBOutlet weak var barChartView: BarChartView!
    
    
    func initSetChartParameters(_ dataPoints: [String], values: [Double],yLabel: String){
        days = dataPoints
        valuesArr = values
        yAxisLabel = yLabel
    }
    
    func setChart(_ dataPoints: [String], values: [Double],yLabel: String) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: yLabel)
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.      
        setChart(days, values: valuesArr, yLabel: yAxisLabel)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

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
    
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var daysTrackedLabel: UILabel!
    @IBOutlet weak var daysCompletedLabel: UILabel!
    @IBOutlet weak var currentStreakLabel: UILabel!
    
    
    func initSetChartParameters(_ dataPoints: [String], values: [Double],yLabel: String){
        days = dataPoints
        valuesArr = values
        yAxisLabel = yLabel
    }
    
    func setChart(_ dataPoints: [String], values: [Double],yLabel: String) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        
        //Chart Formatting
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.granularity = 1
        barChartView.leftAxis.axisMinimum = 0
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.xAxis.granularity = 1
        
        barChartView.legend.enabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.highlightFullBarEnabled = false
        barChartView.chartDescription?.text = ""
        
        
        barChartView.xAxis.labelFont = UIFont(name: "NeuzeitGroT", size: 12)!
        barChartView.xAxis.labelTextColor = UIColor(red:0.58, green:0.60, blue:0.60, alpha:1.0)
        barChartView.leftAxis.labelFont = UIFont(name: "NeuzeitGroT", size: 12)!
        barChartView.leftAxis.labelTextColor = UIColor(red:0.58, green:0.60, blue:0.60, alpha:1.0)
        barChartView.leftAxis.gridColor = UIColor(red:0.87, green:0.87, blue:0.90, alpha:1.0)
        
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: yLabel)
        chartDataSet.setColor(UIColor(red:0.23, green:0.77, blue:0.41, alpha:1.0))
        chartDataSet.drawValuesEnabled = false
        chartDataSet.highlightEnabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.fitScreen()
        barChartView.scaleXEnabled = false
        barChartView.scaleYEnabled = false
        barChartView.dragEnabled = false
    }
    
    func setInfoSummary() {
        
        // Average
        var total = 0
        for i in 0..<valuesArr.count {
            total += Int(valuesArr[i])
        }
        averageLabel.text = String(total / valuesArr.count)
        
        // Days Tracked
        daysTrackedLabel.text = String(days.count)
        
        // Days Completed
        total = 0
        for i in 0..<valuesArr.count {
            if (valuesArr[i] > 0) {
                total += 1
            }
        }
        daysCompletedLabel.text = String(total)
        
        // Current Streak
        total = 0
        var flag = false
        for i in (0..<valuesArr.count).reversed()
        {
            if (!flag) {
                if (valuesArr[i] > 0) {
                    total += 1
                } else {
                    flag = true
                }
            }
        }
        currentStreakLabel.text = String(total)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.      
        setChart(days, values: valuesArr, yLabel: yAxisLabel)
        setInfoSummary()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

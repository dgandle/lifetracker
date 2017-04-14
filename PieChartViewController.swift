//
//  PieChartViewController.swift
//  
//
//  Created by Doug Gandle on 4/14/17.
//
//

import UIKit
import Charts

var booleanValuesArr: [Double]!
var booleanOptions: [String]! // Alternative to "days" in bar chart, seperates pie chart into "yes" and "no"

class PieChartViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var daysTrackedLabel: UILabel!
    @IBOutlet weak var daysCompletedLabel: UILabel!
    @IBOutlet weak var currentStreakLabel: UILabel!
    
    func initSetChartParameters(_ dataPoints: [String], values: [Double], yLabel: String) {
        booleanValuesArr = values
        booleanOptions = ["Yes", "No"]
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        var yesCount = 0
        var noCount = 0
        for i in 0..<values.count {
            if (values[i] == 1) {
                yesCount += 1
            } else {
                noCount += 1
            }
        }
        let yesEntry = ChartDataEntry(x: 1, y: Double(yesCount))
        dataEntries.append(yesEntry)
        let noEntry = ChartDataEntry(x: 0, y: Double(noCount))
        dataEntries.append(noEntry)

        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        
//        let pieChartData = PieChartData(xVals: dataPoints, dataset: pieChartDataSet)
        
        pieChartView.data = pieChartData
        
        pieChartDataSet.colors = ChartColorTemplates.colorful()
    }
    
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setChart(dataPoints: ["No", "Yes"], values: valuesArr)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

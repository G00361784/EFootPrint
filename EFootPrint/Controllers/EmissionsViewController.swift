//
//  EmissionsViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 27/11/2024.
//

import UIKit
import HealthKit

class EmissionsViewController: UIViewController {

    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var walkVsCar: UILabel!
    let healthStore = HKHealthStore()

    func calculateCarbonSavings(distanceInMiles: Double, transportationType: String) -> Double {

        let emissionsPerMile: Double

        switch transportationType {
        case "car":
            emissionsPerMile = 404  // grams of CO2 per mile for a typical gasoline car
        case "bus":
            emissionsPerMile = 105  // grams of CO2 per mile for a typical bus (average)
        case "train":
            emissionsPerMile = 35   // grams of CO2 per mile for a typical train (average)
        case "walk":
            emissionsPerMile = 0
        default:
            emissionsPerMile = 0    // Assume no emissions for walking or other modes
        }

        let carbonSavings = distanceInMiles * emissionsPerMile

        return carbonSavings
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHealthKit()
    }

    func authorizeHealthKit() {
        let healthDataTypes = Set([HKQuantityType.quantityType(forIdentifier: .stepCount)!])

        healthStore.requestAuthorization(toShare: [], read: healthDataTypes) { (success, error) in
            if !success {
                // Handle authorization error
            } else {
                self.getSteps()
            }
        }
    }

    func getSteps() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let query = HKStatisticsQuery(quantityType: stepType,
                                    quantitySamplePredicate: nil,
                                    options: .cumulativeSum) { _, result, error in
            guard let result = result else {
                // Handle error
                return
            }

            if let sum = result.sumQuantity() {
                let stepCount = sum.doubleValue(for: HKUnit.count())
                print("Total steps: \(stepCount)")
                // Update UI on main thread
                let calculationPerformed = self.calculateCarbonSavings(distanceInMiles:stepCount/2250.00, transportationType: "car");//average step count per mile is 2250
                
                
                DispatchQueue.main.async {
                    self.stepCountLabel.text = "Total steps: \(stepCount)"
                    self.walkVsCar.text = "\(calculationPerformed)"
                    
                }
                
            }
        }

        healthStore.execute(query)
        
       
    }
}

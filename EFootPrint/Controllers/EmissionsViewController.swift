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
    let healthStore = HKHealthStore()

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
                DispatchQueue.main.async {
                    self.stepCountLabel.text = "Total steps: \(stepCount)"
                }
            }
        }

        healthStore.execute(query)
    }
}

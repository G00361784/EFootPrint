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
        showPermissionAlert()
    }
    func showPermissionAlert() {
            let alertController = UIAlertController(title: "Allow Access to HealthKit?",
                                                    message: "This app needs access to your step data to track your activity.",
                                                    preferredStyle: .alert)

            let allowAction = UIAlertAction(title: "Allow", style: .default) { _ in
                self.requestHealthKitAuthorization()
            }

            alertController.addAction(allowAction)
            present(alertController, animated: true, completion: nil)
        }

        func requestHealthKitAuthorization() {
            let healthDataTypes = Set([HKQuantityType.quantityType(forIdentifier: .stepCount)!])

            healthStore.requestAuthorization(toShare: [], read: healthDataTypes) { (success, error) in
                if success {
                    self.getStepCount()
                } else {
                    // Handle authorization error (e.g., show an error message)
                    if let error = error {
                        print("HealthKit authorization failed with error: \(error)")
                        // You could display an alert here to inform the user.
                    }
                }
            }
        }

    func authorizeHealthKit() {
        let healthDataTypes = Set([HKQuantityType.quantityType(forIdentifier: .stepCount)!])

        healthStore.requestAuthorization(toShare: [], read: healthDataTypes) { (success, error) in
            if success {
                self.getStepCount()
            }
        }
    }

    func getStepCount() {
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let query = HKStatisticsQuery(quantityType: stepCountType,
                                    quantitySamplePredicate: nil,
                                    options: .cumulativeSum) { _, result, error in
            guard let result = result else {
                // Handle error
                return
            }

            if let stepCount = result.sumQuantity() {
                let stepCountDouble = stepCount.doubleValue(for: HKUnit.count())
                DispatchQueue.main.async {
                    self.stepCountLabel.text = "\(Int(stepCountDouble)) steps"
                }
            }
        }

        healthStore.execute(query)
    }
}

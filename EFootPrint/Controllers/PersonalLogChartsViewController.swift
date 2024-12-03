//
//  PersonalLogChartsViewController.swift
//  EFootPrint
//
//  Created by Joseph Mccole on 03/12/2024.
//

import UIKit
import SwiftUI
import Charts

class PersonalLogChartsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = ContentView()
        let hostingController = UIHostingController(rootView: contentView)

        // Add the SwiftUI view to your view hierarchy
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        // Set constraints for the SwiftUI view (important!)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    struct ContentView: View {
        let data: [(Double, Double)] = [
            (1, 2), (2, 5), (3, 3), (4, 6), (5, 8)
        ]

        var body: some View {
            Chart {
                ForEach(data, id: \.0) { x, y in
                    LineMark(
                        x: .value("X", x),
                        y: .value("Y", y)
                    )
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 300)
            .padding()
        }
    }
}

//
//  ScanControllerViewController.swift
//  Fleet-Manager
//
//  Created by Luke McGovern on 10/20/23.
//

import UIKit

class ScanViewController: UIViewController {
    
    @IBOutlet weak var scanOrSearch: UISegmentedControl!
    @IBOutlet weak var aircraftSearchBr: UISearchBar! // needs array of data to search through
    let image = UIImage(named: "ReadyToScan")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemCyan.cgColor,
            UIColor.white.cgColor
        ]
        view.layer.addSublayer(gradientLayer)
    }

}

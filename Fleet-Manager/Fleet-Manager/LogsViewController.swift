//
//  LogsViewController.swift
//  Fleet-Manager
//
//  Created by Luke McGovern on 10/20/23.
//

import UIKit

class LogsViewController: UIViewController {
    
    @IBOutlet weak var timeLogsButton: UIButton!
    @IBOutlet weak var maintLogsButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func time(_ sender: UIButton) {
        // create time logs
        print("time")
    }
    
    @IBAction func maintenance(_ sender: UIButton) {
        // create maintenance logs
        print("maintenance")
    }

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

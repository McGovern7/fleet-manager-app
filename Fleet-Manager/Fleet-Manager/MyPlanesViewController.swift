//
//  ViewController.swift
//  Fleet-Manager
//
//  Created by Luke McGovern on 10/20/23.
//

import UIKit

class MyPlanesViewController: UIViewController {

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


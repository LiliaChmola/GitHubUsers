//
//  ViewController.swift
//  GitHubUsers
//
//  Created by Chmola Lilia on 7/12/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var blueLayer: CAGradientLayer! {
        didSet {
            blueLayer.startPoint = CGPoint(x: 0, y: 0)
            blueLayer.endPoint = CGPoint(x: 1, y: 1)
            
            blueLayer.backgroundColor = #colorLiteral(red: 0.2374775112, green: 0.3320055604, blue: 0.6643337607, alpha: 1)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueLayer = CAGradientLayer()
        
        view.layer.insertSublayer(blueLayer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        
        blueLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 261.2)
    }
}


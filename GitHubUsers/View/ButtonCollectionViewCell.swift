//
//  ButtonCollectionViewCell.swift
//  GitHubUsers
//
//  Created by Chmola Lilia on 7/14/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.backgroundColor = #colorLiteral(red: 0.9968195558, green: 0.9739584327, blue: 0.8861609697, alpha: 1)
            imageView.layer.masksToBounds = false
            imageView.layer.cornerRadius = imageView.bounds.size.height / 2
        }
    }
    @IBOutlet weak var label: UILabel!
    
}

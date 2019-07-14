//
//  ViewController.swift
//  GitHubUsers
//
//  Created by Chmola Lilia on 7/12/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let networkManager = NetworkManager()
    private var since = 0
    private var users = [User]()

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getDetailsFrom(since: 0) { [weak self] (users) in
            self?.users = users
            self?.collectionView.reloadData()           
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        
        if section == 1 {
            return users.count
        }
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
            if indexPath.row == 0 {
                cell.label.text = "Find an instructor"
                cell.imageView.image = #imageLiteral(resourceName: "wheel")
            } else if indexPath.row == 1 {
                cell.label.text = "Find a school"
                cell.imageView.image = #imageLiteral(resourceName: "school")
            }
            
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            let user = users[indexPath.row]
            cell.idLabel.text = String(user.id)
            cell.typeLabel.text = String(user.type)
            cell.loginLabel.text = String(user.login)
            cell.imageView.sd_setImage(with: URL(string: user.avatarUrl), placeholderImage: UIImage(named: "placeholder"))
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == users.count - 1 {
            self.since += 30
            networkManager.getDetailsFrom(since: since) { [weak self] (users) in
                self?.users.append(contentsOf: users)
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            
            let screenSize = UIScreen.main.bounds.size
            return CGSize.init(width: screenSize.width * 0.4, height: screenSize.height * 0.3)
        } else if indexPath.section == 1 {
            
            let screenSize = UIScreen.main.bounds.size
            return CGSize.init(width: screenSize.width * 0.4, height: screenSize.height * 0.4)
        }
        return CGSize.init()
    }
}

// MARK: - UIButton extension
fileprivate extension UIButton {
    func setStyle() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
    }
}

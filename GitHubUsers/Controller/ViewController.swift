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
            cell.setStyle(with: 5)
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
            cell.setStyle(with: 2)
            let user = users[indexPath.row]
            cell.idLabel.text = String(user.id)
            cell.typeLabel.text = String(user.type)
            cell.loginLabel.text = String(user.login)
            cell.imageView.sd_setImage(with: URL(string: user.avatarUrl), placeholderImage: UIImage(named: "placeholder"))
            if user.siteAdmin {
                let newImage = #imageLiteral(resourceName: "likeOff").withRenderingMode(.alwaysOriginal)
                cell.likeButton.setImage(newImage, for: .normal)
            } else {
                let newImage = #imageLiteral(resourceName: "likeOn").withRenderingMode(.alwaysOriginal)
                cell.likeButton.setImage(newImage, for: .normal)
            }
            cell.likeButton.layer.cornerRadius = 15
            cell.likeButton.layer.masksToBounds = true
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WelcomeSectionHeader", for: indexPath) as? WelcomeUICollectionReusableView {
            
            if indexPath.section == 0 {
                sectionHeader.welcomeLabel.text = "Welcome"
                sectionHeader.nameLabel.text = "Adnan Lacevic"
                sectionHeader.nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
                sectionHeader.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
            } else if indexPath.section == 1 {
                
                sectionHeader.welcomeLabel.text = " "
                sectionHeader.nameLabel.text = "Top rated instructors"
                sectionHeader.nameLabel.font = UIFont.boldSystemFont(ofSize: 13)
                sectionHeader.nameLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                
            }
            
            return sectionHeader
        }
        
        
        return UICollectionReusableView()
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
        let screenSize = UIScreen.main.bounds.size
        let itemWidth = (screenSize.width - 45) / 2
        if indexPath.section == 0 {
            return CGSize.init(width: itemWidth, height: screenSize.height * 0.25)
        } else if indexPath.section == 1 {
            return CGSize.init(width: itemWidth, height: screenSize.height * 0.4)
        }
        return CGSize.init()
    }
}
// MARK: - UIView extension
fileprivate extension UIView {
    func setStyle(with shadowRadius: CGFloat) {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5.0
    }
}

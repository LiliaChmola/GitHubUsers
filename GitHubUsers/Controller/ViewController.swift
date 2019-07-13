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
    @IBOutlet weak var collectionViewHeightLayoutConstraint: NSLayoutConstraint!
    private let networkManager = NetworkManager()
    private let since = 0
    private var users = [User]()
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getDetailsFrom(since: 0) { [weak self] (users) in
            self?.users = users
            self?.collectionView.reloadData()
            self?.view.layoutIfNeeded()
            self?.collectionViewHeightLayoutConstraint.constant = self?.collectionView.contentSize.height ?? 0
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let user = users[indexPath.row]
        cell.idLabel.text = String(user.id)
        cell.typeLabel.text = String(user.type)
        cell.loginLabel.text = String(user.login)
        cell.imageView.sd_setImage(with: URL(string: user.avatarUrl), placeholderImage: UIImage(named: "placeholder"))

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        return CGSize.init(width: screenSize.width * 0.4, height: screenSize.height * 0.4)
    }
}

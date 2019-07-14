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
    @IBOutlet weak var findASchoolButton: UIButton! {
        didSet {
            findASchoolButton.setStyle()
        }
    }
    @IBOutlet weak var findInstructorButton: UIButton! {
        didSet {
            findInstructorButton.setStyle()
        }
    }
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

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (users.count-1) {
            print("Last cell")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        return CGSize.init(width: screenSize.width * 0.4, height: screenSize.height * 0.4)
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

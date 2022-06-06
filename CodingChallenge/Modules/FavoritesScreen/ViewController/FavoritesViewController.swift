//
//  FavoritesViewController.swift
//  CodingChallenge
//
//  Created by 01HW1928584 on 05/06/22.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // MARK: - Variables
    var favoritesArray: [APIServiceResponse] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        // myCollectionView.register(MyCellCollectionViewCell.self, forCellWithReuseIdentifier: "MyCellCollectionViewCell")
        
        // myCollectionView?.register(UINib(nibName: "MyCellCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MyCellCollectionViewCell")
        myCollectionView.register(MyCellCollectionViewCell.nib(), forCellWithReuseIdentifier: "MyCellCollectionViewCell")
        myCollectionView.backgroundColor = UIColor.white
        
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadListOfImages()
    }
    
    // MARK: - Methods
    func loadListOfImages() {
        if let oldData = UserDefaults.standard.value(forKey: favoritesKey) as? Data, let oldDataArray = try? JSONDecoder().decode([APIServiceResponse].self, from: oldData){
            favoritesArray = oldDataArray
        }
        myCollectionView.reloadData()
        
    }
    
    // MARK: - CollectionViewMethods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellCollectionViewCell", for: indexPath) as? MyCellCollectionViewCell {
            cell.settingData(from: favoritesArray[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

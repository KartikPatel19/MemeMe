//
//  CollactionVC.swift
//  MemeMe
//
//  Created by kartik patel on 02/04/18.
//  Copyright © 2018 kartik patel. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCollectionViewCell"

class CollactionVC: UICollectionViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetail = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailVC
        let meme = (UIApplication.shared.delegate as! AppDelegate).memes[indexPath.row]
        memeDetail.detailMeme = meme
        navigationController?.pushViewController(memeDetail, animated: true)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        let meme = (UIApplication.shared.delegate as! AppDelegate).memes[indexPath.row]
        cell.imageView.image = meme.memedImage
        
        return cell
    }
    

}

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


    @IBOutlet weak var flowLayoutMeme: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayoutMeme.minimumInteritemSpacing = space
        flowLayoutMeme.minimumLineSpacing = space
        flowLayoutMeme.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        let meme = (UIApplication.shared.delegate as! AppDelegate).memes[indexPath.row]
        cell.imageView.image = meme.memedImage
        
        return cell
    }

}

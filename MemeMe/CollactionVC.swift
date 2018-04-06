//
//  CollactionVC.swift
//  MemeMe
//
//  Created by kartik patel on 02/04/18.
//  Copyright © 2018 kartik patel. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reusableCell"

class collectionMemeCell:UICollectionViewCell{
    @IBOutlet weak var imageView:UIImageView!
}

class CollactionVC: UICollectionViewController {

    var memes = [Meme]()
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(collectionMemeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView!.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! collectionMemeCell
        cell.imageView.image = memes[indexPath.row].memedImage
        return cell
    }

}

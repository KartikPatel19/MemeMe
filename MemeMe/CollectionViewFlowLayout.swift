//
//  CollectionViewFlowLayout.swift
//  MemeMe
//
//  Created by kartik patel on 10/04/18.
//  Copyright © 2018 kartik patel. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {

	var numberOfItemsPerRow: Int = 3 {
		didSet {
			invalidateLayout()
		}
	}
	
	
	override func prepare() {
		super.prepare()
		
		if let collectionView = self.collectionView {
			var newItemSize = itemSize
			
			// Always use an item count of at least 1
			let itemsPerRow = CGFloat(max(numberOfItemsPerRow, 1))
			
			// Calculate the sum of the spacing between cells
			let totalSpacing = minimumInteritemSpacing * (itemsPerRow - 1.0)
			
			// Calculate how wide items should be
			newItemSize.width = (collectionView.bounds.size.width - totalSpacing) / itemsPerRow
			
			// Use the aspect ratio of the current item size to determine how tall the items should be
			if itemSize.height > 0 {
				let itemAspectRatio = itemSize.width / itemSize.height
				newItemSize.height = newItemSize.width / itemAspectRatio
			}
			
			// Set the new item size
			itemSize = newItemSize
		}
	}
}

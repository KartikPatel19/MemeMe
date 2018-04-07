//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by kartik patel on 07/04/18.
//  Copyright © 2018 kartik patel. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageDetail: UIImageView!
    
    var detailMeme : Meme! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imageDetail.image = detailMeme.memedImage
        tabBarController?.tabBar.isHidden = true
    }

}

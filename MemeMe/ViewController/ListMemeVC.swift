//
//  ListMemeVC.swift
//  MemeMe
//
//  Created by kartik patel on 29/03/18.
//  Copyright © 2018 kartik patel. All rights reserved.
//

import UIKit

class ListMemeVC: UITableViewController{
    
    var memes = [Meme]()
    @IBOutlet var memeTableView: UITableView!
    
    var tableCellReuseIdentifier = "reusableTableCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        memeTableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = memeTableView.dequeueReusableCell(withIdentifier: tableCellReuseIdentifier) as! TableViewCell
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.memeName?.text = generateLabelText(topText: meme.topText, bottomText: meme.bottomText)
        cell.memeImage?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetail = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailVC
        let meme = (UIApplication.shared.delegate as! AppDelegate).memes[indexPath.row]
        memeDetail.detailMeme = meme
        navigationController?.pushViewController(memeDetail, animated: true)
    }
    
    
    func generateLabelText(topText: String, bottomText: String) -> String {
        
        let ellipsis = "..."
        
        let maxNumCharsAvail = 22
        let halfNumCharsAvail = maxNumCharsAvail / 2
        
        let topTextLen = topText.count
        let bottomTextLen = bottomText.count
        
        var remainingCharsAvail = maxNumCharsAvail
        var labelText = ""
        
        // set up first half label...
        if topTextLen <= halfNumCharsAvail {
            labelText += topText
        }
        else {
            // truncate top text to halfway point
            let index = topText.index(topText.startIndex, offsetBy: halfNumCharsAvail)
            labelText += String(topText[..<index])
        }
        
        remainingCharsAvail -= labelText.count
        
        labelText += ellipsis
        
        // set up second half label
        if bottomTextLen <= remainingCharsAvail {
            labelText += bottomText
        }
        else {
            // truncate bottom text to fit
            if remainingCharsAvail <= halfNumCharsAvail {
                // no room left over from the front, so simply truncate
                let index = bottomText.index(bottomText.endIndex, offsetBy: -(remainingCharsAvail))
                labelText += String(bottomText[index...])
            }
            else {
                // room was left at the front, so split the truncation between front and back
                // get remainder at front; fill it with beginning of bottom text
                let numCharsLeftAtFront = remainingCharsAvail - halfNumCharsAvail
                let frontIndex = bottomText.index(bottomText.startIndex, offsetBy: numCharsLeftAtFront)
                labelText += String(bottomText[..<frontIndex])
                
                // add ellipsis
                labelText += ellipsis
                remainingCharsAvail = halfNumCharsAvail - ellipsis.count
                
                // get remainder at end; fill with ending of bottom text
                let backIndex = bottomText.index(bottomText.endIndex, offsetBy: -(remainingCharsAvail))
                labelText += bottomText[backIndex...]
            }
        }
        
        return labelText
    }
    
    
}

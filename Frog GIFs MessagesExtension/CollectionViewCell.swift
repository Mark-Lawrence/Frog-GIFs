//
//  CollectionViewCell.swift
//  Frog GIFs MessagesExtension
//
//  Created by Mark Lawrence on 12/16/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import Messages

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var stickerView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    func configure(gifFile:String, keyPhoto: String) {
        
        let image = UIImage(named: keyPhoto)
        stickerView.image = image
        textLabel.text = gifFile
    }
}





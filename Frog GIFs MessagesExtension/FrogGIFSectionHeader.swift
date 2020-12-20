//
//  FrogGIFSectionHeader.swift
//  Frog GIFs MessagesExtension
//
//  Created by Mark Lawrence on 12/16/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class FrogGIFSectionHeader: UICollectionReusableView {
    @IBOutlet var sectionTitle: UILabel!
    func configure(usingTitle title:String) {
        self.sectionTitle.text = title
    }
}


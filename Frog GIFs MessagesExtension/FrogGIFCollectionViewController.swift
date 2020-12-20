//
//  FrogGIFCollectionViewController.swift
//  Frog GIFs MessagesExtension
//
//  Created by Mark Lawrence on 12/16/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit
import Messages

private let reuseIdentifier = "Cell"

enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad // iPad style UI
}


class FrogGIFCollectionViewController: UICollectionViewController {
    
    
    
    var numberOfItemsPerRow = 3.0 as CGFloat
    let interItemSpacing = 10.0 as CGFloat
    let interRowSpacing = 10.0 as CGFloat
    let sectionTitleKey = "SectionTitle"
    let sectionItemsKey = "Items"
    var data = [Dictionary<String,AnyObject>]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            numberOfItemsPerRow = 6.0 as CGFloat
        }
        
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        if let path = Bundle.main.path(forResource: "FrogGIFData", ofType: ".plist") {
            let dict = NSDictionary(contentsOfFile: path) as! Dictionary<String,AnyObject>
            let allSections = dict["Sections"] as? [[String:AnyObject]]
            if let selectedSections = UserDefaults.standard.array(forKey: "selectedSections") as? [Int] {
                for index in selectedSections {
                    self.data.append((allSections![index]))
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (data[section][sectionItemsKey] as! NSArray).count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Configure the cell
        collectionView.allowsSelection = true
        
        
        guard let foodItem = cell as? CollectionViewCell else {
            return
        }
        let sectionItems = self.data[indexPath.section][sectionItemsKey] as? [[String]]
        let gifFile = sectionItems![indexPath.row][0]
        let keyPhoto = sectionItems![indexPath.row][1]
        foodItem.configure(gifFile: gifFile, keyPhoto: keyPhoto)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected item at index path ")
        print(indexPath)
        
        let sectionItems = self.data[indexPath.section][sectionItemsKey] as? [[String]]
        let imageName = sectionItems![indexPath.row][0]
        guard let imagePath = Bundle.main.path(forResource: imageName, ofType: ".png") else {
            return
        }
        let path =  URL(fileURLWithPath: imagePath)
        //insertImageIntoMessage(usingUrl: path)
        DataHelperMethod.sharedInstance.addImageToTranscript(imageURL: path, imageFileName: imageName)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:String(describing: FrogGIFSectionHeader.self), for: indexPath)
        
        if let foodHeader = headerView as? FrogGIFSectionHeader {
            let section = self.data[indexPath.section]
            let sectionTitle = section[sectionTitleKey] as! String
            foodHeader.configure(usingTitle: sectionTitle)
        }
        return headerView
        
    }
}

extension FrogGIFCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = (numberOfItemsPerRow - 1.0)  * interItemSpacing
        let width = (view.frame.size.width - padding) / numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interRowSpacing
    }
}

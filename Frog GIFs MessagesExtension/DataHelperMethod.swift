//
//  DataHelperMethod.swift
//  Frog GIFs MessagesExtension
//
//  Created by Mark Lawrence on 12/16/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import Foundation

class DataHelperMethod {
    
    static let sharedInstance = DataHelperMethod()
    
    var messagesViewController: MessagesViewController?
    
    func setViewControllerClass(messagesViewController: MessagesViewController){
        self.messagesViewController=messagesViewController
    }
    
    func addImageToTranscript(imageURL: URL, imageFileName: String) {
        messagesViewController?.insertImageIntoMessage(usingUrl: imageURL, fileName: imageFileName)
    }
}


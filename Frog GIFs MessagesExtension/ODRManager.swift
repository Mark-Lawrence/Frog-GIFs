//
//  ODRManager.swift
//  Frog GIFs MessagesExtension
//
//  Created by Mark Lawrence on 12/18/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import Foundation

class ODRManager {
    
    // MARK: - Properties
    static let shared = ODRManager()
    var currentRequest: NSBundleResourceRequest?
    
    func requestSceneWith(tag: String,
                          onSuccess: @escaping () -> Void,
                          onFailure: @escaping (NSError) -> Void) {
        
        // 2
        currentRequest = NSBundleResourceRequest(tags: [tag])
        
        // 3
        guard let request = currentRequest else { return }
        
        request.beginAccessingResources { (error: Error?) in
            
            // 4
            if let error = error {
                onFailure(error as NSError)
                return
            }
            
            // 5
            onSuccess()
        }
    }
}




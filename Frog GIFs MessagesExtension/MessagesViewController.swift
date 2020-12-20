//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Shahab Ejaz on 05/09/2016.
//  Copyright © 2016 Shahab Ejaz. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    let messagesViewController = self
    var reusableUIController = UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewController(withIdentifier: String(describing: FrogGIFCollectionViewController.self)) as! FrogGIFCollectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Here's where you enter how many sections
        let selectedSections:[Int] = [0,1,2,3,4,5,6]
        self.update(selectedSections: selectedSections)
        DataHelperMethod.sharedInstance.setViewControllerClass(messagesViewController: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        self.present(with: self.presentationStyle)
        
        
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
        super.didTransition(to: presentationStyle)
        self.present(with: presentationStyle)
        
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
    
    
    private func present(with presentationStyle:MSMessagesAppPresentationStyle) {
        // Remove any existing child controllers.
        let viewController:UIViewController
        switch presentationStyle {
        case .compact:
            viewController = reusableUIController
            
            break
        case .expanded:
            viewController = reusableUIController
            break
        case .transcript:
            viewController = reusableUIController
            break
        }
        
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        // Embed the new controller.
        addChildViewController(viewController)
        
        viewController.view.frame = view.bounds
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewController.view)
        
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        viewController.didMove(toParentViewController: self)
        
    }
    
    private func update(selectedSections:[Int]) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(selectedSections, forKey: "selectedSections")
        userDefaults.synchronize()
    }
    
    func insertImageIntoMessage(usingUrl url: URL, fileName: String) {
        
        self.requestPresentationStyle(.compact)
        if let conversation = activeConversation {
            
            conversation.insertAttachment(url, withAlternateFilename: fileName, completionHandler: {error in
                if let error = error{
                    print("Error: ", error)
                }
            })
            
        }
    }
}

//
//  MasterMessageVC.swift
//  ImReady
//
//  Created by Inholland on 1/5/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class MasterMessageVC: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var currentUser = sharedInstance.currentUser
    
    lazy var messageVC: MessageVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = MessageVC()
        
        if(self.currentUser?.role == .Client) {
            viewController = storyboard.instantiateViewController(withIdentifier: "Messages") as! MessageVC
            
            self.addVCAsChildVC(childVC: viewController)
        }
        
        return viewController
    }()

    lazy var notificationVC: NotificationVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = NotificationVC()
        
        if(self.currentUser?.role == .Client) {
            viewController = storyboard.instantiateViewController(withIdentifier: "Notifications") as! NotificationVC
        
            self.addVCAsChildVC(childVC: viewController)
        }
        
        return viewController
    }()
    
    lazy var chatListVC: ChatListVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = ChatListVC()
        
        if(self.currentUser?.role == Role.Caregiver) {
            viewController = storyboard.instantiateViewController(withIdentifier: "Chatlist") as! ChatListVC
            
            self.addVCAsChildVC(childVC: viewController)
        }
        
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if(currentUser?.role == Role.Caregiver) {
            segmentedControl.isHidden = true
            let navItem = UINavigationItem(title: "Berichten")
            self.navigationController?.navigationBar.setItems([navItem], animated: false);
            setupCareTakerView()
        }
        
        else {
            setupClientView()
        }
    }
    
    private func setupClientView() {
        setupSegmentedControl()
        
        updateView()
    }
    
    private func setupCareTakerView() {
        chatListVC.view.isHidden = false
    }
    
    private func updateView() {
        if(currentUser?.role == .Client) {
            messageVC.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
            notificationVC.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
        }
    }
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func addVCAsChildVC(childVC: UIViewController) {
        addChildViewController(childVC)
        view.addSubview(childVC.view)
        
        childVC.view.frame = view.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        childVC.didMove(toParentViewController: self)
    }
    
    func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }

}

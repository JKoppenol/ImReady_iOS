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
    
    lazy var messageVC: MessageVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "Messages") as! MessageVC
        
        self.addVCAsChildVC(childVC: viewController)
        return viewController
    }()

    lazy var notificationVC: NotificationVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "Notifications") as! NotificationVC
        
        self.addVCAsChildVC(childVC: viewController)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        setupSegmentedControl()
        
        updateView()
    }
    
    private func updateView() {
        messageVC.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        notificationVC.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
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

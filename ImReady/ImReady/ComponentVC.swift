//
//  ComponentVC.swift
//  ImReady
//
//  Created by Inholland on 1/12/18.
//  Copyright © 2018 Inholland. All rights reserved.
//

import UIKit

class ComponentVC: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var component = Component()
    var currentUser = LoggedInUser().getLoggedInUser()
    
    lazy var infoVC: ComponentInfoVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = ComponentInfoVC()
        
        viewController = storyboard.instantiateViewController(withIdentifier: "Information") as! ComponentInfoVC
        viewController.component = self.component
        
        self.addVCAsChildVC(childVC: viewController)

        return viewController
    }()
    
    lazy var taskVC: ComponentTasksVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = ComponentTasksVC()
        
        viewController = storyboard.instantiateViewController(withIdentifier: "Tasks") as! ComponentTasksVC
        viewController.component = self.component
        self.addVCAsChildVC(childVC: viewController)
        
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
        navigationController?.navigationBar.tintColor = UIColor(red:0.24, green:0.73, blue:0.61, alpha:1.0)
    }
    
    private func updateView() {
        infoVC.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        taskVC.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
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

//
//  activityIndicator.swift
//  ImReady
//
//  Created by Ralph Hink on 15/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation
import UIKit

let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()

//Start the animation of the activity indicator
func activateIndicator_Activity(onViewController viewController: UIViewController,
                                onView view: UIView) {
    activityIndicator.hidesWhenStopped = true
    activityIndicator.center = viewController.view.center
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
}

//Stop the animation of the activity indicator
public func deactivateIndicator_Activity() {
    activityIndicator.stopAnimating()
    UIApplication.shared.endIgnoringInteractionEvents()
}

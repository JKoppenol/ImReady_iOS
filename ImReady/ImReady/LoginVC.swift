//
//  LoginVC.swift
//  ImReady
//
//  Created by Inholland on 12/13/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var userId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: AnyObject) {
        //hier logincheck
        //..
        
        performSegue(withIdentifier: "toFutureCanvas", sender: nil)
        
        //Hier geef je de ingelogde user mee aan de opvolgende view
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            
//            if segue.identifier == "toFutureCanvas" {
//                if let futureCanvas= segue.destination as? TableViewController {
//                    futureCanvas.currentUser = loggedInUser
//                }
//            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

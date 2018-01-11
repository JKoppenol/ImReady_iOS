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
    @IBOutlet weak var rememberMeLbl: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    var loggedInUser: User?
    
    let users: [User] = userService.getAllUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupIBObjects()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: AnyObject) {
        if(usernameText.text == "" || passwordText.text == "") {
            usernameText.layer.borderColor = UIColor.red.cgColor
            passwordText.layer.borderColor = UIColor.red.cgColor
            
            createAlert(title: "Oops, er is iets fout gegaan!", message: "Vul zowel je emailadres als je wachtwoord in!")
        }
        
        else {
            for user in users {
                if(user.password == passwordText.text && user.email == usernameText.text) {
                    sharedInstance.currentUser = user
                    performSegue(withIdentifier: "toFutureCanvas", sender: nil)
                }
                
                continue
            }
            
            createAlert(title: "Onjuiste gegevens!", message: "De zojuist ingevulde gegevens corresponderen niet met een bestaand account.")
        }
    }
    
    private func setupIBObjects() {
        usernameText.layer.borderWidth = 1.0
        passwordText.layer.borderWidth = 1.0
        
        let grey = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        
        usernameText.layer.borderColor = grey
        passwordText.layer.borderColor = grey
        
        usernameText.layer.cornerRadius = 8.0
        passwordText.layer.cornerRadius = 8.0
        
        let logo = UIImage(named: "ImReadyLogo")!
        logoImageView.image = logo
        
        loginBtn.layer.cornerRadius = 5.0
    }
    
    private func createAlert(title: String!, message: String!) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Oke", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

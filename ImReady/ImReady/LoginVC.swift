//
//  LoginVC.swift
//  ImReady
//
//  Created by Inholland on 12/13/17.
//  Copyright © 2017 Inholland. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    //UI elements
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var rememberMeLbl: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    //Dec & ini
    let defaultValues = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupIBObjects()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: AnyObject) {
        activateIndicator_Activity(onViewController: self, onView: view)
        let parameters: [String : String]=[
            "username":usernameText.text!,
            "password":passwordText.text!
        ]
        
        if (parameters["username"] == "" || parameters["password"] == "")
        {
            usernameText.layer.borderColor = UIColor.red.cgColor
            passwordText.layer.borderColor = UIColor.red.cgColor
            
            createAlert(title: "Er is iets fout gegaan!", message: "Vul zowel je emailadres als je wachtwoord in!")
        }
        else
        {
            loginService.login(
                Username: parameters["username"]!,
                Password: parameters["password"]!,
                doRemember: false,
                onSuccess: {
                    deactivateIndicator_Activity()
                    self.performSegue(withIdentifier: "toFutureCanvas", sender: nil)
            })
            {
                self.createAlert(title: "Er is iets fout gegaan!", message: "Gebruikersnaam of wachtwoord ongeldig!")
            }
        }
    }
    
    private func setupIBObjects() {
        usernameText.autocorrectionType = .no
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
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) {
    
    }
    
    private func createAlert(title: String!, message: String!) {
        deactivateIndicator_Activity()
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Oke", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  LoginService.swift
//  ImReady
//
//  Created by Ralph Hink on 11/01/2018.
//  Copyright © 2018 Inholland. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class LoginService {
    let apiClient: ApiClient = ApiClient()

    public func login(Username username: String,
                      Password password: String,
                      onSuccess: @escaping () -> (),
                      onFailure: @escaping () -> ()) -> () {
        
        apiClient.send(toRelativePath: "login",
                       withHttpMethod: .post,
                       withParameters: ["username": username, "password": password, "grant_type": "password"],
                       withHeaders: ["Content-Type": apiClient.ContentTypeHeader, "Accept": apiClient.AcceptHeader],
                       withEncoding: URLEncoding.httpBody,
                       onSuccessDo: { (_ data) in
                        do {

                            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                            if let error = json["error_description"] as? String {
                                print(error)
                                onFailure()
                            }
                            else {
                                LoggedInUser.currentuser.access_token = json["access_token"] as? String
                                LoggedInUser.currentuser.id = json["user_id"] as? String
                                LoggedInUser.currentuser.username = json["firstname"] as? String
                                LoggedInUser.currentuser.user_type = Role(rawValue: json["user_type"] as! String)
                                
                                onSuccess()
                            }
                        }catch {
                            onFailure()
                        }
                        
        },
                       onFailure: onFailure)
    }
    
    public func logOut() -> Bool {
        let preferences = UserDefaults.standard
        preferences.set(nil, forKey: "session")
        return true
    }
    
    public func isLoggedIn() -> Bool {
        let preferences = UserDefaults.standard
        let authtoken = preferences.string(forKey: "session")
        return authtoken != nil
    }
}

let loginService : LoginService = LoginService()

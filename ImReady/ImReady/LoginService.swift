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
import Locksmith

class LoginService {
    let apiClient: ApiClient = ApiClient()

    public func login(Username username: String,
                      Password password: String,
                      doRemember remember: Bool,
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
                                do {
                                    try Locksmith.updateData(data: ["access_token" : json["access_token"]!,
                                                                    "id" : json["user_id"]!,
                                                                    "firstname" : json["firstname"]!,
                                                                    "user_type" : json["user_type"]!],
                                                             forUserAccount: "loggedInUser")
                                }
                                catch {
                                    do {
                                        try Locksmith.saveData(data: ["access_token" : json["access_token"]!,
                                                                      "id" : json["user_id"]!,
                                                                      "firstname" : json["firstname"]!,
                                                                      "user_type" : json["user_type"]!],
                                                               forUserAccount: "loggedInUser")
                                    }
                                    catch {
                                        print("Logged in user could not be stored!")
                                    }
                                }
                                
                                if(remember) {
                                    do {
                                        try Locksmith.updateData(data: ["username" : username,
                                                                        "password" : password],
                                                                 forUserAccount: "rememberUser")
                                    }
                                    catch {
                                        do {
                                            try Locksmith.saveData(data: ["username" : username,
                                                                          "password" : password],
                                                                   forUserAccount: "rememberUser")
                                        }
                                        catch {
                                            print("Remember User function not working!")
                                        }
                                    }
                                }
                                else {
                                    do {
                                        try Locksmith.deleteDataForUserAccount(userAccount: "rememeberUser")
                                    }
                                    catch {
                                        print("No record for remember user, nothing deleted from Locksmith")
                                    }
                                }
                                
                                
                                //Safekeeping
                                //                                LoggedInUser.currentuser.access_token = json["access_token"] as? String
                                //                                LoggedInUser.currentuser.id = json["user_id"] as? String
                                //                                LoggedInUser.currentuser.username = json["firstname"] as? String
                                //                                LoggedInUser.currentuser.user_type = Role(rawValue: json["user_type"] as! String)
                                
                                onSuccess()
                            }
                        }catch {
                            onFailure()
                        }
                        
        },
                       onFailure: onFailure)
    }
    
    public func logOut(isTerminated terminated: Bool) -> Bool {
        var success: Bool = true
        let preferences = UserDefaults.standard
        preferences.set(nil, forKey: "session")
        do{
            if(!terminated) {
                try Locksmith.deleteDataForUserAccount(userAccount: "rememberUser")
            }
            try Locksmith.deleteDataForUserAccount(userAccount: "loggedInUser")
        }
        catch {
            print("Logout error: could not delete rememberUser and/or loggedInUser")
            success = false
        }
        return success
    }
    
    public func isLoggedIn() -> Bool {
        let userdef = UserDefaults.standard
        let authtoken = userdef.string(forKey: "session")
        return authtoken != nil
    }
}

let loginService : LoginService = LoginService()

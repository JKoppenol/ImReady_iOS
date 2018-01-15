//
//  ApiService.swift
//  ImReady
//
//  Created by Ralph Hink on 22/12/2017.
//  Copyright © 2017 Inholland. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class ApiClient {
    private let baseUrl: String = "https://imreadyapiv2.azurewebsites.net/api/"
    
    public let ContentTypeHeader = "application/x-www-form-urlencoded"
    public let AcceptHeader = "application/json"
    
    public func send(toRelativePath url: String,
                     withHttpMethod httpMethod: HTTPMethod,
                     withParameters parameters: [String: Any] = [:],
                     withHeaders headers: [String : String] = [:],
                     withEncoding encoding: ParameterEncoding = URLEncoding.default,
                     onSuccessDo onSuccess: @escaping (_ data: Data) -> (),
                     onFailure: @escaping () -> ()) -> () {
        print(baseUrl + url)
        
        Alamofire.request(baseUrl + url,
                          method: httpMethod,
                          parameters: parameters,
                          encoding: encoding,
                          headers: headers).responseData { response in
                            if response.error != nil {
                                print("Error: \(String(describing: response.error))")
                                onFailure()
                            }
                            
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("Response data: \(String(describing: response.data))")
                                print("Data: \(utf8Text)")
                                onSuccess(data)
                            }
        }
    }
}

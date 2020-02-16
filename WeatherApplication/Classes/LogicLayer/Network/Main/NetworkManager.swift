//
//  NetworkManager.swift
//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019 mg. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager: NSObject{
    static let sharedInstance = NetworkManager()

    let baseUrl = "https://api.openweathermap.org"
    let apiKey = "ccdb3f68256490fb5e545528262f1831"
    
    private func apiUrl() -> String{
        return "\(baseUrl)/data/2.5/"
    }

    func getRequest(url: String, parameters: Parameters?, completionHandler: @escaping (_ request: Alamofire.DataRequest, _ errorDescription: String?, _ errorCode: Int?) -> Void){
        request(url: url, method: .get, parameters: parameters, completionHandler: completionHandler)
    }
    
    private func request(url: String, method: HTTPMethod, parameters: Parameters?, completionHandler: @escaping (_ request: Alamofire.DataRequest, _ errorDescription: String?, _ errorCode: Int?) -> Void){
        var paramRequest: Parameters = [:]
        if let parameters = parameters{
            paramRequest = parameters
        }
        paramRequest["appid"] = apiKey

        let urlAddress = apiUrl().appending(url)
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        let request = Alamofire.request(urlAddress, method: method, parameters: paramRequest, encoding: encoding)
        
        request.response { (response) in
            if let error = response.error{
                completionHandler(request, error.localizedDescription, (error as NSError).code)
                return
            }
            
            request.responseObject{ (response: DataResponse<ErrorResponse>) in
                if let value = response.value, let message = value.message, let code = value.code {
                    completionHandler(request, message, Int(code))
                    return
                }
                completionHandler(request, nil, nil)
            }
        }
    }
}

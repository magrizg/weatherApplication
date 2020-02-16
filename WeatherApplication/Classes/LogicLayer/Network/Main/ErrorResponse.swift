//
//  ErrorResponse.swift
//
//  Created by Mikhail G. on 29.10.2019.
//  Copyright © 2019 mg. All rights reserved.
//


import ObjectMapper

class ErrorResponse: Mappable {
    var code: String?
    var message: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        code <- map["cod"]
        message <- map["message"]
    }
}


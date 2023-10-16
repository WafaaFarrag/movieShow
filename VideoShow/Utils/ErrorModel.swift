//
//  ErrorModel.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//

import Mapper
import Foundation

struct ErrorModel: Mappable {
    
    let code: String
    let message: String
    
    init(map: Mapper) throws {
        try code = map.from("code")
        try message = map.from("message")
    }
    
}

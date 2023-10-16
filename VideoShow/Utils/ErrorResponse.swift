//
//  ErrorResponse.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//

import Mapper

struct ErrorResponse: Mappable {
    
    let error: Bool
    let errors: [ErrorModel]
    
    init(map: Mapper) throws {
        try error = map.from("error")
        try errors = map.from("errors")
    }
    
}

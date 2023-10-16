//
//  MoyaUtils.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//

import Moya

/// JSON formatter function for NetworkLoggerPlugin
func MoyaJSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: JSONSerialization.WritingOptions.prettyPrinted)
        return prettyData
        
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

/// Extends `AccessTokenAuthorizable`, setting authorizationType to be bearer.
public extension AccessTokenAuthorizable {
    
    /// Represents the authorization header to use for requests.
    var authorizationType: AuthorizationType {
        return .bearer
    }
}

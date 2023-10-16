//
//  BaseAPI.swift
//  VideoShow
//
//  Created by Wafaa Farag on 16/10/2023.
//
import Moya

enum BaseAPI {
    case fetchVideosLinks
}

extension BaseAPI: TargetType {
    
//"https://testios4devsimp.blob.core.windows.net/blobs/links.json?sp=r&st=2023-10-16T11:10:32Z&se=2023-10-26T19:10:32Z&spr=https&sv=2022-11-02&sr=b&sig=8dHo90%2BQ7Gx2V%2BRAYOXSnLWYZCwy5VOWVV%2F3MC9o6UU%3D"
    var baseURL: URL {
        return URL(string: "https://testios4devsimp.blob.core.windows.net?sp=r&st=2023-10-16T11:10:32Z&se=2023-10-26T19:10:32Z&spr=https&sv=2022-11-02&sr=b&sig=8dHo90%2BQ7Gx2V%2BRAYOXSnLWYZCwy5VOWVV%2F3MC9o6UU%3D")!
    }
    
    var path: String {
        return "/blobs/links.json"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return nil
    }
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var validate: Bool { // Treat non 2XX response codes as error (onError)
        return true
    }
}

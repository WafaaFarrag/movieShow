//
//  HomeRepository.swift
//  VideoShow
//
//  Created by Wafaa Farag on 16/10/2023.
//

import Moya
import RxSwift

class HomeRepository {
    
    // MARK: - properties
    var api: MoyaProvider<BaseAPI>
   
    
    // MARK: - intializers
    init(api: MoyaProvider<BaseAPI>) {
        self.api = api
    }
    
    // MARK: - methods
    
    func requestApi() {
        api.request(.fetchVideosLinks) { result in
                switch result {
                case .success(let response):
                    print("\(response)")
//                    do {
//                        let decoder = JSONDecoder()
//                        decoder.dateDecodingStrategy = .formatted(Maya.iso8601Extended)
//                        let links = try decoder.decode([Link].self, from: response.data)
//                        
//                        
//                        
//                    } catch {
//                        print("Error decoding JSON: \(error)")
//                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
  
}

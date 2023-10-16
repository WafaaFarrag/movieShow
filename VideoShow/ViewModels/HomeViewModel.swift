//
//  HomeViewModel.swift
//  VideoShow
//
//  Created by Wafaa Farag on 16/10/2023.
//

import Foundation
import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift

class HomeViewModel: BaseStatefulViewModel {
    
    var api: MoyaProvider<BaseAPI>
    let provider = MoyaProvider<BaseAPI>()
    var responseOfGetAllVedios: BehaviorRelay = BehaviorRelay <[String]?> (value: nil)
    let startIndicator = PublishRelay<Bool> ()
    var count = 0
    private var currentVedioIndex = 0
    
    init(api: MoyaProvider<BaseAPI>) {
        self.api = api
    }
   
    
    func getNextVideo() -> String? {
        
        guard let arr = responseOfGetAllVedios.value , !arr.isEmpty else {
            return nil
        }
        currentVedioIndex = (currentVedioIndex + 1) % arr.count
        return arr[currentVedioIndex]
    }
    
    func getPreviousVideo() -> String? {
        guard let arr = responseOfGetAllVedios.value  , !arr.isEmpty else {
            return nil
        }
        currentVedioIndex = (currentVedioIndex - 1 + arr.count) % arr.count
        return arr[currentVedioIndex]
    }
    
    func  getAllMyDocumentsRequest() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        sendStatefulViewControllerEvent(hasContent: false, state: (true, nil ))
        api.rx.request(.fetchVideosLinks)
            .map([String].self, atKeyPath: "files", using: decoder)
            .subscribeWithDefaultErrorHandling(onSuccess: { [weak self] links in
                if !links.isEmpty {
                    
                    self?.responseOfGetAllVedios.accept(links)
                    self?.count = links.count
                    self?.sendStatefulViewControllerEvent(hasContent: true, state: (false, nil))
                } else {
                    self?.sendStatefulViewControllerEvent(hasContent: false, state: (false, nil))
                }
            }, viewModel: self).disposed(by: disposeBag)
        
    }
    
    
}

//
//  Observable+MoyaErrorHandler.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//

import RxSwift
import Moya
import Moya_ModelMapper

/// Extending Observable, adding subscribeWithDefaultErrorHandling method that has the default error handling mechanism.
extension ObservableType {
    
    /**
     Subscribe on the Observable. This subscription has the default error handling for Moya.
     - parameter onSuccess: Closure that accepts the element.
     - parameter onError: Closure that get called if error arises.
     - parameter viewModel: The ViewModel that will send the error message.
     - parameter errorMessageSize: Message size that shows the error (if found).
     - returns: Subscription object used to unsubscribe from the Observable sequence.
     */
    func subscribeWithDefaultErrorHandling(onSuccess: @escaping ((Self.Element) -> Void), onError: ((Error) -> Void)? = nil, viewModel: BaseViewModel, errorMessageSize: MessageSize = .large) -> Disposable {
        return self.subscribe(onNext: {  element in
            onSuccess(element)
        }, onError: { error in
            
            onError?(error)
            
            var errorMessage: String!
            do {
                if let errorResponse = error as? Moya.MoyaError, let errorModel = try errorResponse.response?.map(to: ErrorResponse.self) {
                    print("Error Message: \(errorModel.errors[0].message)")
                    errorMessage = errorModel.errors[0].message
                } else {
                    print("Response error: \(error.localizedDescription)")
                    errorMessage = error.localizedDescription
                }
            } catch let parseError {
                print("Parse error: \(parseError.localizedDescription)")
                errorMessage = parseError.localizedDescription
            }
            
            switch errorMessageSize {
            case .large:
                viewModel.messageEvent.accept((errorMessage, .error))
            case .lite:
                viewModel.liteMessageEvent.accept((errorMessage, .error))
            }
        })
    }
}

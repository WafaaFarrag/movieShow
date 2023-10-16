//
//  BaseViewModel.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftMessages

class BaseViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    /// Used to show a large `SwiftMessages` message, specifiying a message body and a theme.
    let messageEvent = PublishRelay<(String, Theme)>()
    /// Used to show a single line `SwiftMessages` message, specifiying a message body and a theme.
    let liteMessageEvent = PublishRelay<(String, Theme)>()
    
}

/// Enum that have two cases .large and .lite for determining SwiftyMessages message size.
enum MessageSize {
    case large
    case lite
}

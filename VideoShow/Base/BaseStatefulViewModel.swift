//
//  BaseStatefulViewModel.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//
import Foundation
import RxSwift
import RxCocoa

class BaseStatefulViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    /// Determines if there is a content for StatefulViewController, set this value before transitioning the StatefulViewController
    private(set) var hasContent = false
    /// Used to transition the StatefulViewController, specifiying the isLoading and error values, don't send states through it directly, instead use sendStatefulViewControllerEvent method.
    let
    statefulViewControllerEvent = PublishRelay<(Bool, Error?)>()
    
    // MARK: - Methods
    
    /// Used to transition the StatefulViewController, specifiying hasContent, isLoading and error values.
    func sendStatefulViewControllerEvent(hasContent: Bool, state: (Bool, Error?)) {
        self.hasContent = hasContent
        statefulViewControllerEvent.accept((state.0, state.1))
    }
    
}

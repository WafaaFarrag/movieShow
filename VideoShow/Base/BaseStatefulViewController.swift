//
//  BaseStatefulViewController.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//

import UIKit
import StatefulViewController

/// A ViewController base class that helps with StatefulViewController
class BaseStatefulViewController<VM: BaseStatefulViewModel>: BaseViewController<VM>, StatefulViewController {

    // MARK: - Properties
    
    /// Reference to errorView used to add functionality to gesture recognizers in it from within sub ViewControllers
    var failureView: ErrorView?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // Setup StatefulViewController initial state to be loading.
        startLoading(animated: false)  // setupInitialViewState()
        
        setupBinding()
        
    }
    

    
    // MARK: - Setup
    
    private func setupViews() {
        // Setup StatefulViewController placeholder views
        loadingView = LoadingView(frame: view.frame)
        emptyView = EmptyView(frame: view.frame)
        failureView = ErrorView(frame: view.frame)
        errorView = failureView
    }
    
    private func setupBinding() {
        // Subscribe to viewModel.stateTransitionEvent
        viewModel.statefulViewControllerEvent.asSignal().emit(onNext: { [weak self] (isLoading, error) in
            self?.failureView?.textLabel.text = error?.localizedDescription
            self?.transitionViewStates(loading: isLoading, error: error, animated: true)
        }).disposed(by: disposeBag)
    }
    
}

extension BaseStatefulViewController {
    
    func hasContent() -> Bool {
        return viewModel.hasContent
    }
    
    func handleErrorWhenContentAvailable(_ error: Error) {
        showMessage(body: error.localizedDescription, theme: .error)
    }
}

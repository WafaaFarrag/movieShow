//
//  BaseViewController.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftMessages

/// A ViewController base class that helps with most common functionality.
class BaseViewController<VM: BaseViewModel> : UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    var viewModel: VM! {
        didSet {
            // Bind to messageEvent
            viewModel.messageEvent.asSignal().emit(onNext: { [weak self] eventTuple in
                self?.showMessage(body: eventTuple.0, theme: eventTuple.1)
            }).disposed(by: disposeBag)
            
            // Bind to liteMessageEvent
            viewModel.liteMessageEvent.asSignal().emit(onNext: { [weak self] eventTuple in
                self?.showLiteMessage(body: eventTuple.0, theme: eventTuple.1)
            }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - Methods
    
    /// Show a large `SwiftMessages` message, specifiying a message body and a theme.
    func showMessage(body: String, theme: Theme) {
        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: 3)
        config.presentationStyle = .top
        config.presentationContext = .automatic // .window(windowLevel: UIWindowLevelAlert)
        //        config.preferredStatusBarStyle = .lightContent
        
        SwiftMessages.show(config: config) { () -> UIView in // code is always executed on the main queue
            let view = MessageView.viewFromNib(layout: .messageView) // .messageView, .statusLine
            view.configureContent(title: nil, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: { _ in SwiftMessages.hide() })
            view.configureTheme(theme, iconStyle: .light) // info, success, warning, error
            //            view.accessibilityPrefix = "warning"
            view.titleLabel?.isHidden = true
            //            view.iconImageView?.isHidden = true
            //            view.iconLabel?.isHidden = true
            view.button?.isHidden = true
            view.bodyLabel?.font = view.bodyLabel?.font.withSize(14)
            
            return view
        }
    }
    
    /// Show a single line `SwiftMessages` message, specifiying a message body and a theme.
    func showLiteMessage(body: String, theme: Theme) {
        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: 2)
        config.presentationStyle = .top
        config.presentationContext = .automatic // .window(windowLevel: UIWindowLevelAlert)
        //        config.preferredStatusBarStyle = .lightContent
        
        SwiftMessages.show(config: config) { () -> UIView in // code is always executed on the main queue
            let view = MessageView.viewFromNib(layout: .statusLine) // .messageView, .statusLine
            view.configureContent(title: nil, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: { _ in SwiftMessages.hide() })
            view.configureTheme(theme, iconStyle: .light) // info, success, warning, error
            //            view.accessibilityPrefix = "warning"
            view.titleLabel?.isHidden = true
            //            view.iconImageView?.isHidden = true
            //            view.iconLabel?.isHidden = true
            view.button?.isHidden = true
            
            return view
        }
    }
    
    
}

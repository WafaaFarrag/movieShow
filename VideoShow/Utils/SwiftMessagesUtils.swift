//
//  SwiftMessagesUtils.swift
//  VideoShow
//
//  Created by wafaa farrag on 13/10/2023.
//

import Foundation
import SwiftMessages

/// The theme enum specifies theme options
public enum MessageTheme {
    case info
    case success
    case warning
    case error
}

public enum PresentationStyle {
    case top
    case bottom
    case center
    case custom(animator: Animator)
}

final class SwiftMessagesUtils {
    
    private static let duration: Double = 2.0
    private static let fontSize = CGFloat(14)
    
    private init() {
    }
    //TODO: add different presentationStyle from base view controller
    static func showMessage(body: String, theme: MessageTheme, presentationStyle: PresentationStyle = .top, isLiteMessage: Bool = false) {
        SwiftMessages.show(config: setCommenStyleMessage(presentationStyle: presentationStyle)) { () -> UIView in
            let messageTheme = convertToMessageTheme(theme: theme)
            let view = isLiteMessage ? MessageView.viewFromNib(layout: .statusLine) : MessageView.viewFromNib(layout: .messageView)
            if !isLiteMessage {
                view.bodyLabel?.font = view.bodyLabel?.font.withSize(fontSize)
            }
            view.configureContent(title: nil, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: { _ in SwiftMessages.hide()})
            view.configureTheme(messageTheme, iconStyle: .light)
            view.titleLabel?.isHidden = true
            view.button?.isHidden = true
            return view
        }
    }
    
    private static func setCommenStyleMessage(presentationStyle: PresentationStyle) -> SwiftMessages.Config {
        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: duration)
        config.presentationStyle = convertToPresentationStyle(presentationStyle: presentationStyle)
        config.presentationContext = .automatic
        return config
    }
    
//    we use this message because we can't get row value from Theme enum inside SwiftMessages
    private static func convertToMessageTheme(theme: MessageTheme) -> Theme {
        var themeOfMessage: Theme
        switch theme {
        case .info:
            themeOfMessage = .info
        case .success:
            themeOfMessage = .success
        case .warning:
            themeOfMessage = .warning
        case .error:
            themeOfMessage = .error
        }
        return themeOfMessage
    }
    
    //    we use this message because we can't get row value from Theme enum inside SwiftMessages
    private static func convertToPresentationStyle(presentationStyle: PresentationStyle) -> SwiftMessages.PresentationStyle {
        var style: SwiftMessages.PresentationStyle
        switch presentationStyle {
        case .top:
            style = .top
        case .bottom:
            style = .bottom
        case .center:
            style = .center
        case .custom(let animator):
            style = .custom(animator: animator)
        }
        return style
    }
}


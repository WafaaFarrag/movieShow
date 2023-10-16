//
//  EmptyView.swift
//  VideoShow
//
//  Created by Wafaa Farag on 16/10/2023.
//

import UIKit

// TODO: improve this view layout and theme
class EmptyView: BasicPlaceholderView {
    
    let label = UILabel()

    override func setupView() {
        super.setupView()
        
        backgroundColor = UIColor.white

        label.text = "No Content."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(label)
        
        let views = ["label": label]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-[label]-|", options: .alignAllCenterY, metrics: nil, views: views)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|", options: .alignAllCenterX, metrics: nil, views: views)

        centerView.addConstraints(hConstraints)
        centerView.addConstraints(vConstraints)
    }
    
}

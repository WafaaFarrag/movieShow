//
//  LoadingView.swift
//  VideoShow
//
//  Created by Wafaa Farag on 16/10/2023.
//

import UIKit
import StatefulViewController
import NVActivityIndicatorView

// TODO: improve this view layout and theme
class LoadingView: BasicPlaceholderView, StatefulPlaceholderView {

    let label = UILabel()
    
    override func setupView() {
        super.setupView()
        
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(label)
        
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        let type = NVActivityIndicatorType.lineScale
        let color = UIColor.red
        let activityIndicator = NVActivityIndicatorView(frame: frame, type: type, color: color, padding: nil)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(activityIndicator)
        
        let views = ["label": label, "activity": activityIndicator]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-[activity]-[label]-|", options: [], metrics: nil, views: views)
        let vConstraintsLabel = NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: [], metrics: nil, views: views)
        let vConstraintsActivity = NSLayoutConstraint.constraints(withVisualFormat: "V:|[activity]|", options: [], metrics: nil, views: views)

        centerView.addConstraints(hConstraints)
        centerView.addConstraints(vConstraintsLabel)
        centerView.addConstraints(vConstraintsActivity)
    }
    
    

    func placeholderViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}

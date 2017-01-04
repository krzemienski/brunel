//
//  BannerView.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


final class BannerView: BaseStackView {
    
    
    // MARK: - Properties
    
    let banner = ClockBannerView()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        #if os(iOS)
            backgroundColor = UIColor.white
        #endif
        
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.addArrangedSubview(banner)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        #if os(tvOS)
            contentInsets = UIEdgeInsets(top: Constants.Layout.HalfMargin, left: 0.0, bottom: 0.0, right: 0.0)
        #endif
    }
    
}


final class ClockBannerView: BaseView {
    
    // MARK: - Properties
    
    let clock = ClockLabel()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        backgroundColor = Constants.Colors.BlueColor
        
        clock.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        clock.textAlignment = .center
        clock.textColor = UIColor.white
        addSubview(clock)
    }
    
    
    // MARK: - Layout
    
    override func setupConstraints() {
        super.setupConstraints()
        
        // Turn off autoresizing mask
        clock.translatesAutoresizingMaskIntoConstraints = false
        
        // View Dictionary
        let views = ["clock": clock]
        let metrics = Constants.Layout.Metrics
        
        // Vertical Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-HalfMargin-[clock]-HalfMargin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        // Horizontal Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-HalfMargin-[clock]-HalfMargin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
    }
    
}

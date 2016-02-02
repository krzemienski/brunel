//
//  LineDetailViewController-TV.swift
//  Brunel
//
//  Created by Aaron McTavish on 01/02/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


extension LineDetailViewController {
    
    
    // MARK: - Setup
    
    func setupTV() {
        guard let _ = lineWikipediaDetail(),
            aboutButton = underlyingView.insertAboutButton() else {
                return
        }
        
        aboutButton.addTarget(self, action: Selector("aboutButtonPressed:"), forControlEvents: .PrimaryActionTriggered)
    }
    
    
    // MARK: - Convenience
    
    func lineWikipediaDetail() -> WikipediaSearchable? {
        guard let line = detailItem else { return nil }
        
        let lineWikiDetail: WikipediaSearchable
        switch line.mode {
        case .Underground:
            guard let undergroundIndex = TFLUnderground.allValues.indexOf({ $0.description.uppercaseString == line.name.uppercaseString }) else {
                return nil
            }
            
            lineWikiDetail = TFLUnderground.allValues[undergroundIndex]
        default:
            return nil
        }
        
        return lineWikiDetail
    }
    
}

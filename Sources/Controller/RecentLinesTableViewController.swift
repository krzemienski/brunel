//
//  RecentLinesTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

import SVProgressHUD


/// Displays a table of the most recently viewed lines for quick access to their status.
final class RecentLinesTableViewController: LinesPickerBaseTableViewController {
    
    
    // MARK: - Initializers
    
    init() {
        super.init(modes: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.Titles.Recent
        
        fetchLines()
    }
    
    override func viewWillDisappear(animated: Bool) {
        SVProgressHUD.dismiss()
        
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: - Fetch Data
    
    private func fetchLines() {
        let recentLines = Settings.sharedInstance.recentLines
        
        if recentLines.isEmpty {
            let emptyLabel = UILabel()
            
            emptyLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle3)
            emptyLabel.lineBreakMode = .ByWordWrapping
            emptyLabel.numberOfLines = 0
            emptyLabel.text = "No Recent Lines"
            emptyLabel.textAlignment = .Center
            
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = nil
            
            loadingData = true
            TFLRestAPI.sharedInstance.getLineStatus(recentLines) { [weak self] lines, error in
                if let lines = lines {
                    // Extract the modes
                    var modeSet = Set<TFLModes>()
                    let recentModes = lines.map { $0.mode }
                    modeSet = modeSet.union(recentModes)
                    self?.modes = Array(modeSet).sort { $0.description < $1.description }
                    
                    self?.items = lines
                } else if let error = error {
                    print(error)
                } else {
                    print("Unknown Error")
                }
                
                self?.loadingData = false
            }
        }
    }
    
}

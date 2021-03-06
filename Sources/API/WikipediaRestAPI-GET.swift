//
//  WikipediaRestAPI-GET.swift
//  Brunel
//
//  Created by Aaron McTavish on 01/02/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation


extension WikipediaRestAPI {
    
    func getQueryTitle(_ title: String, completion: @escaping (String?, RestAPIError?) -> Void) {
        wikipedia(provider, target: .queryTitle(title: title), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                guard let pagesDictionary = resultJSON["query"]["pages"].dictionary else {
                    completion(nil, .invalidJSON(localizedDescription: "Expected `pages` dictionary."))
                    return
                }
                
                let firstKey = Array(pagesDictionary.keys)[0]
                
                guard let extract = pagesDictionary[firstKey]?["extract"].string else {
                    completion(nil, .invalidJSON(localizedDescription: "Expected `extract`."))
                    return
                }
                
                completion(extract, nil)
            } else if let error = error {
                completion(nil, error)
                return
            } else {
                completion(nil, .unknownError)
                return
            }
        })
    }
    
}

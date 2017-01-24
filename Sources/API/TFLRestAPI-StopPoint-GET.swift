//
//  TFLRestAPI-StopPoint-GET.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation


extension TFLRestAPI {
    
    func getStopPointList(_ modes: [TFLModes], completion: @escaping ([TFLLine]?, RestAPIError?) -> Void) {
        tfl(stopPointProvider, target: .stopPointList(modes: modes), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                
                print(resultJSON.rawString()!)
                
                var lines = [TFLLine]()
                guard let jsonArray = resultJSON.array else {
                    completion(nil, .invalidJSON(localizedDescription: "Expected array."))
                    return
                }
                
                
                for jsonItem in jsonArray {
                    guard let line = TFLLine(jsonObject: jsonItem) else {
                        completion(nil, .invalidJSON(localizedDescription: "Bad JSON to initialize `TFLLine`."))
                        return
                    }
                    
                    lines.append(line)
                }
                
                completion(lines, nil)
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

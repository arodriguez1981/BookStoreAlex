//
//  ResponseHandler.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias REQUEST_START = () -> ()
typealias RESPONSE_SUCCESS = (_ json: JSON) -> Array<IndexPath>?
typealias RESPONSE_FAILURE = (_ error: NSError, _ data: Data?) -> ()

class ResponseHandler {
    
    var responseHandler: JSON_RESPONSE!
    var multiPartResponseHandler: ENCODING_COMPLETED!
    var startHandler: REQUEST_START?
    var successHandler: RESPONSE_SUCCESS!
    var failureHandler: RESPONSE_FAILURE?
    
    init(startHandler: REQUEST_START?, success: @escaping RESPONSE_SUCCESS, failure: RESPONSE_FAILURE?) {
        self.startHandler = startHandler
        self.successHandler = success
        self.failureHandler = failure
        
        responseHandler = {
            response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                    self.onSuccess(json)
            case .failure(let error):
                self.onFailure(error as NSError, data: response.data)
            }
        }
        
        multiPartResponseHandler = {
            encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.validate().responseJSON(completionHandler: self.responseHandler)
            case .failure(let encodingError):
                print("Failure encoding")
                self.onFailure(encodingError as NSError, data: nil)
            }
        }
    }
    
    func onSuccess(_ json: JSON) {
        _ = successHandler(json)
    }
    
    func onFailure(_ error: NSError, data: Data?) {
        failureHandler?(error, data)
    }
    
}

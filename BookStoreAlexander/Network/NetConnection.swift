//
//  NetConnection.swift
//  BookStoreAlexander
//
//  Created by Alex Rodriguez on 7/31/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import Foundation
import Alamofire
import AFNetworking

let WS_Books = "https://www.googleapis.com/books/v1/"

//https://developers.google.com/books/docs/v1/
let API_Key = "AIzaSyAxaTG9cbvxkS3bDtbkAqNMCiQ6lx2Bwz8"

typealias JSON_RESPONSE = (_ completionHanlder: DataResponse<Any>) -> ()
typealias ENCODING_COMPLETED = (_ encodingResult: SessionManager.MultipartFormDataEncodingResult) -> ()

let tipoDispositivo = 1 // es el numero de iOS

class NetConnection: NSObject {

    fileprivate static var staticManager: SessionManager?
    static var manager: SessionManager {
        if staticManager != nil {
            return staticManager!
        }
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        staticManager = Alamofire.SessionManager(
            configuration: configuration
        )
        return staticManager!
    }
    
    class func getiOSDevelopmentBooks( _ maxResults: Int, startIndex: Int, response: ResponseHandler) {
        response.startHandler?()
        manager.request(WS_Books + "volumes?q=ios+development&maxResults=" + "\(maxResults)" + "&startIndex=" + "\(startIndex)" + "&key="+API_Key, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: response.responseHandler)
    }
    
    class func getBookDetails(_ bookId: String, response: ResponseHandler) {
        response.startHandler?()
        manager.request(WS_Books + "volumes/" + bookId, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: response.responseHandler)
    }
}


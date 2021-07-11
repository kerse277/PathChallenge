//
//  PCService.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import RxSwift
import ObjectMapper
import SwiftyJSON

typealias ServiceFailureStateAlias = (PCServiceError, PCError) -> Void

enum ResponseStatus: String {
    
    case error = "ERROR"
    case success = "SUCCESS"
    func value() ->String { return self.rawValue }

}
class PCService {
    
    var REST_URL : String = ""
    
    private static var manager  : SessionManager!
    
    public var restPath: String {
        return ""
    }
    
    init() {
        self.REST_URL = App.config.getApiUrl()! + restPath
        
        if PCService.manager == nil {
            PCService.manager = {
                let configuration: URLSessionConfiguration = {
                    let configuration = URLSessionConfiguration.default
                    configuration.httpCookieStorage = HTTPCookieStorage.shared
                    configuration.timeoutIntervalForRequest = TimeInterval(Config.timeout())
                    configuration.httpShouldSetCookies = false
                    return configuration
                }()
                return SessionManager(configuration: configuration)
            }()
        }
    }
    
    
    
    
  
    func fetchData<K:BaseDto> (functionPath : String,
                                                     parameters : Parameters,
                                                     method  : HTTPMethod = .post,
                                                     onBaseSuccess : ((_ baseObject : K) -> Void)? = nil,
                                                     onSuccess : ((_ object : K?) -> Void)? = nil,
                                                     onError : @escaping ServiceFailureStateAlias )  -> Disposable {
        
        if onBaseSuccess == nil && onSuccess == nil {
            fatalError("Response'un işlenmesi gerekmektedir.")
        }
        
        let urlAndHeaders : (String, HTTPHeaders) = getUrlAndHeaders(path: functionPath)
        
        let request = PCService.manager.request(urlAndHeaders.0  , method : method, parameters : parameters,
                                                 encoding : method == .get ? URLEncoding.default : JSONEncoding.default,
                                                 headers : urlAndHeaders.1)
            .validate()
            .responseObject { (response: DataResponse<K>) -> Void in
                switch response.result {
                case .success:

                    guard let result = response.result.value else{
                        onError(.server, App.messages.getUnknownError()) // wtf!! sth goes wrong
                        return
                    }
                    
                        
                        if  let onSuccess = onSuccess {
                            onSuccess(result) // successed case
                        }else {
                            if let baseSuccess = onBaseSuccess {
                                baseSuccess(result) // base successed case
                            }else {
                                onSuccess!(nil) // base not handled case
                            }
                        
                    }
                    
                case .failure(_):
                    onError(.network , self.handleError(of: response))
                }
        }
        
        return Disposables.create(with: {
            request.cancel()
        })
        
    }
    fileprivate func getUrlAndHeaders(path : String ) -> (url : String, headers  : HTTPHeaders) {
        let url = self.REST_URL + path
        let headers =  ["Referer":"https://developer.marvel.com/" ,
                        "Content-Type" : "application/json"]
        return (url , headers)
    }
    
    private func handleError<T>(of response : DataResponse<T> ) -> PCError {

        var message = App.messages.getUnknownError()

        if let error = response.result.error as? AFError {

            switch error {

            case .invalidURL(let url):
                print("\n\nInvalid URL: \(url) - \(error.localizedDescription)")
            case .parameterEncodingFailed(let reason):
                print("\n\nParameter encoding failed: \(error.localizedDescription)")
                print("\n\nFailure Reason: \(reason)")
            case .multipartEncodingFailed(let reason):
                print("\n\nMultipart encoding failed: \(error.localizedDescription)")
                print("\n\nFailure Reason: \(reason)")
            case .responseValidationFailed(let reason):
                print("\n\nResponse validation failed: \(error.localizedDescription)")
                print("\n\nFailure Reason: \(reason)")
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    print("\n\nDownloaded file could not be read")
                case .missingContentType(let acceptableContentTypes):
                    print("\n\nContent Type Missing: \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    print("\n\nResponse content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                case .unacceptableStatusCode(let code):
                    print("\n\nResponse status code was unacceptable: \(code)")
                }
            case .responseSerializationFailed(let reason):
                print("\n\nResponse serialization failed: \(error.localizedDescription)")
                print("\n\nFailure Reason: \(reason)")
            }
            print("\n\nUnderlying error: \(String(describing: error.underlyingError))")
        } else if let error = response.result.error as? URLError {
            message = App.messages.getUnknownError()
            print("\(#file) -> Unhandled URL error : Function : \(#line)")
        }  else if let error = response.result.error as NSError? {
            message = App.messages.getUnknownError()
            print("\(#file) -> Unhandled URL error : Function : \(#line)")
        }
        return message
    }

    
    
    
    
}


extension PCService {
}


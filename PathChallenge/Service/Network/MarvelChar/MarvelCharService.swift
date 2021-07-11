//
//  MarvelCharService.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import RxSwift
import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper
import SwiftyJSON

class MarvelCharService: PCService {
    override var restPath: String{
         return ""
     }
    
    func getCharList(request: Parameters,
                onSuccess: @escaping (PCServiceResponse<MarvelCharListDto>?) -> Void,
                onError: @escaping  ServiceFailureStateAlias) -> Disposable {
        
        return fetchData(functionPath: "/public/characters",
                         parameters : request,
                         method: .get,
                         onSuccess : onSuccess,
                         onError: onError)
    }
    
    func getCharComicsList(request: Parameters,id: String,
                onSuccess: @escaping (PCServiceResponse<MarvelCharComicsListDto>?) -> Void,
                onError: @escaping  ServiceFailureStateAlias) -> Disposable {
        
        return fetchData(functionPath: "/public/characters/" + id + "/comics",
                         parameters : request,
                         method: .get,
                         onSuccess : onSuccess,
                         onError: onError)
    }
    
}

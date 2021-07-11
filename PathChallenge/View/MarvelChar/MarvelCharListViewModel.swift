//
//  MarvelCharListViewModel.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import RxCocoa
import RxSwift

class MarvelCharListViewModel: PCUITableViewViewModel<MarvelCharDto> {
    lazy var service = MarvelCharService()
    var apiKey : String = ""
    required init() {
        super.init()
        setTitle("Char List")
        self.execute(command: .loading)
        self.apiKey = App.config.getApiKey()!
    }
    
    override func loadDataWithPage(pageNumber: Int, direction: PCPaginationDirection) {
        super.loadDataWithPage(pageNumber: 0, direction: .singlepage)
        if direction == .singlepage {
            setCurrentPageDown.onNext(pageNumber)
        }
       
        
        service.getCharList(request: ["apikey":self.apiKey,"limit":30,"offset":pageNumber], onSuccess: {(page) in
            self.pageSize = page?.data?.total ?? 0
            self.setDataAndState(page: pageNumber, list: page?.data?.results ?? [], direction: direction)
        },
                       onError : errorHandler).disposed(by: disposeBag)
    }
    
     
}

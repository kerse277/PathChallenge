//
//  MarvelCharDetailViewModel.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 11.07.2021.
//

import Foundation
import RxCocoa
import RxSwift

class MarvelCharDetailViewModel: PCViewModel {
    private var marvelCharData : MarvelCharDto?
    var service = MarvelCharService()
    var marvelCharNameText = BehaviorRelay<String>(value: "")
    var marvelCharDescText = BehaviorRelay<String>(value: "")
    var marvelCharImage = BehaviorRelay<String>(value: "")
    final var comicsItems = BehaviorRelay<[MarvelCharComicsDto]>(value: [])
    var apiKey : String = ""

    required init() {
        super.init()
        self.execute(command: .loading)
        self.apiKey = App.config.getApiKey()!

    }
    func setMarvelCharData(_ data : MarvelCharDto?)  {
        self.marvelCharData = data
        self.marvelCharNameText.accept(data?.name ?? "")
        self.marvelCharDescText.accept(data?.desc ?? "")
        self.marvelCharImage.accept((data?.thumbnail?.path ?? "") + "/standard_large." + (data?.thumbnail?.ext ?? ""))
        getComics(id: String(data?.id ?? 0))
    }
    
    func getComics(id: String) {
        
        service.getCharComicsList(request: ["apikey":self.apiKey,"limit":10,"dateRange":"2005-01-01," + PCDateFormatter.formatFilter(date: Date()),"orderBy":"onsaleDate"],id: id, onSuccess: {(page) in
            self.comicsItems.accept(page?.data?.results ?? [])
            self.execute(command: .present)
        },
                       onError : errorHandler).disposed(by: disposeBag)
      
    }
}

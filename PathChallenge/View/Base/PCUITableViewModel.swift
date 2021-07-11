//
//  PCUITableViewModel.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class PCUITableViewViewModel<T : BaseDto> : PCViewModel {
    var setCurrentPageDown =  PublishSubject<Int>()
    var setCurrentPageUp = PublishSubject<Int>()
    var currentPage = 1
    var scrollTableView = PublishSubject<Int>()
    var currentPageForNoConnection: Int = 1
    var pageSize: Int = 0
    var pageLimit = 10
    var isUpPageLoaded = false
    final var items = BehaviorRelay<[T]>(value: [])
    var pagingMap = [Int : [T]]()
    
    required init() {
        super.init()
        self.pageableActive.onNext(true)
        
    }
    
    func addPagingMapData(key:Int,value:[T]){
        pagingMap[key] = value
    }
    
    func getPagingMapData(key:Int) -> [T] {
        return pagingMap[key] ?? []
    }
    
    func removePagingMapData(key: Int){
        pagingMap.removeValue(forKey: key)
    }
    
    func clearPagingMapData(){
        pagingMap.removeAll()
    }
    
    
    
    func setDataAndState(page: Int, list: [T] ,direction: PCPaginationDirection) {
        if (direction == PCPaginationDirection.down) {
            let newList = self.items.value + list
            self.items.accept(newList)
            self.execute(command: .present)
            
        } else {
            self.items.accept(list)
            self.execute(command: .present)
            
        }
        
    }
    
}

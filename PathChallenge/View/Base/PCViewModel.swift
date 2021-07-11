//
//  PCViewModel.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

class PCViewModel : PCViewModelProtocol {
    
    let disposeBag : DisposeBag = DisposeBag()
    var isPageablePage = false
    
    var navTap = PublishSubject<Void>()
    var pageableActive = PublishSubject<Bool>()

    var _isLoading = BehaviorRelay<Bool>(value: true )
    var _toastMessage  = BehaviorRelay<String>(value: "")
    var _tapableError = BehaviorRelay<String>(value: "")
    var title = BehaviorRelay<String>(value: "")
    
    var isLoading : Observable<Bool>
    var toastMessage : Observable<String>
    var tapableError : Observable<String>
    
    
    private var _oldState: PCViewState?
    var viewStateStream = PublishSubject<PCViewState>()
    var downloadedFileUrl = BehaviorRelay<URL?>(value: nil)
    
    
    
    required init() {
        
        self.toastMessage = _toastMessage.asObservable()
        self.isLoading = _isLoading.asObservable()
        self.tapableError = _tapableError.asObservable()
        self.pageableActive.subscribe(onNext: {value in
          self.isPageablePage = value
        }).disposed(by: disposeBag)
        
        
    }
    
    var viewState: PCViewState? {
        willSet(newState) {
            _oldState = self.viewState
        }
        didSet {
            viewStateStream.onNext(self.viewState!)
        }
    }
    
    var errorHandler : ServiceFailureStateAlias {

        return { (state, error) in
            self.execute(command: .present)

        }
    }
    
    func execute(command: PCViewState, data: AnyObject? = nil) {
        viewState = command
        
        switch command {
        case .inital:
            self._isLoading.accept(true)
            loadData()
            if(isPageablePage){
                loadDataWithPage(pageNumber: 0, direction: PCPaginationDirection.singlepage)
            }

        case .loading:
            self._isLoading.accept(true)
            break
        case .present:
            _isLoading.accept(false)
        default :
            break
        }
    }
    
    func loadData()  {
        self.execute(command: .loading)
    }
    
    
    func loadDataWithPage(pageNumber:Int,direction:PCPaginationDirection)  {
        self.execute(command: .loading)
    }
    
    func showToast(_ message : String)  {
        self._toastMessage.accept(message)
    }
    
    func setTitle(_ titleText : String)  {
        self.title.accept(titleText)
    }
    
}

extension PCViewModel{
    

}




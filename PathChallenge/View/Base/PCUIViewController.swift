//
//  PCUIViewController.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import UIKit
import RxSwift
import RxAnimated
import MaterialComponents.MaterialActivityIndicator


class PCUIViewController<T : PCViewModel> : UIViewController {
    
    private lazy var loaderIndicator: MDCActivityIndicator = {
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.sizeToFit()
        activityIndicator.cycleColors = [Color.primary]
        return activityIndicator
    }()
    
    public lazy var containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    /*  Dark Mode
     override var preferredStatusBarStyle: UIStatusBarStyle {
     if #available(iOS 13.0, *) {
     return .darkContent
     } else {
     // Fallback on earlier versions
     }
     }
     */
    public let bag = DisposeBag()
    
    open var viewModel = T.init()
    
    
    var emptyViewHolder : UIView!
    
    open var observableList  : [AnyObject?] = []
    
    final override func viewDidLoad()       {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubviews(self.loaderIndicator,self.containerView)
        
        loaderIndicator.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        
        containerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        loaderIndicator.startAnimating();
        viewLoaded()
        configureBindings()
        
        
        self.viewModel.title.subscribe { (title) in
            if let pageTitle = title.element, pageTitle.count > 0 {
                self.title = pageTitle
            }
        }.disposed(by: bag)
        
        
        self.viewModel.execute(command: .inital)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for view in self.navigationController?.navigationBar.subviews ?? [] {
            view.removeFromSuperview()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    open func viewLoaded() {
        
    }
    
    open func viewAppeared() {
    }
    
    
    open func configureBindings()  {
        
        self.viewModel.viewStateStream.subscribe({ (state) in
            if let status = state.element  {
                switch(status) {
                case .loading:
                    self.loaderIndicator.startAnimating()
                    self.containerView.isHidden = true
                case .present:
                    self.loaderIndicator.stopAnimating()
                    self.containerView.isHidden = false
                case .error(let err):
                    self.showALert(message: err.message)
                    self.containerView.isHidden = false
                case .warning(let err ):
                    self.loaderIndicator.stopAnimating()
                    self.showALert(message: err.message)
                    self.containerView.isHidden = false
                default:
                    break
                }
            }
        }).disposed(by: bag)
    }
    
    
    open override func viewDidDisappear(_ animated: Bool) {
        self.observableList.forEach { (obj) in
            if let object = obj {
                NotificationCenter.default.removeObserver(object)
            }
        }
        super.viewDidDisappear(animated)
    }
    
    
}

extension UIViewController{
    
    
    
    func showConfirmationALert(title : String , message : String,
                               possitiveOptionText : String = "Evet", positiveListener : @escaping (() -> Void),
                               negativeOptionText : String = "Hayır", negativeListener : (() -> Void)? = nil)  {
        
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: possitiveOptionText, style: .default, handler: { (action) in
            positiveListener()
            alert.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: negativeOptionText, style: .default, handler: { (action) in
            if let negListener = negativeListener {
                negListener()
            }
            alert.dismiss(animated: true, completion: nil)
        }))
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        view.window?.layer.add(transition, forKey: kCATransition)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConfirmationALertWithDefaults( _ sourceView : UIView?,
                                            key : String,
                                            valueOnNeverShow : Any = true,
                                            title : String ,
                                            message : String,
                                            possitiveOptionText : String = "Tamam",
                                            positiveListener : @escaping (() -> Void),
                                            negativeOptionText : String = "Bir Daha Gösterme",
                                            negativeListener : (() -> Void)? = nil)  {
        
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let messageText = NSMutableAttributedString(
            string: message,
            attributes: [
                NSAttributedString.Key.paragraphStyle: NSParagraphStyle.default,
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        
        alert.setValue(messageText, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: negativeOptionText, style: .destructive, handler: { (action) in
            if let negListener = negativeListener {
                negListener()
            }
            // LocalStorage.saveUserRelated(key: key, value: true)
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: possitiveOptionText, style: .default, handler: { (action) in
            positiveListener()
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        alert.popoverPresentationController?.sourceView = sourceView
        
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        view.window?.layer.add(transition, forKey: kCATransition)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func showALert(title: String? = "Uyarı", message: String, actionText: String? = "Tamam", positiveListener: (() -> Void)? = nil) {
        if !(message.count > 0) {
            return
        }
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionText, style: .default, handler: { (action) in
            if let listener =  positiveListener  {
                listener()
            }
            alert.dismiss(animated: true, completion: nil)
        }))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let messageText = NSMutableAttributedString(
            string: message,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)
            ]
        )
        
        alert.setValue(messageText, forKey: "attributedMessage")
        
        present(alert, animated: true, completion: nil)
    }
    
}


extension PCUIViewController {
    
    
    
}


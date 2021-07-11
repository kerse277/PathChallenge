//
//  MarvelCharDetailViewController.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 11.07.2021.
//

import Foundation
import UIKit
import SnapKit

import NVActivityIndicatorView
import WebKit

class MarvelCharDetailViewController: PCUIViewController<MarvelCharDetailViewModel>{
    
    var isFavorite = false
    
    static func instance(of data : MarvelCharDto?) -> MarvelCharDetailViewController {
        let controller = MarvelCharDetailViewController()
        controller.marvelCharData = data
        return controller
    }
    private var marvelCharData: MarvelCharDto? = nil{
        didSet{
            self.viewModel.setMarvelCharData(self.marvelCharData)
        }
    }
    
    private lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.white
        view.layer.borderWidth = 1
        view.layer.borderColor = Color.black.cgColor
        return view
    }()
    
    private lazy var favoriteImageButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Color.primary
        imageView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe({ _ in
                do{
                    if(self.isFavorite){
                       try App.localStorage.removeFavoriteChar(id: self.marvelCharData?.id ?? 0)
                        self.favoriteImageButton.image = #imageLiteral(resourceName: "outline_favorite_border_black_36pt")
                        self.isFavorite = false
                    }else{
                        try App.localStorage.addFavoriteChar(id: self.marvelCharData?.id ?? 0)
                        self.favoriteImageButton.image = #imageLiteral(resourceName: "outline_favorite_black_36pt")
                        self.isFavorite = true
                    }
                }catch{
                    print("Local Storage Error")
                }
                

        })
        return imageView
    }()
    
    private lazy var charImage: UIImageView = {
        let imageView = UIImageView()
        imageView.makeRounded()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.build(textColor: Color.black, numberOfLines: 1, font: Font.QuickSand.bold.getFont(with: 20), aligment: .center, text: "")
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel.build(textColor: Color.black, numberOfLines: 0, font: Font.QuickSand.semibold.getFont(with: 15), aligment: .center, text: "")
        return label
    }()
    
    private lazy var comicsTitlteLabel: UILabel = {
        let label = UILabel.build(textColor: Color.black, numberOfLines: 1, font: Font.QuickSand.bold.getFont(with: 22), aligment: .left, text: "Comics")
        return label
    }()
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewLoaded() {
        
        self.containerView.addSubviews(self.bannerView,self.comicsTitlteLabel,self.tableView)
        self.bannerView.addSubviews(self.charImage,self.nameLabel,self.descLabel,self.favoriteImageButton)
        super.viewLoaded()
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        self.tableView.register(MarvelCharComicsTableItemCell.self, forCellReuseIdentifier: "marvelCharComicsTableItemCell")
        self.viewModel.comicsItems.bind(to: self.tableView.rx.items(cellIdentifier: "marvelCharComicsTableItemCell", cellType: MarvelCharComicsTableItemCell.self))
        { row , element, cell in
            cell.bind(item: element)
            cell.index = row
            cell.cellDelegate = self
        }.disposed(by : bag)
        
        if App.localStorage.getFavoriteList().contains(self.marvelCharData?.id ?? 0) {
            self.favoriteImageButton.image = #imageLiteral(resourceName: "outline_favorite_black_36pt")
            self.isFavorite = true
        }else{
            self.favoriteImageButton.image = #imageLiteral(resourceName: "outline_favorite_border_black_36pt")
            self.isFavorite = false
        }

        setBinders()
        setupLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    private func setBinders(){
        self.viewModel.marvelCharNameText.subscribe { (text) in
            if let pageText = text.element, pageText.count > 0 {
                self.nameLabel.text = pageText
            }
        }.disposed(by: bag)
        self.viewModel.marvelCharDescText.subscribe { (text) in
            if let pageText = text.element, pageText.count > 0 {
                self.descLabel.text = pageText
            }
        }.disposed(by: bag)
        self.viewModel.marvelCharImage.subscribe { (text) in
            if let pageText = text.element, pageText.count > 0 {
                self.charImage.sd_setImage(with: URL(string: pageText),placeholderImage: #imageLiteral(resourceName: "marvelph"))
            }
        }.disposed(by: bag)
        
    }
    
    func setupLayouts() {
        bannerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(1)
            $0.left.equalToSuperview().inset(1)
            $0.right.equalToSuperview().offset(1)
            
        }
        charImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        favoriteImageButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().inset(16)
            $0.width.equalTo(35)
            $0.height.equalTo(35)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(charImage.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().inset(8)
            
        }
        descLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
        comicsTitlteLabel.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().inset(8)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(comicsTitlteLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
extension MarvelCharDetailViewController: MarvelCharComicsTableItemCellDelegate {
    func click(index: Int) {
        self.showALert(title:"Description",message: self.viewModel.comicsItems.value[index].desc ?? "",actionText:"OK")
    }
    
}

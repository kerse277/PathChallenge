//
//  MarvelCharListViewController.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import UIKit
import SnapKit

import NVActivityIndicatorView
import WebKit

class MarvelCharListViewController: PCUITableViewController<MarvelCharDto,MarvelCharListViewModel>{

    private lazy var topBannerView : UIView = {
        let view = UIView()
        view.backgroundColor = Color.primary
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel.build(textColor: Color.white, numberOfLines: 2,font: Font.QuickSand.bold.getFont(with: 40), aligment: .left, text: "Marvel\nCharacter List")
        return label
    }()
    private lazy var favoriteCountLabel: UILabel = {
        let label = UILabel.build(textColor: Color.white, numberOfLines: 2,font: Font.QuickSand.semibold.getFont(with: 15), aligment: .left, text: "")
        return label
    }()
    
    override func viewLoaded() {
        self.containerView.addSubviews(self.topBannerView)
        self.topBannerView.addSubviews(self.titleLabel,self.favoriteCountLabel)
        super.viewLoaded()
        tableView.separatorStyle = .none
        tableView.delegate = nil
        tableView.dataSource = nil
        self.tableView.rx.setDelegate(self).disposed(by: bag)
        self.tableView.register(MarvelCharTableItemCell.self, forCellReuseIdentifier: "marvelCharTableItemCell")
        self.viewModel.items.bind(to: self.tableView.rx.items(cellIdentifier: "marvelCharTableItemCell", cellType: MarvelCharTableItemCell.self))
        { row , element, cell in
            cell.bind(item: element)
            cell.index = row
            cell.cellDelegate = self
        }.disposed(by : bag)
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        let countTitle = "Favorite Char Count:"
        let count = String(App.localStorage.getFavoriteList().count)
        let countText = "\(countTitle) \(count)"

        favoriteCountLabel.text = countText
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        topBannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(4)
        }
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints {
            $0.top.equalTo(topBannerView.snp.bottom).offset(8)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.bottom.equalTo(favoriteCountLabel.snp.top).offset(-8)
        }
        favoriteCountLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().inset( 8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
extension MarvelCharListViewController: MarvelCharTableItemCellDelegate {
    func click(index: Int) {
        self.show(MarvelCharDetailViewController.instance(of: self.viewModel.items.value[index]), sender: nil)
    }
    
}

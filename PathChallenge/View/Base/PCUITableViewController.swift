//
//  PCUITableViewController.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import UIKit
import SnapKit

class PCUITableViewController<K : BaseDto, T : PCUITableViewViewModel<K>> : PCUIViewController<T>, UITableViewDelegate {
    var currentPageDown = 0
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    override func viewLoaded() {
        self.containerView.addSubview(self.tableView)
        super.viewLoaded()
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        self.viewModel.setCurrentPageDown.subscribe(onNext: {value in self.currentPageDown = value}).disposed(by: bag)
        setupLayouts()
    }
    
    
    func setupLayouts() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
    }
    
    override func viewAppeared() {
        super.viewAppeared()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.items.value.count - 1 && currentPageDown < viewModel.pageSize{
            currentPageDown += 30
            viewModel.loadDataWithPage(pageNumber: currentPageDown, direction: PCPaginationDirection.down)
          
        }
        let animation = AnimationFactory.makeSlideIn(duration: 0.01, delayFactor: 0.01)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }

}

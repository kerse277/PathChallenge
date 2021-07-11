//
//  UITableView.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 11.07.2021.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}

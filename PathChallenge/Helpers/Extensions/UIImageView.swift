//
//  UIImageView.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import UIKit

extension UIImageView {

    func makeRounded() {

        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

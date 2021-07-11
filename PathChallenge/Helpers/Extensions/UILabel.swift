//
//  UILabel.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//


import Foundation
import UIKit

extension UILabel {
 public static func build(textColor: UIColor? = nil,
                     numberOfLines: Int = 0,
                     font: UIFont?,
                     aligment: NSTextAlignment? = nil,
                     text: String? = "") -> UILabel {
    let label = UILabel()
    label.textColor = textColor ?? UIColor.black
    label.numberOfLines = numberOfLines
    label.font = font
    label.textAlignment = aligment ?? NSTextAlignment.center
    label.text = text
    return label
   }
    
   
}


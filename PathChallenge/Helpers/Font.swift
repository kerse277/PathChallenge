//
//  Font.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import UIKit
public enum Font {
  
    public enum QuickSand: String {
        case regular = "Regular"
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case semibold = "SemiBold"
        public func getFont(with size: CGFloat) -> UIFont {
            let newSize = UIScreen.main.bounds.height <= 568.0 ? size - 1.0 : size
            return UIFont(name: "Quicksand-\(self.rawValue)", size: newSize)!
        }
    }
    
  
}
